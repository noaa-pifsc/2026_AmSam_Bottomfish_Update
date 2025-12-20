root_dir <- this.path::here(.. = 2) # establish directories using this.path
A_new <- readr::read_rds(fs::path(root_dir,"Data","a_interview_bbs.rds"))
load(file.path(root_dir, "Data", "pfl_pk.RDS"))
A_new$YEAR <- as.numeric(year(A_new$SAMPLE_DATE))
# Check for missing columns
A_names <- colnames(A)
A_new_names <- colnames(A_new)
setdiff(A_names, A_new_names) #"PRICE_LB_TYPE_FK" "LEN_MM"           "LEN_MM_TYPE"      "PRICE_LB_TYPE"
#None of the missing columns are in 01_CPUE_BBS_InitPrep.R script so should be ok

# Subsetting so only contains the old years (up to 2021) for initial comparisons
A_new_sub <- A_new %>% filter(YEAR <= 2021) %>% as.data.table()
length(unique(A_new_sub[YEAR>=2016&(METHOD_FK==4|METHOD_FK==5)]$INTERVIEW_PK)) 

A_new_sub <- A_new_sub[METHOD_FK==4|METHOD_FK==5] ; length(unique(A_new_sub[YEAR>=2016&METHOD_FK==4]$INTERVIEW_PK))

# -- 99 interviews flagged as incomplete
A_new_sub <- A_new_sub[INCOMPLETE_F=="F"]; length(unique(A_new_sub[YEAR>=2016&METHOD_FK==4]$INTERVIEW_PK))

# picked a random interview_pk and made sure there are the same number of rows in each dataset
A %>% filter(INTERVIEW_PK == 211103174704) %>% nrow()
A_new_sub %>% filter(INTERVIEW_PK == 211103174704) %>% nrow()

# -- Filter some strange or missing gear types (removes 19 trips overall, minor filter impact)
A_new_sub <- A_new_sub[FISHING_METHOD!="BLANK"&FISHING_METHOD!="GLEANING"&FISHING_METHOD!="NULL"&
        FISHING_METHOD!="PALOLO FISHING"&FISHING_METHOD!="UNKNOWN - BOAT BASED"&FISHING_METHOD!="VERT. LONGLINE"]
length(unique(A_new_sub[YEAR>=2016&METHOD_FK==4]$INTERVIEW_PK))

A_new_sub <- A_new_sub[,list(EST_LBS=max(EST_LBS)),by=list(INTERVIEW_PK,CATCH_PK,SAMPLE_DATE,TYPE_OF_DAY,
                                            INTERVIEW_TIME,PORT_NAME,VESSEL_REGIST_NO,ISLAND_NAME,AREA_FK,METHOD_FK,SPECIES_FK,HOURS_FISHED,NUM_GEAR,TOT_EST_LBS)]

A_new_sub$YEAR         <- as.numeric(year(A_new_sub$SAMPLE_DATE))
A_new_sub$MONTH        <- as.numeric(month(A_new_sub$SAMPLE_DATE))
A_new_sub$HOUR         <- as.numeric(hour(A_new_sub$INTERVIEW_TIME))
A_new_sub$EST_LBS      <- as.numeric(A_new_sub$EST_LBS)
A_new_sub$TOT_EST_LBS  <- as.numeric(A_new_sub$TOT_EST_LBS)
A_new_sub$AREA_FK      <- as.character(A_new_sub$AREA_FK)
A_new_sub$INTERVIEW_PK <- as.character(A_new_sub$INTERVIEW_PK)

# season: 12-1-2 = summer, 3-4-5 = fall, 6-7-8 = winter, 9-10-11 = spring
A_new_sub$SEASON <- "NA"
A_new_sub[MONTH>=12|MONTH<=2]$SEASON <- "summer"
A_new_sub[MONTH>=3&MONTH<=5]$SEASON  <- "fall"
A_new_sub[MONTH>=6&MONTH<=8]$SEASON  <- "winter"
A_new_sub[MONTH>=9&MONTH<=11]$SEASON <- "spring"

# Shifts: "morning shift" is 0500-1330, evening shift is 1400-2230 or try 6-hour blocks
A_new_sub$SHIFT <- "NA"
A_new_sub[HOUR >= 5  &  HOUR < 14]$SHIFT <- 'am' 
A_new_sub[HOUR >= 14 & HOUR < 23]$SHIFT  <- 'pm' 
A_new_sub[HOUR >= 23 | HOUR < 5]$SHIFT   <- 'other' 

