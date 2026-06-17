# AMERICAN SAMOA BOTTOMFISH - INITIAL DATA HANDLING (tidyverse rewrite + logging)
# Rewritten to use tidyverse conventions (dplyr / readr / lubridate / readxl / fs)
# Logging added with glue::glue() and message().
# --------------------------------------------------------------------------------------------------------------

library(tidyverse)
library(lubridate)
library(readxl)
library(lunar)
library(fs)
library(here)
library(glue)

options(scipen = 999)

# establish root directory
root_dir <- here::here("..", "..") %>% path_norm()
dir_create(path(root_dir, "Outputs"))

set.seed(123) # reproducible random assignments

# ------------------------------------------------------------------------------
# STEP 1: read in files and initial diagnostics
# ------------------------------------------------------------------------------

a1_path <- path(root_dir, "Data", "2023_data", "a_bbs_int_flat1.csv")
a2_path <- path(root_dir, "Data", "2023_data", "a_bbs_int_flat2.csv")
a3_path <- path(root_dir, "Data", "2023_data", "a_bbs_int_flat3.csv")
a4_path <- path(root_dir, "Data", "2023_data", "a_bbs_int_flat4.csv")
a5_path <- path(root_dir, "Data", "2023_data", "PICDR-113220 BB Creel Data_all_columns.csv")
a6_path <- path(root_dir, "Data", "a_interview_bbs.rds")

message(glue("Reading files from {root_dir}/Data ..."))

aint_bbs1 <- readr::read_csv(a1_path, show_col_types = FALSE)
aint_bbs2 <- readr::read_csv(a2_path, show_col_types = FALSE)
aint_bbs3 <- readr::read_csv(a3_path, show_col_types = FALSE)
aint_bbs4 <- readr::read_csv(a4_path, show_col_types = FALSE)

aint_bbs5 <- readr::read_csv(a5_path, show_col_types = FALSE) %>%
  {
    if ("COMMON_NAME" %in% names(.)) {
      select(., -COMMON_NAME)
    } else {
      nm <- names(.)
      dup_idx <- which(duplicated(nm))
      if (length(dup_idx) > 0) select(., -all_of(nm[dup_idx])) else .
    }
  }

aint_bbs6 <- readr::read_rds(a6_path) %>% as_tibble()
aint_bbs6 <- aint_bbs6 %>% mutate(YEAR = year(SAMPLE_DATE)) %>% filter(YEAR > 2021) %>% select(-YEAR)

# convert LEN_CM to LEN_MM if present
if ("LEN_CM" %in% names(aint_bbs6)) {
  aint_bbs6 <- aint_bbs6 %>%
    mutate(LEN_MM = LEN_CM * 10, LEN_MM_TYPE = LEN_CM_TYPE) %>%
    select(-any_of(c("LEN_CM", "LEN_CM_TYPE")))
}

if (!"PRICE_LB_TYPE_FK" %in% names(aint_bbs6)) aint_bbs6 <- mutate(aint_bbs6, PRICE_LB_TYPE_FK = NA)
if (!"PRICE_LB_TYPE" %in% names(aint_bbs6)) aint_bbs6 <- mutate(aint_bbs6, PRICE_LB_TYPE = NA)

aint_bbs6 <- aint_bbs6 %>% filter(!is.na(EST_LBS))

# combine
A <- bind_rows(aint_bbs1, aint_bbs2, aint_bbs3, aint_bbs4, aint_bbs5, aint_bbs6)

message(glue("After bind_rows: {nrow(A)} rows, {n_distinct(A$INTERVIEW_PK)} unique INTERVIEW_PK, {n_distinct(A$CATCH_PK)} unique CATCH_PK"))

# drop 2021+ rows from aint_bbs4 were handled earlier (if logic needed adjust)

# create YEAR
A <- A %>% mutate(YEAR = as.numeric(year(SAMPLE_DATE)))

# Filter for bottomfishing methods (4 and 5)
before_method_n <- n_distinct(A$INTERVIEW_PK)
A <- A %>% filter(METHOD_FK %in% c(4, 5))
after_method_n <- n_distinct(A$INTERVIEW_PK)
message(glue("Filtered to METHOD_FK in (4,5): unique INTERVIEW_PK {before_method_n} -> {after_method_n}"))

