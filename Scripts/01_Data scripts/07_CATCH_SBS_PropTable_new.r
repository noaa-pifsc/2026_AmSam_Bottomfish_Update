require(data.table); require(tidyverse); require(gridExtra); require(directlabels);require(openxlsx)
options(scipen = 999)
#set.seed(123)

# establish directories using this.path::
root_dir <- this.path::here(.. = 2)

# ----------- STEP 1: read in the complete "flatview" datafile for AmSam Shore based survey, 
#				do some data manipulation

d <- data.table(readRDS(file = file.path(root_dir, "Data", "a_interview_sbs.rds")))
R <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="AREAS")   );  R <- R[DATASET=="SBS"]
R <- select(R,AREA_ID,AREA_NAME,AREA_C)
M <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="METHODS") );  M <- M[DATASET=="SBS"]
M <- select(M,METHOD_ID,METHOD_C)

setnames(d, "EST_WHOLE_LBS", "EST_LBS")

d$YEAR      <- year(d$SAMPLE_DATE)
d$ROUTE_FK  <- as.character(d$ROUTE_FK)
d$EST_LBS   <- as.numeric(d$EST_LBS)
d$METHOD_FK <- as.character(d$METHOD_FK)
M$METHOD_ID <- as.character((M$METHOD_ID))

# Only use new years of data
d_sub <- d[YEAR>2021]

# Remove P. zonatus sightings from shore-based catch. This species is not catchable form shore (confirmed by fishers)
d_sub <- d_sub[SPECIES_FK!=245] #3 after 2021

# Simplify gears and routes
d_sub <- merge(d_sub,R,by.x=c("ROUTE_FK","ROUTE_NAME"),by.y=c("AREA_ID","AREA_NAME"),all.x=T)
d_sub <- merge(d_sub,M,by.x="METHOD_FK",by.y="METHOD_ID",all.x=T)

# Simplify dataset
d_sub <- d_sub[,list(EST_LBS=max(EST_LBS)),by=list(INTERVIEW_PK,CATCH_PK,YEAR,SPECIES_FK)]

# This step doesn't matter for new data bc it is for years before 2015
# # calculate proportion of Variola louti vs albimarginata for Years > 2015
# Prop.Variola <- D[,list(EST_LBS=max(EST_LBS)),by=list(YEAR,INTERVIEW_PK,CATCH_PK,SPECIES_FK)] #use old dataset so getting proportion for years between 2016 and 2021
# Prop.Variola <- Prop.Variola[YEAR>2015&(SPECIES_FK=="220"|SPECIES_FK=="229"),list(EST_LBS=sum(EST_LBS)),by=list(SPECIES_FK)]
# Prop.Louti.new   <- Prop.Variola[SPECIES_FK=="229"]$EST_LBS/(Prop.Variola[SPECIES_FK=="220"]$EST_LBS+Prop.Variola[SPECIES_FK=="229"]$EST_LBS) #8.9/16.6
# Prop.Louti.new   <- round(Prop.Louti.new,3) #.539 for years 2015-2024

# For all interview records (using CATCH_PK variable) of V. louti or albimarginata for years <= 2015, randomly assign record as "V. louti" proportionally to Prop.Louti (all fish in an interview)

# d_sub$SPECIES_FK2      <- d_sub$SPECIES_FK # Create a "corrected" SPECIES_FK2 field
# CATCH_PK.list      <- unique(d_sub[YEAR<=2015]$CATCH_PK) 
# for (i in 1:length(CATCH_PK.list)){
  
#   aCatch   <- d_sub[CATCH_PK==CATCH_PK.list[i]]
#   aSpecies <- aCatch[1,SPECIES_FK] # Just check first line of the CATCH_PK (CATCH_PK is at the species level, so all lines should be the same species)
  
#   if(aSpecies=="220"|aSpecies=="229"){
    
#     if(runif(n=1,0,1)<=Prop.Louti.new){    
#       d_sub[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "229"
#     } else {
#       d_sub[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "220"  
#     }
#   }
# }	

# Test.d <- d_sub[,list(EST_LBS=max(EST_LBS)),by=list(YEAR,INTERVIEW_PK,CATCH_PK,SPECIES_FK2)]
# Test.d <- Test.d[YEAR<=2015&(SPECIES_FK2=="220"|SPECIES_FK2=="229"),list(EST_LBS=sum(EST_LBS)),by=list(SPECIES_FK2)]
# Prop.Louti; Test.d[SPECIES_FK2=="229"]$EST_LBS/sum(Test.d$EST_LBS)

# Remove old species unique ID with the corrected one
# d_sub <- select(d_sub,-SPECIES_FK)
# setnames(d_sub,"SPECIES_FK2","SPECIES_FK")

# ============= Calculate species proportion table for shore-based surveys (see 02_BBS_proptable code)=============================

# Append species group association table
SKEY            <- data.table(  read.xlsx(paste0(root_dir,"/Data/METADATA.xlsx"),sheet="ALLSPECIES")  )
SKEY$SPECIES_PK <- as.integer(SKEY$SPECIES_PK)
SKEY            <- SKEY[,-(2:7)]
d_sub               <- merge(d_sub,SKEY,by.x="SPECIES_FK",by.y="SPECIES_PK")

# Define the time PERIOD used to calculate species proportions
d_sub$PERIOD <- 2025 # Single period going from 1990 to 2025 (2025 doesn't mean anything itself)

# Save d_sub then combine it with D in 07_CATCH_SBS_PropTable.r
write.csv(d_sub, file.path(root_dir, "Outputs", "SBS_d_sub.csv"), row.names = F)