# Time of Day quarter
A_new_sub$TOD_QUARTER <- "NA"
A_new_sub[HOUR >= 0 & HOUR < 6]$TOD_QUARTER   <- '0000-0600' 
A_new_sub[HOUR >= 6 & HOUR < 12]$TOD_QUARTER  <- '0600-1200' 
A_new_sub[HOUR >= 12 & HOUR < 18]$TOD_QUARTER <- '1200-1800' 
A_new_sub[HOUR >= 18 & HOUR < 24]$TOD_QUARTER <- '1800-2400' 

# Reclassify the non-main ports= ASILI, GENERAL TUTUILA PORT, LEONE, VATIA
A_new_sub$PORT_SIMPLE <- A_new_sub$PORT_NAME
A_new_sub[PORT_NAME == 'ASILI'|PORT_NAME == 'GENERAL TUTUILA PORT'|PORT_NAME == 'LEONE'|PORT_NAME == 'VATIA']$PORT_SIMPLE <- "Tutuila_Other" 

A_new_sub_order <- A_new_sub %>% arrange(SAMPLE_DATE)

# Add more detailed area information
AREAS <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="AREAS")   )
AREAS <- AREAS[DATASET=="BBS"]
AREAS <- select(AREAS,AREA_ID,AREA_A,AREA_C)
AREAS$AREA_ID <- as.character(AREAS$AREA_ID)
A_area_sub     <- merge(A_new_sub,AREAS,by.x="AREA_FK",by.y="AREA_ID",all.x=T); length(unique(A_area_sub$INTERVIEW_PK)) #missing 140 interviews at this point

#### PAUSE for checking against old data ######
missing_ints <- setdiff(unique(A$INTERVIEW_PK), unique(A_area_sub$INTERVIEW_PK))
missing_inits_b <- setdiff(unique(A_area_sub$INTERVIEW_PK), unique(A$INTERVIEW_PK))

# 17 years have different numbers of unique INTERVIEW_PK
A_sum <- A %>% filter(YEAR >= 1986) %>% group_by(YEAR) %>% summarise(N_ints = n_distinct(INTERVIEW_PK))
A_area_sub %>% group_by(YEAR) %>% summarise(N_ints = n_distinct(INTERVIEW_PK)) %>% left_join(A_sum, by = "YEAR") %>% mutate(D = N_ints.x - N_ints.y) %>% filter(D != 0)
###########################################################

length(unique(A_area_sub[AREA_FK==0|AREA_FK==99|AREA_FK==100|is.na(AREA_C)&YEAR>=2016]$INTERVIEW_PK)) #138 interviews can be salvaged by assigning the island to the area
A_area_sub[AREA_C=="Unk"|is.na(AREA_C)]$AREA_C <- A_area_sub[AREA_C=="Unk"|is.na(AREA_C)]$ISLAND_NAME
A_area_sub <- A_area_sub[AREA_C!="Imports/Filter"]; length(unique(A_area_sub$INTERVIEW_PK))

A_area_sub <- mutate(A_area_sub, INTERVIEW_TIME_LOCAL = as.POSIXct(INTERVIEW_TIME, tz='UTC'))
A_area_sub <- mutate(A_area_sub, INTERVIEW_TIME_UTC = INTERVIEW_TIME_LOCAL + 11*60*60)
A_area_sub <- mutate(A_area_sub, MOON_RADIANS = lunar.phase(as.Date(SAMPLE_DATE), shift = 11))
A_area_sub <- mutate(A_area_sub, MOON_DAYS = round(MOON_RADIANS* (29.53/(2*pi)) ,digits=0) )  #  2pi radians = 29.53 days, so...

   # Add some large-scale environmental indices
ENV  <- read.xlsx(paste0(root_dir, "/Data/Environmental data.xlsx"))
A_area_sub    <- merge(A_area_sub,ENV,by=c("YEAR","MONTH"),all.x=T)

# Add some species-specific fields
S <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="ALLSPECIES")   )
S <- select(S,SPECIES_PK,SCIENTIFIC_NAME,FAMILY,BMUS)
S$SPECIES_PK <- as.character(S$SPECIES_PK)
A_area_sub$SPECIES_FK <- as.character(A_area_sub$SPECIES_FK)
A_area_sub       <- merge(A_area_sub,S,by.x="SPECIES_FK",by.y="SPECIES_PK",all.x=T); length(unique(A_area_sub$INTERVIEW_PK))