# Remove incomplete interviews
if ("INCOMPLETE_F" %in% names(A)) {
  before_incomplete <- n_distinct(A$INTERVIEW_PK)
  A <- A %>% filter(INCOMPLETE_F == "F")
  after_incomplete <- n_distinct(A$INTERVIEW_PK)
  message(glue("Removed incomplete interviews: unique INTERVIEW_PK {before_incomplete} -> {after_incomplete}"))
}

# Remove CATCH_PK == "NULL" where appropriate (original logic: A <- A[CATCH_PK!="NULL"|is.na(CATCH_PK)])
before_nullcatch <- n_distinct(A$INTERVIEW_PK)
A <- A %>% filter(!(CATCH_PK == "NULL" & !is.na(CATCH_PK)))
after_nullcatch <- n_distinct(A$INTERVIEW_PK)
message(glue("Filtered NULL CATCH_PK rows (if present): unique INTERVIEW_PK {before_nullcatch} -> {after_nullcatch}"))

# Filter out strange fishing methods
bad_methods <- c("BLANK", "GLEANING", "NULL", "PALOLO FISHING", "UNKNOWN - BOAT BASED", "VERT. LONGLINE")
if ("FISHING_METHOD" %in% names(A)) {
  before_bad_methods <- n_distinct(A$INTERVIEW_PK)
  A <- A %>% filter(!FISHING_METHOD %in% bad_methods)
  after_bad_methods <- n_distinct(A$INTERVIEW_PK)
  message(glue("Filtered bad FISHING_METHOD entries: unique INTERVIEW_PK {before_bad_methods} -> {after_bad_methods}"))
}

# Collapse repeated EST_LBS measurements; keep max per grouping
key_vars <- c("INTERVIEW_PK", "CATCH_PK", "SAMPLE_DATE", "TYPE_OF_DAY",
              "INTERVIEW_TIME", "PORT_NAME", "VESSEL_REGIST_NO", "ISLAND_NAME",
              "AREA_FK", "METHOD_FK", "SPECIES_FK", "HOURS_FISHED", "NUM_GEAR", "TOT_EST_LBS")
present_key_vars <- intersect(key_vars, names(A))

before_collapse_rows <- nrow(A)
before_collapse_interviews <- n_distinct(A$INTERVIEW_PK)
A <- A %>%
  group_by(across(all_of(present_key_vars))) %>%
  summarise(EST_LBS = max(as.numeric(EST_LBS), na.rm = TRUE), .groups = "drop")
after_collapse_rows <- nrow(A)
after_collapse_interviews <- n_distinct(A$INTERVIEW_PK)
message(glue("Collapsed repeated EST_LBS rows: rows {before_collapse_rows} -> {after_collapse_rows}; unique INTERVIEW_PK {before_collapse_interviews} -> {after_collapse_interviews}"))

# add additional columns and types
A <- A %>%
  mutate(
    YEAR = as.numeric(year(SAMPLE_DATE)),
    MONTH = as.numeric(month(SAMPLE_DATE)),
    HOUR = if_else(!is.na(INTERVIEW_TIME), as.numeric(hour(INTERVIEW_TIME)), NA_real_),
    EST_LBS = as.numeric(EST_LBS),
    TOT_EST_LBS = as.numeric(TOT_EST_LBS),
    AREA_FK = as.character(AREA_FK),
    INTERVIEW_PK = as.character(INTERVIEW_PK)
  )

# season, shift, time-of-day quarter
A <- A %>%
  mutate(
    SEASON = case_when(
      MONTH %in% c(12, 1, 2) ~ "summer",
      MONTH %in% c(3, 4, 5)  ~ "fall",
      MONTH %in% c(6, 7, 8)  ~ "winter",
      MONTH %in% c(9, 10, 11) ~ "spring",
      TRUE ~ NA_character_
    ),
    SHIFT = case_when(
      HOUR >= 5 & HOUR < 14  ~ "am",
      HOUR >= 14 & HOUR < 23 ~ "pm",
      HOUR >= 23 | HOUR < 5  ~ "other",
      TRUE ~ NA_character_
    ),
    TOD_QUARTER = case_when(
      HOUR >= 0 & HOUR < 6  ~ "0000-0600",
      HOUR >= 6 & HOUR < 12 ~ "0600-1200",
      HOUR >= 12 & HOUR < 18 ~ "1200-1800",
      HOUR >= 18 & HOUR < 24 ~ "1800-2400",
      TRUE ~ NA_character_
    )
  )

