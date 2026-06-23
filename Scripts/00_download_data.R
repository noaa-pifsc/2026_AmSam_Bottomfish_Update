# Script to directly query databases for American Samoa catch and survey data 
# Data used in the 2026 update
# As of 12/25, use MySQL to access data bc Oracle isn't as updated. 
# Meg Oshima
# Install renv for package management
#install.packages("renv")
# To install all packages needed: 
renv::restore()
pacman::p_load("DBI","tidyverse","data.table","this.path")

root_dir <- this.path::here(..=1)

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

# Load expanded catch data
bbs.catch <- dbGetQuery(con, "select * from amsam_dmwr_wh.a_bbs_spc_vfp")
sbs.catch <- dbGetQuery(con, "select * from amsam_dmwr_wh.a_sbs_spc_vfp")

# Save files
write_rds(bbs.interv,fs::path(root_dir,"Data","a_interview_bbs.rds"))
write_rds(sbs.interv,fs::path(root_dir,"Data","a_interview_sbs.rds"))
write_rds(bbs.catch,fs::path(root_dir,"Data","a_catch_bbs.rds"))
write_rds(sbs.catch,fs::path(root_dir,"Data","a_catch_sbs.rds"))

# Disconnect from database
dbDisconnect(con)