A_area_sub <- A_area_sub[YEAR != 1985] # Incomplete year
A_area_sub <- A_area_sub[YEAR != 1111] # Database artefact
length(unique(A_area_sub[YEAR>=2016&METHOD_FK==4]$INTERVIEW_PK))

#  ----------------------------------------------
#	241 'Pristipomoides flavipinnis' has local name "Palu sina (Yelloweye Snapper)"
#	243 'Pristipomoides rutilans' has local name "Palu sina (Yelloweye Opakapaka)"
#	247 'Aphareus rutilans', local name "Palu gutusiliva, Palu makomako"
# Problem: Pristipomoides rutilans is not a valid scientific name. In 2019 assessment and 2022 data report, we assumed P. rutilans = A. rutilans.
# However, it seems most likely that P. rutilans was actually P. flavipinnis, given they share the local name "palu sina" 
#	Fishermen workshops confirmed the name Palu-sina for P. flavipinnis, we concluded 'P. rutilans' (SPECIES_PK 243) is P. flavipinnis 
# Replace SPECIES_FK 243 (Pristipomoides rutilans) with 241 (Pristipomoides flavipinnis)
   
   ## Re-identifying records as P.fl instead of A. rutilans
   A_area_sub$INT_CAT_PK <- paste0(A_area_sub$INTERVIEW_PK, "_", A_area_sub$CATCH_PK)
   pfl.int.cat.pk <- paste0(pfl.intpk, "_", pfl.catpk)
#    pfl_sub <- A_area_sub[INT_CAT_PK %in% pfl.int.cat.pk]
#    setdiff(pfl.int.cat.pk, pfl_sub$INT_CAT_PK) # still 78 missing P.fl interviews missing
   A_area_sub[INT_CAT_PK %in% pfl.int.cat.pk]$SCIENTIFIC_NAME <- "Pristipomoides flavipinnis"  
   A_area_sub[INT_CAT_PK %in% pfl.int.cat.pk]$SPECIES_FK      <- 241 

 # -- 7 CATCH_PK where COMMON_NAME = 'No Catch' and TOT_EST_LBS > 0. In all instances, there were other species caught and recorded within these interviews.
 # So, eliminate the erroneous 'no catch' CATCH_PK, but keep remainder of interview
  A_area_sub <- A_area_sub[!(FAMILY=="No Catch"&TOT_EST_LBS>0)]

 # -- 146 records where EST_LBS = 0 but TOT_EST_LBS > 0 (i.e. there's no species-specific catch but the total catch for interview is > 0)
  A_area_sub <- A_area_sub[!(EST_LBS==0&TOT_EST_LBS>0)]

 # -- 11 interviews where TOT_EST_LBS > 0 but most other fields, including SPECIES_FK and CATCH_PK are NULL
  A_area_sub <- A_area_sub[!(TOT_EST_LBS>0&SPECIES_FK=="NULL")]
  A_area_sub <- A_area_sub[!(TOT_EST_LBS>0&CATCH_PK=="NULL")]
  
  # Drop the TOT_EST_LBS variable
  A_area_sub <- select(A_area_sub,-TOT_EST_LBS)
  
  # Check that covariates don't have NAs or other weird values
  table(A_area_sub$TYPE_OF_DAY,exclude=NULL)
  table(A_area_sub$MONTH,exclude=NULL)
  table(A_area_sub$AREA_C)
  
  # Check the range of catch values
  A_area_sub %>% filter(is.na(EST_LBS)) %>% nrow() # have 44 rows of NA EST_LBS
  range(A_area_sub$EST_LBS, na.rm = T)
  A_area_sub[EST_LBS==687.348] # 10 hours fishing, unidentified snappers (Code 230)
  
  
  # WATCH OUT- there were 779 interviews, 3105 catch records, that included NUM_KEPT = 0 but catch weight was recorded
	# skimming through, it is obvious that the number of fish that must have been included in these weights was greater than 1.
	# SO- ALWAYS USE CAUTION when talking about numbers: NUM_KEPT IS NOT a dependable record of number of fish caught.
	# for weight-based CPUE, these interviews can be used.
	# For anything numbers or weight per fish based, consider using records by SIZE_PK only, and at the least, exclude these interviews.

#  --------------------------------------------------------------------------------------------------------------
#  STEP 4: update B to address some species identification issues.