# PORT_SIMPLE
A <- A %>%
  mutate(PORT_SIMPLE = if_else(PORT_NAME %in% c("ASILI", "GENERAL TUTUILA PORT", "LEONE", "VATIA"),
                               "Tutuila_Other", PORT_NAME))

# Add AREAS metadata
metadata_path <- path(root_dir, "Data", "METADATA.xlsx")
AREAS <- read_xlsx(metadata_path, sheet = "AREAS") %>%
  as_tibble() %>%
  filter(DATASET == "BBS") %>%
  select(AREA_ID, AREA_A, AREA_C) %>%
  mutate(AREA_ID = as.character(AREA_ID))

A <- A %>% left_join(AREAS, by = c("AREA_FK" = "AREA_ID"))
message(glue("Joined AREAS metadata: unique AREA_C values now: {length(unique(A$AREA_C))}"))

# assign unknown AREA_C based on ISLAND_NAME, drop Imports/Filter
before_area_assign <- n_distinct(A$INTERVIEW_PK)
A <- A %>% mutate(AREA_C = if_else(AREA_C %in% c("Unk", NA_character_), ISLAND_NAME, AREA_C)) %>% filter(AREA_C != "Imports/Filter")
after_area_assign <- n_distinct(A$INTERVIEW_PK)
message(glue("Assigned missing AREA_C and filtered 'Imports/Filter': unique INTERVIEW_PK {before_area_assign} -> {after_area_assign}"))

# add POSIX interview times and moon variables
A <- A %>%
  mutate(
    INTERVIEW_TIME_LOCAL = as.POSIXct(INTERVIEW_TIME, tz = "UTC"),
    INTERVIEW_TIME_UTC = INTERVIEW_TIME_LOCAL + hours(11),
    MOON_RADIANS = lunar.phase(as.Date(SAMPLE_DATE), shift = 11),
    MOON_DAYS = round(MOON_RADIANS * (29.53 / (2 * pi)))
  )

# add environmental data
ENV <- read_csv(path(root_dir, "Data", "Environmental_data_2025.csv"), show_col_types = FALSE) %>%
  filter(YEAR > 1987 & YEAR < 2025)
A <- A %>% left_join(ENV, by = c("YEAR", "MONTH"))
message(glue("Joined ENV data: {ncol(left_join(ENV, A))} columns (ENV merge done)."))

# add species metadata
S <- read_xlsx(metadata_path, sheet = "ALLSPECIES") %>%
  as_tibble() %>%
  select(SPECIES_PK, SCIENTIFIC_NAME, FAMILY, BMUS) %>%
  mutate(SPECIES_PK = as.character(SPECIES_PK))

A <- A %>% left_join(S, by = c("SPECIES_FK" = "SPECIES_PK"))
message(glue("Joined species metadata: unique species now: {n_distinct(A$SPECIES_FK, na.rm = TRUE)}"))

# STEP 2: basic filtering and fixes
before_bad_years <- n_distinct(A$INTERVIEW_PK)
A <- A %>% filter(!YEAR %in% c(1985, 1111))
after_bad_years <- n_distinct(A$INTERVIEW_PK)
message(glue("Filtered bad YEAR values: unique INTERVIEW_PK {before_bad_years} -> {after_bad_years}"))

# preserve original species fk column for logging and corrected field
B <- A %>% mutate(SPECIES_FK2 = SPECIES_FK)

# Count how many species==243 to be replaced
count_243 <- sum(B$SPECIES_FK == "243", na.rm = TRUE)
message(glue("SPECIES_FK == '243' occurrences to replace: {count_243}"))

# Replace 243 -> 241 and correct SCIENTIFIC_NAME if present
B <- B %>%
  mutate(
    SPECIES_FK2 = if_else(SPECIES_FK == "243", "241", SPECIES_FK2),
    SCIENTIFIC_NAME = if_else(SPECIES_FK == "243", "Pristipomoides flavipinnis", SCIENTIFIC_NAME)
  )
message(glue("Replaced SPECIES_FK 243 -> 241 in SPECIES_FK2."))

# Remove erroneous 'No Catch' records where TOT_EST_LBS > 0
before_no_catch <- n_distinct(B$INTERVIEW_PK)
if ("FAMILY" %in% names(B)) {
  B <- B %>% filter(!(FAMILY == "No Catch" & TOT_EST_LBS > 0))
}
after_no_catch <- n_distinct(B$INTERVIEW_PK)
message(glue("Removed 'No Catch' rows with TOT_EST_LBS>0: unique INTERVIEW_PK {before_no_catch} -> {after_no_catch}"))

