#  PRELIMINARIES
require(tidyverse); require(this.path); require(data.table); require(lunar); require(openxlsx);

options(scipen=999)		              # this option just forces R to never use scientific notation
root_dir <- this.path::here(.. = 2) # establish directories using this.path
dir.create(paste0(root_dir,"/Outputs"),showWarnings=F)
#set.seed(123)


#New data up to 2024
aint_bbs6 <- readr::read_rds(fs::path(root_dir, "Data", "a_interview_bbs.rds"))
aint_bbs6 <- as.data.table(aint_bbs6)


aint_bbs6$YEAR <- year(aint_bbs6$SAMPLE_DATE)
aint_bbs6      <- aint_bbs6[YEAR > 2015]

# convert LEN_CM column to LEN_MM to match format of other data.tables
aint_bbs6$LEN_MM      <- (aint_bbs6$LEN_CM)*10
aint_bbs6$LEN_MM_TYPE <- aint_bbs6$LEN_CM_TYPE 
aint_bbs6             <- select(aint_bbs6, -c(LEN_CM, LEN_CM_TYPE))

# adding dummy columns so ncols matches with other data.tables
# should be ok bc these columns aren't used for anything later on
aint_bbs6$PRICE_LB_TYPE_FK <- NA
aint_bbs6$PRICE_LB_TYPE    <- NA

# remove 9 rows of incomplete interview info, SCIENTIFIC_NAME COMMON_NAME LOCAL_NAME LEN_MM EST_LBS all NA
aint_bbs6 <- aint_bbs6 %>% filter(!is.na(EST_LBS)) 

A <- aint_bbs6

A <- A %>% group_by(INTERVIEW_PK,YEAR,ISLAND_NAME,METHOD_FK,SPECIES_FK,LEN_MM) %>% 
  summarize(N=n(),.groups="drop_last") %>%
  filter(LEN_MM>0) %>% 
  summarize(N=n(),.groups="drop")

# Filter for the two bottomfishing methods 
A <- A %>% filter(METHOD_FK %in% c(4,5))

# Check number of length obs per species

L <- A %>% filter(SPECIES_FK %in% c(241,245,247,248,249)) %>%
  mutate(SPECIES_NAME=SPECIES_FK %>% 
           recode_values(
             241 ~ "PRFL",
             245 ~ "PRZO",
             247 ~ "APRU",
             248 ~ "ETCO",
             249 ~ "ETCA")) %>%
  group_by(YEAR,ISLAND_NAME,SPECIES_NAME) %>%
  summarize(N=sum(N),.groups="drop") %>% 
  pivot_wider(id_cols=YEAR:ISLAND_NAME,names_from=SPECIES_NAME,values_from=N,values_fill=0)

# Check the number of interviews by 6 bmus species
B <- A %>% group_by(YEAR,ISLAND_NAME,SPECIES_FK,METHOD_FK,INTERVIEW_PK) %>% 
  summarize(N=sum(N),.groups="drop")

# How many "bottomfish" and "bot/trol mixed" interviews total.
TOT <- B %>% mutate(METHOD_NAME=METHOD_FK %>% 
                      recode_values(
                        4 ~ "Bottomfishing",
                        5 ~ "Btm/Trol mixed"
                      )) %>% 
  group_by(YEAR,ISLAND_NAME,METHOD_NAME,INTERVIEW_PK) %>% 
  summarize(N=sum(N),.groups="drop_last") %>% 
  summarize(N=n(),.groups="drop")  %>% 
  pivot_wider(id_cols=c("YEAR","METHOD_NAME"),names_from=ISLAND_NAME,values_from=N,values_fill=0)

# How many interviews per species x year
SP <- B %>% filter(SPECIES_FK %in% c(241,245,247,248,249)&METHOD_FK==4) %>%
  mutate(SPECIES_NAME=SPECIES_FK %>% 
           recode_values(
             241 ~ "PRFL",
             245 ~ "PRZO",
             247 ~ "APRU",
             248 ~ "ETCO",
             249 ~ "ETCA")) %>% 
  group_by(YEAR,SPECIES_NAME,INTERVIEW_PK) %>% 
  summarize(N=sum(N),.groups="drop_last") %>% 
  summarize(N=n(),.groups="drop") %>% 
  pivot_wider(id_cols=YEAR,names_from=SPECIES_NAME,values_from=N,values_fill=0)

# Write to Excel

sheet.list <- list("Tot_Num_Intrvw"=TOT,"Num_Intrvw_Species"=SP,"Length_Obs"=L)

write.xlsx(sheet.list,file=fs::path(root_dir,"Outputs","Summary","Interview_info.xlsx"))










