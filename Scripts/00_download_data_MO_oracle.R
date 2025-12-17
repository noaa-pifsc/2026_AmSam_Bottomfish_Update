# Script to directly query databases for American Samoa catch and survey data 
# Data used in the 2026 update
# As of 12/25, use MySQL to access data bc Oracle isn't as updated. But code for how to access through Oracle is available below.
# Meg Oshima
#require(pacman)
pacman::p_load("DBI","tidyverse","data.table","this.path")

root_dir <- this.path::here(..=1)

# Connect to Oracle database
# I originally was connecting to Oracle database and accessing data there but per comm with Brad 12/16, 
# there are 12 new columns that were added to the MySQL for the SBS_SPC_VFP table that weren't ported to
# Oracle yet so I switched to MySQL to download the necessary data. 
# library("ROracle")
# db_host <- "picdb.nmfs.local"
# db_port <- 1521
# db_service_name <- "pic.pifscproddbsn.pifscprodvcn.oraclevcn.com" # service name

# db_user <- keyring::key_get("PIFSC_DB_user")
# db_pwd <- keyring::key_get("PIFSC_DB_pwd")

# connection_string <- paste0("(DESCRIPTION=", "(ADDRESS=(PROTOCOL=tcp)(HOST=", db_host, ")(PORT=", db_port, "))", "(CONNECT_DATA=(SERVICE_NAME=", db_service_name, "))",")")

# con <- DBI::dbConnect(dbDriver("Oracle"), 
#                       username = db_user, 
#                       password = db_pwd, 
#                       dbname = connection_string, 
#                       timeout = 10)

# Connect to MySQL database
con <- DBI::dbConnect(RMariaDB::MariaDB()
                 , host = 'picfinfish.nmfs.local'
                 , ssl.cipher = 'AES256-SHA256'
                 , user = keyring::key_get("PIFSC_DB_user")
                 , password = keyring::key_get("PIFSC_MySQL_pwd")
                 )

# Data set list
dbListTables(con)

#=============================American Samoa MySQL=======================================
# Load interview flat files
bbs.interv  <- dbGetQuery(con, "select * from amsam_dmwr_wh.a_bbs_interview_flat_view")
sbs.interv  <- dbGetQuery(con, "select * from amsam_dmwr_wh.a_sbs_interview_flat_view")

# Remove the individual size information
bbs.interv <- bbs.interv %>% 
  group_by(INTERVIEW_PK,SAMPLE_DATE,DISPOSITION_FK,SPECIES_FK,SCIENTIFIC_NAME,FISHING_AREA,ISLAND_NAME,FISHING_METHOD) %>%
  summarize(EST_LBS=max(EST_LBS),NUM_KEPT=max(NUM_KEPT)) %>% mutate(YEAR=year(SAMPLE_DATE))

sbs.interv <- sbs.interv %>% 
  group_by(INTERVIEW_PK,SAMPLE_DATE,DISPOSITION_FK,SPECIES_FK,SCIENTIFIC_NAME,FISHING_AREA,FISHING_METHOD) %>%
  summarize(EST_WHOLE_LBS=max(EST_WHOLE_LBS)) %>% mutate(YEAR=year(SAMPLE_DATE))

# Load expanded catch data
bbs.catch <- dbGetQuery(con, "select * from amsam_dmwr_wh.a_bbs_spc_vfp")
sbs.catch <- dbGetQuery(con, "select * from amsam_dmwr_wh.a_sbs_spc_vfp")

bbs.catch <- bbs.catch %>% select(SPC_PK,ISLAND,DATA_YEAR,TYPE_OF_DAY,METHOD_FK,SPECIES_FK,EXP_LBS)
sbs.catch <- sbs.catch %>% select(EXP_FK,ROUTE_FK,DAY_NIGHT,DATA_YEAR,TYPE_OF_DAY,METHOD_FK,SPECIES_FK,EXP_LBS)

# Save files
write_rds(bbs.interv,fs::path(root_dir,"Data",,"a_interview_bbs.rds"))
write_rds(sbs.interv,fs::path(root_dir,"Data","a_interview_sbs.rds"))
write_rds(bbs.catch,fs::path(root_dir,"Data","a_catch_bbs.rds"))
write_rds(sbs.catch,fs::path(root_dir,"Data","a_catch_sbs.rds"))

# Disconnect from database
dbDisconnect(con)

#=============================American Samoa Oracle=======================================

schema_name <- "WP_AMSAM_WH"   #stays the same for all tables         

# Load interview flat files
# Brad created these flat file views "A_BBS_INTERVIEW_FLAT_VIEW"
# by combining tables a_bbs_int, a_bbs_cat , a_bbs_siz, a_method, a_area , a_vessel, a_port, a_island, a_species, a_fish_condition, a_disposition
bbs.interv  <- dbGetQuery(con, paste0("SELECT * FROM ", schema_name, ".", "A_BBS_INTERVIEW_FLAT_VIEW"))
sbs.interv  <- dbGetQuery(con, paste0("SELECT * FROM ", schema_name, ".", "A_SBS_INTERVIEW_FLAT_VIEW"))

# Remove the individual size information
bbs.interv <- bbs.interv %>% 
  group_by(INTERVIEW_PK,SAMPLE_DATE,DISPOSITION_FK,SPECIES_FK,SCIENTIFIC_NAME,FISHING_AREA,ISLAND_NAME,FISHING_METHOD) %>%
  summarize(EST_LBS=max(EST_LBS),NUM_KEPT=max(NUM_KEPT)) %>% mutate(YEAR=year(SAMPLE_DATE))

sbs.interv <- sbs.interv %>% 
  group_by(INTERVIEW_PK,SAMPLE_DATE,DISPOSITION_FK,SPECIES_FK,SCIENTIFIC_NAME,FISHING_AREA,FISHING_METHOD) %>%
  summarize(EST_WHOLE_LBS=max(EST_WHOLE_LBS)) %>% mutate(YEAR=year(SAMPLE_DATE))

# Load expanded catch data
bbs.catch <- dbGetQuery(con, paste0("SELECT * FROM ", schema_name, ".", "A_BBS_SPC_VFP"))
# missing some columns that are in MySQL so don't use this sbs.catch
sbs.catch <- dbGetQuery(con, paste0("SELECT * FROM ", schema_name, ".", "A_SBS_SPC_VFP"))

bbs.catch <- bbs.catch %>% select(SPC_PK,ISLAND,DATA_YEAR,TYPE_OF_DAY,METHOD_FK,SPECIES_FK,EXP_LBS)
sbs.catch <- sbs.catch %>% select(EXP_FK,ROUTE_FK,DAY_NIGHT,DATA_YEAR,TYPE_OF_DAY,METHOD_FK,SPECIES_FK,EXP_LBS) 

# Disconnect from database
dbDisconnect(con)

# Save files
write_rds(bbs.interv,fs::path(root_dir,"Data","a_interview_bbs.rds"))
write_rds(sbs.interv,fs::path(root_dir,"Data","a_interview_sbs.rds"))
write_rds(bbs.catch,fs::path(root_dir,"Data","a_catch_bbs.rds"))
write_rds(sbs.catch,fs::path(root_dir,"Data","a_catch_sbs.rds"))

#==================================================================================