# Remove rows where EST_LBS == 0 but TOT_EST_LBS > 0
before_zero_est <- n_distinct(B$INTERVIEW_PK)
B <- B %>% filter(!(EST_LBS == 0 & TOT_EST_LBS > 0))
after_zero_est <- n_distinct(B$INTERVIEW_PK)
message(glue("Removed EST_LBS==0 but TOT_EST_LBS>0: unique INTERVIEW_PK {before_zero_est} -> {after_zero_est}"))

# Remove interviews where TOT_EST_LBS>0 but SPECIES_FK or CATCH_PK are "NULL"
before_null_species <- n_distinct(B$INTERVIEW_PK)
B <- B %>% filter(!(TOT_EST_LBS > 0 & SPECIES_FK == "NULL"))
B <- B %>% filter(!(TOT_EST_LBS > 0 & CATCH_PK == "NULL"))
after_null_species <- n_distinct(B$INTERVIEW_PK)
message(glue("Removed TOT_EST_LBS>0 with NULL species/catch: unique INTERVIEW_PK {before_null_species} -> {after_null_species}"))

# Drop TOT_EST_LBS (as original)
B <- B %>% select(-any_of("TOT_EST_LBS"))

# STEP 4: species ID corrections (use past proportions and random per CATCH_PK assignment)
message("BEGIN species reassignment steps...")

# 4a Variola: compute proportion from 2016-2020
prop_variola_tbl <- B %>%
  group_by(YEAR, INTERVIEW_PK, CATCH_PK, SPECIES_FK, SCIENTIFIC_NAME) %>%
  summarise(EST_LBS = max(as.numeric(EST_LBS), na.rm = TRUE), .groups = "drop") %>%
  filter(YEAR > 2015 & YEAR < 2021, SPECIES_FK %in% c("220", "229")) %>%
  group_by(SPECIES_FK) %>%
  summarise(EST_LBS = sum(EST_LBS, na.rm = TRUE), .groups = "drop")

prop_louti <- prop_variola_tbl %>%
  filter(SPECIES_FK == "229") %>%
  pull(EST_LBS) %>%
  { . / (sum(prop_variola_tbl$EST_LBS, na.rm = TRUE)) } %>%
  round(3)
if (length(prop_louti) == 0 || is.na(prop_louti)) prop_louti <- 0.5
message(glue("Variola proportion (229 out of 220+229) = {prop_louti}"))

to_reassign_v <- B %>% filter(YEAR <= 2015, SPECIES_FK %in% c("220", "229")) %>% distinct(CATCH_PK)
message(glue("Variola reassignment - candidate CATCH_PK: {nrow(to_reassign_v)}"))
if (nrow(to_reassign_v) > 0) {
  assignments_v <- to_reassign_v %>% mutate(SPECIES_FK2_assign = if_else(runif(n()) <= prop_louti, "229", "220"))
  B <- B %>% left_join(assignments_v, by = "CATCH_PK") %>%
    mutate(SPECIES_FK2 = if_else(!is.na(SPECIES_FK2_assign) & YEAR <= 2015 & SPECIES_FK %in% c("220", "229"),
                                 SPECIES_FK2_assign, SPECIES_FK2)) %>%
    select(-SPECIES_FK2_assign)
  changed_v <- B %>% filter(YEAR <= 2015 & SPECIES_FK %in% c("220", "229") & SPECIES_FK != SPECIES_FK2) %>% distinct(CATCH_PK) %>% nrow()
  message(glue("Variola reassignment performed: assigned {nrow(assignments_v)} CATCH_PK, actually changed in {changed_v} CATCH_PK"))
} else {
  message("No Variola reassignment candidates found.")
}

# 4b Pristipomoides confusion (241 vs 242)
prop_pristi_tbl <- B %>%
  group_by(YEAR, INTERVIEW_PK, CATCH_PK, SPECIES_FK, SCIENTIFIC_NAME) %>%
  summarise(EST_LBS = max(as.numeric(EST_LBS), na.rm = TRUE), .groups = "drop") %>%
  filter(YEAR > 2015 & YEAR < 2022, SPECIES_FK %in% c("241", "242", "243")) %>%
  group_by(SPECIES_FK) %>%
  summarise(EST_LBS = sum(EST_LBS, na.rm = TRUE), .groups = "drop")

