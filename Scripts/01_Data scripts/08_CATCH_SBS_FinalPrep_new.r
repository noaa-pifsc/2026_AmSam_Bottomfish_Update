require(data.table); require(tidyverse); require(gridExtra); require(directlabels);require(openxlsx)
options(scipen = 999)

# establish directories using this.path::
root_dir <- this.path::here(.. = 2)

# Read in the expanded landings data
d <- data.table(readRDS(file.path(root_dir, "Data", "a_catch_sbs.rds")))
R <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="AREAS")   );  R <- R[DATASET=="SBS"]
R <- select(R,AREA_ID,AREA_C)
M <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="METHODS") );  M <- M[DATASET=="SBS"]
M <- select(M,METHOD_ID,METHOD_C)
S <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="ALLSPECIES")   )
S <- select(S,SPECIES_PK,SCIENTIFIC_NAME,FAMILY)
S$SPECIES_PK <- as.character(S$SPECIES_PK)
S$SPECIES_PK <- paste0("S",S$SPECIES_PK)
S            <- select(S,SPECIES_PK,FAMILY,SCIENTIFIC_NAME)

R$AREA_ID   <- as.character(R$AREA_ID)
M$METHOD_ID <- as.character((M$METHOD_ID))

# follow Toby's instructions to break the unique key SPC_PK into the interview details we need
#	watch out- this is a little different from the BBS. See "american samoa SB mysql formulas.docx":
#		SPC_PK: The private key associated with a particular species catch expansion. 
#		Consists of 14 characters of the form rryyCYPdmmssss, determined as:
#			(1,2) rr: Two digits for ROUTE_FK, with leading zeros if necessary
#			(3,4) yy: Two digits for YEAR, calculated as the number of years after 1947
#			(5,6) CY: 
#			(7) P: A single capital letter for the time period (AM_PM), either ?D? for day or ?N? for night
#			(8) d: A single digit for TYPE_OF_DAY, either 1 for weekday or 2 for weekend/holiday
#			(9,10) mm: Two digits for METHOD_FK, with leading zeros if necessary
#			(11,14) ssss: Four digits for SPECIES_FK, with leading zeros if necessary

d <- mutate(d, YEAR = as.numeric(substr(SPC_PK,3,4)), METHOD = substr(SPC_PK,9,10), 
               ROUTE = substr(SPC_PK,1,2), TYPE = substr(SPC_PK,8,8), 
               DAYNIGHT = substr(SPC_PK,7,7))

d$YEAR                           <- d$YEAR+1947
d$SPECIES_FK                     <- paste0("S",d$SPECIES_FK)

# Remove earlier years of data
d <- d[YEAR > 2021]

# Simplify gears and routes
d <- merge(d,R,by.x="ROUTE",by.y="AREA_ID",all.x=T)
d <- merge(d,M,by.x="METHOD",by.y="METHOD_ID",all.x=T)
d <- merge(d,S,by.x="SPECIES_FK",by.y="SPECIES_PK")

# rename duplicate group SPECIES_FK in cases of complete union:
d[SPECIES_FK == "S109"]$SPECIES_FK <- "S110"  # Jacks and Trevallies

# Select a reduced number of fields and sum catch in these
d <- d[,list(EXP_LBS=sum(EXP_LBS),VAR_EXP_LBS=sum(VAR_EXP_LBS)),by=list(SPECIES_FK,YEAR,AREA_C)]

write.csv(x = d, file = file.path(root_dir, "Data", "SBS_d_update.csv"), 
row.names = FALSE)