# ----- 4a. Variola louti and Variola albimarginata have been confused between 1986-2015. Some fishermen in both workshops
#		indicated that they didn't distinguish between the white-tail and yellow-tail groupers. In Tutuila, they call the
#		yellow tail (louti) velo, and they call the white tail (albimarginata) papa. However, it seems in Manu'a both species
#		are called velo. 'papa' is totally different (the tomato grouper, Cephalopholis sonnerati).
#		We assume 2016-2020 BBS species identifications are reliable

  B_new <- A_area_sub

# calculate proportion of Variola louti vs albimarginata for Years > 2015
	Prop.Variola_new <- B_new[,list(EST_LBS=max(EST_LBS)),by=list(YEAR,INTERVIEW_PK,CATCH_PK,SPECIES_FK,SCIENTIFIC_NAME)]
	Prop.Variola_new <- Prop.Variola_new[YEAR>2015&(SPECIES_FK=="220"|SPECIES_FK=="229"),list(EST_LBS=sum(EST_LBS)),by=list(SPECIES_FK,SCIENTIFIC_NAME)]
	Prop.Louti_new   <- Prop.Variola_new[SPECIES_FK=="229"]$EST_LBS/(Prop.Variola_new[SPECIES_FK=="220"]$EST_LBS+Prop.Variola_new[SPECIES_FK=="229"]$EST_LBS)
  Prop.Louti_new   <- round(Prop.Louti_new,3) #same as old data
	
# For all interview records (using CATCH_PK variable) of V. louti or albimarginata for years <= 2015, randomly assign record as "V. louti" proportionally to Prop.Louti (all fish in an interview)