prop_flavi <- prop_pristi_tbl %>%
  filter(SPECIES_FK == "241") %>%
  pull(EST_LBS) %>%
  { . / (sum(prop_pristi_tbl %>% filter(SPECIES_FK %in% c("241", "242")) %>% pull(EST_LBS), na.rm = TRUE)) } %>%
  round(3)
if (length(prop_flavi) == 0 || is.na(prop_flavi)) prop_flavi <- 0.5
message(glue("Pristipomoides proportion (241 out of 241+242) = {prop_flavi}"))

to_reassign_pristi <- B %>% filter(YEAR >= 2010 & YEAR <= 2015, SPECIES_FK %in% c("241", "242")) %>% distinct(CATCH_PK)
message(glue("Pristipomoides reassignment - candidate CATCH_PK: {nrow(to_reassign_pristi)}"))
if (nrow(to_reassign_pristi) > 0) {
  assignments_pristi <- to_reassign_pristi %>% mutate(SPECIES_FK2_assign = if_else(runif(n()) <= prop_flavi, "241", "242"))
  B <- B %>% left_join(assignments_pristi, by = "CATCH_PK") %>%
    mutate(SPECIES_FK2 = if_else(!is.na(SPECIES_FK2_assign) & YEAR >= 2010 & YEAR <= 2015 & SPECIES_FK %in% c("241", "242"),
                                 SPECIES_FK2_assign, SPECIES_FK2)) %>%
    select(-SPECIES_FK2_assign)
  changed_pristi <- B %>% filter(YEAR >= 2010 & YEAR <= 2015 & SPECIES_FK %in% c("241", "242") & SPECIES_FK != SPECIES_FK2) %>% distinct(CATCH_PK) %>% nrow()
  message(glue("Pristipomoides reassignment performed: assigned {nrow(assignments_pristi)} CATCH_PK, actually changed in {changed_pristi} CATCH_PK"))
} else {
  message("No Pristipomoides reassignment candidates found.")
}

# 4c Lethrinidae in Manua (260 -> 267 proportion)
prop_emp_tbl <- B %>%
  filter(AREA_C == "Manua") %>%
  group_by(YEAR, INTERVIEW_PK, CATCH_PK, FAMILY, SPECIES_FK, SCIENTIFIC_NAME) %>%
  summarise(EST_LBS = max(as.numeric(EST_LBS), na.rm = TRUE), .groups = "drop") %>%
  filter(FAMILY == "Lethrinidae") %>%
  group_by(SPECIES_FK) %>%
  summarise(EST_LBS = sum(EST_LBS, na.rm = TRUE), .groups = "drop")

rub_est <- prop_emp_tbl %>% filter(SPECIES_FK == "267") %>% pull(EST_LBS) %>% sum(na.rm = TRUE)
denom_est <- prop_emp_tbl %>% filter(SPECIES_FK != "260") %>% summarise(sum_est = sum(EST_LBS, na.rm = TRUE)) %>% pull(sum_est)
prop_rub <- if_else(denom_est > 0, round(rub_est / denom_est, 3), 0.0)
message(glue("Lethrinidae Manua proportion for 267 = {prop_rub}"))

to_reassign_emp <- B %>% filter(AREA_C == "Manua", SPECIES_FK == "260") %>% distinct(CATCH_PK)
message(glue("Lethrinidae (260) reassignment - candidate CATCH_PK in Manua: {nrow(to_reassign_emp)}"))
if (nrow(to_reassign_emp) > 0) {
  assignments_emp <- to_reassign_emp %>% mutate(SPECIES_FK2_assign = if_else(runif(n()) <= prop_rub, "267", "260"))
  B <- B %>% left_join(assignments_emp, by = "CATCH_PK") %>%
    mutate(SPECIES_FK2 = if_else(!is.na(SPECIES_FK2_assign) & AREA_C == "Manua" & SPECIES_FK == "260",
                                 SPECIES_FK2_assign, SPECIES_FK2)) %>%
    select(-SPECIES_FK2_assign)
  changed_emp <- B %>% filter(AREA_C == "Manua" & SPECIES_FK == "260" & SPECIES_FK != SPECIES_FK2) %>% distinct(CATCH_PK) %>% nrow()
  message(glue("Lethrinidae reassignment performed: assigned {nrow(assignments_emp)} CATCH_PK, actually changed in {changed_emp} CATCH_PK"))
} else {
  message("No Lethrinidae reassignment candidates found.")
}

# Replace old species fk with corrected one and re-attach species metadata
B <- B %>%
  select(-any_of(c("SPECIES_FK", "FAMILY", "SCIENTIFIC_NAME", "BMUS"))) %>%
  rename(SPECIES_FK = SPECIES_FK2) %>%
  left_join(S, by = c("SPECIES_FK" = "SPECIES_PK"))
message(glue("Replaced SPECIES_FK with corrected values and re-joined species metadata; unique SPECIES_FK now: {n_distinct(B$SPECIES_FK)}"))

# Compute PROP_UNID per INTERVIEW_PK
sum_group <- B %>%
  filter(BMUS == "BMUS_Containing_Group") %>%
  group_by(INTERVIEW_PK) %>%
  summarise(LBS_GROUP = sum(EST_LBS, na.rm = TRUE), .groups = "drop")
sum_bmus <- B %>%
  filter(BMUS == "BMUS_Species") %>%
  group_by(INTERVIEW_PK) %>%
  summarise(LBS_BMUS = sum(EST_LBS, na.rm = TRUE), .groups = "drop")

P <- full_join(sum_group, sum_bmus, by = "INTERVIEW_PK") %>%
  replace_na(list(LBS_GROUP = 0, LBS_BMUS = 0)) %>%
  mutate(PROP_UNID = round(LBS_GROUP / (LBS_BMUS + LBS_GROUP + 1e-12), 3)) %>%
  select(INTERVIEW_PK, PROP_UNID)

before_prop_unid_na <- sum(is.na(B$PROP_UNID))
B <- B %>% left_join(P, by = "INTERVIEW_PK") %>% mutate(PROP_UNID = replace_na(PROP_UNID, 0))
after_prop_unid_na <- sum(is.na(B$PROP_UNID))
message(glue("PROP_UNID: NA before = {before_prop_unid_na}; NA after = {after_prop_unid_na}. Assigned zeros for missing."))

# Collapse data to the desired output, summing EST_LBS
collapse_vars <- c("INTERVIEW_PK", "CATCH_PK", "AREA_C", "YEAR", "SEASON", "MONTH",
                   "SAMPLE_DATE", "SHIFT", "TOD_QUARTER", "PORT_SIMPLE", "HOUR",
                   "INTERVIEW_TIME_LOCAL", "INTERVIEW_TIME_UTC", "TYPE_OF_DAY",
                   "VESSEL_REGIST_NO", "AREA_FK", "METHOD_FK", "SPECIES_FK",
                   "FAMILY", "SCIENTIFIC_NAME", "HOURS_FISHED", "NUM_GEAR",
                   "PROP_UNID", "BMUS")
present_collapse_vars <- intersect(names(B), collapse_vars)

before_final_rows <- nrow(B)
before_final_interviews <- n_distinct(B$INTERVIEW_PK)
B <- B %>%
  group_by(across(all_of(present_collapse_vars))) %>%
  summarise(EST_LBS = sum(EST_LBS, na.rm = TRUE), .groups = "drop") %>%
  arrange(SAMPLE_DATE, INTERVIEW_TIME_LOCAL, INTERVIEW_PK)
after_final_rows <- nrow(B)
after_final_interviews <- n_distinct(B$INTERVIEW_PK)
message(glue("Final collapse: rows {before_final_rows} -> {after_final_rows}; unique INTERVIEW_PK {before_final_interviews} -> {after_final_interviews}"))

# Final summary counts (overall and by METHOD_FK)
total_interviews <- n_distinct(B$INTERVIEW_PK)
method_counts <- B %>% distinct(INTERVIEW_PK, METHOD_FK) %>% count(METHOD_FK, name = "n_interviews")
message(glue("Final unique INTERVIEW_PK = {total_interviews}"))
message(glue("Interviews by METHOD_FK:\n{paste(method_counts$METHOD_FK, method_counts$n_interviews, sep='=', collapse='; ')}"))

# Save output
saveRDS(B, file = path(root_dir, "Outputs", "CPUE_A.rds"))
message(glue("Saved CPUE_A.rds to {path(root_dir, 'Outputs', 'CPUE_A.rds')}"))
# End of script