B_new$SPECIES_FK2      <- B_new$SPECIES_FK # Create a "corrected" SPECIES_FK2 field
CATCH_PK.list      <- unique(B_new[YEAR<=2015]$CATCH_PK)
# remove NA catch_pk 
CATCH_PK.list <- CATCH_PK.list[-1]
for (i in 1:length(CATCH_PK.list)){
  
  aCatch   <- B_new[CATCH_PK==CATCH_PK.list[i]]
  aSpecies <- aCatch[1,SPECIES_FK] # Just check first line of the CATCH_PK (CATCH_PK is at the species level, so all lines should be the same species)
  
  if(aSpecies=="220"|aSpecies=="229"){
    
    if(runif(n=1,0,1)<=Prop.Louti_new){    
    B_new[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "229"
    } else {
    B_new[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "220"  
    }
  }
}	

# ----- 4b. Pristipomoides filamentosus and P. flavipinnis were confused between 2010-2015. Assume 2016-2021 species is reliable.
 		 
# calculate proportion of P. filamentosus vs P. flavipinnis for Years > 2015

Prop.Pristi_new <- B_new[,list(EST_LBS=max(EST_LBS)),by=list(YEAR,INTERVIEW_PK,CATCH_PK,SPECIES_FK,SCIENTIFIC_NAME)]
Prop.Pristi_new <- Prop.Pristi_new[YEAR>2015&(SPECIES_FK=="241"|SPECIES_FK=="242"),list(EST_LBS=sum(EST_LBS)),by=list(SPECIES_FK,SCIENTIFIC_NAME)]
Prop.Flavi_new  <- Prop.Pristi_new[SPECIES_FK=="241"]$EST_LBS/(Prop.Pristi_new[SPECIES_FK=="241"]$EST_LBS+Prop.Pristi_new[SPECIES_FK=="242"]$EST_LBS)
Prop.Flavi_new  <- round(Prop.Flavi_new,3) #lower than old data 

# For all interview records (using CATCH_PK variable) of P. flavipinnis or filamentosus for years between 2010 and 2015, randomly assign record as "P. flavi" proportionally to Prop.Flavi (all fish in an interview)
CATCH_PK.list      <- unique(B_new[YEAR>=2010&YEAR<=2015]$CATCH_PK)
# remove NA catch_pk 
CATCH_PK.list <- CATCH_PK.list[-1]
for (i in 1:length(CATCH_PK.list)){
  
  aCatch   <- B_new[CATCH_PK==CATCH_PK.list[i]]
  aSpecies <- aCatch[1,SPECIES_FK] # Just check first line of the CATCH_PK (CATCH_PK is at the species level, so all lines should be the same species)
  
  if(aSpecies=="241"|aSpecies=="242"){
    
    if(runif(n=1,0,1)<=Prop.Flavi){    
      B_new[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "241"
    } else {
      B_new[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "242"  
    }
  }
}	

# calculate proportion of L. rubrioperculatus (267) in the Manuas, where they barely appear

Prop.Emp_new    <- B_new[AREA_C=="Manua",list(EST_LBS=max(EST_LBS)),by=list(YEAR,INTERVIEW_PK,CATCH_PK,FAMILY,SPECIES_FK,SCIENTIFIC_NAME)]
Prop.Emp_new    <- Prop.Emp_new[FAMILY=="Lethrinidae",list(EST_LBS=sum(EST_LBS)),by=list(SPECIES_FK,SCIENTIFIC_NAME)]
Prop.Rub_new    <- Prop.Emp_new[SPECIES_FK=="267"]$EST_LBS/sum(Prop.Emp_new[SPECIES_FK!="260"]$EST_LBS)
Prop.Rub_new    <- round(Prop.Rub_new,3)

# For all interview records (using CATCH_PK variable) containing "emperors - 260" ID in Manua (all years), randomly assign record as to L. rubrio according to its proportion in 1986-2010
CATCH_PK.list      <- unique(B_new[AREA_C=="Manua"]$CATCH_PK)
# remove NA catch_pk 
CATCH_PK.list <- CATCH_PK.list[-1]
for (i in 1:length(CATCH_PK.list)){
  
  aCatch   <- B_new[CATCH_PK==CATCH_PK.list[i]]
  aSpecies <- aCatch[1,SPECIES_FK] # Just check first line of the CATCH_PK (CATCH_PK is at the species level, so all lines should be the same species)
  
  if(aSpecies=="260"){
    
    if(runif(n=1,0,1)<=Prop.Rub_new){    
      B_new[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "267"
    } else {
      B_new[CATCH_PK==CATCH_PK.list[i]]$SPECIES_FK2 <- "260"  
    }
  }
}	

# Remove old species unique ID with the corrected one
B_new <- select(B_new,-SPECIES_FK,-FAMILY,-SCIENTIFIC_NAME,-BMUS)
setnames(B_new,"SPECIES_FK2","SPECIES_FK")
B_new <- merge(B_new,S,by.x="SPECIES_FK",by.y="SPECIES_PK")
length(unique(B_new[B_new$YEAR>=2016]$INTERVIEW_PK)) #this number matches with old data

# Add proportion unidentified per INTERVIEW_PK
SUM.GROUP   <- B_new[BMUS=="BMUS_Containing_Group",list(LBS_GROUP=sum(EST_LBS)),by=list(INTERVIEW_PK)]
SUM.BMUS    <- B_new[BMUS=="BMUS_Species",list(LBS_BMUS=sum(EST_LBS)),by=list(INTERVIEW_PK)]
P           <- merge(SUM.GROUP,SUM.BMUS,by="INTERVIEW_PK",all=T)
P[is.na(P)] <- 0 
P$PROP_UNID <- round(P$LBS_GROUP/(P$LBS_BMUS+P$LBS_GROUP),3) 
P           <- select(P,INTERVIEW_PK,PROP_UNID)
B_new           <- merge(B_new,P,by="INTERVIEW_PK",all.x=T)

length(unique(B_new[is.na(PROP_UNID)&YEAR>=2016]$INTERVIEW_PK)) # 179 interviews that don't contain a BMUS or BMUS-containing group
B_new[is.na(PROP_UNID)]$PROP_UNID <- 0 # Assign zero for these interviews

# Collapse data and select only used variables
B_new <- B_new[,list(EST_LBS=sum(EST_LBS)),by=list(INTERVIEW_PK,CATCH_PK,AREA_C,YEAR,SEASON,MONTH,SAMPLE_DATE,SHIFT,TOD_QUARTER,PORT_SIMPLE,HOUR,INTERVIEW_TIME_LOCAL,INTERVIEW_TIME_UTC,TYPE_OF_DAY,VESSEL_REGIST_NO,METHOD_FK,
            HOURS_FISHED,NUM_GEAR,PROP_UNID,BMUS,SPECIES_FK,FAMILY,SCIENTIFIC_NAME)]


B_new <- B_new[order(SAMPLE_DATE,INTERVIEW_TIME_LOCAL,INTERVIEW_PK)]

length(unique(B_new[YEAR>=2016]$INTERVIEW_PK)) #399
length(unique(B_new[METHOD_FK==4&YEAR>=2016]$INTERVIEW_PK)) #295
length(unique(B_new[METHOD_FK==5&YEAR>=2016]$INTERVIEW_PK)) #104

length(unique(B_new[YEAR>=2016&METHOD_FK=="4"]$INTERVIEW_PK)) #295

saveRDS(B_new,file=paste0(root_dir,"/Outputs/CPUE_A.rds"))
