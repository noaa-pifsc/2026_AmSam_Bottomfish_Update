## Run this script after running 06_CATCH_BBS_FinalPrep.r
## This adds on the new years of data for the update 2022-2024
## Lots of code is commented out because reassigning proportions doesn't apply to the new years of data

require(tidyverse); require(this.path); require(data.table); require(openxlsx)

root_dir <- this.path::here(.. = 2)
options(scipen = 999)

#D <- fread(paste0(root_dir, "/Data/AS_BBS_SPC_correctLog2.csv"), stringsAsFactors=FALSE) 
d <- readr::read_rds(file.path(root_dir, "Data", "a_catch_bbs.rds"))
d <- d %>% filter(DATA_YEAR > 2021)
d <- as.data.table(d)
# Add more species info
S                 <- data.table(  read.xlsx(paste0(root_dir, "/Data/METADATA.xlsx"),sheet="ALLSPECIES")   )
S                 <- select(S,SPECIES_PK,SCIENTIFIC_NAME,FAMILY)
S$SPECIES_PK      <- paste0("S",S$SPECIES_PK) 
d$SPECIES_FK      <- paste0("S",d$SPECIES_FK) 
d                 <- merge(d,S,by.x="SPECIES_FK",by.y="SPECIES_PK")


# follow Toby's instructions to break the unique key SPC_PK into the interview details we need
d <- mutate(d,YEAR = as.numeric(DATA_YEAR), METHOD = METHOD_FK, 
                   ZONE = ISLAND, TYPE = TYPE_OF_DAY, 
                   CHARTER = substr(EXP_FK,17,17), PROCESS = substr(EXP_FK,18,18))

#d[is.na(VAR_LBS_CAUGHT)]$VAR_LBS_CAUGHT <- 0 # IS this necessary? Does it have an impact? 

## NOT NECESSARY bc already named as islands
# d[ZONE=='1']$ZONE<-'Tutuila'			# note banks trips are included in Tutuila expansion
# d[ZONE=='2']$ZONE<-'Manua'
# but the names have ' in them so need to remove them
d$ZONE <- gsub("'", "", d$ZONE)


# d[SPECIES_FK=="S109"]$SPECIES_FK <- "S110" # Merge Trevallies and Jacks
# d[SPECIES_FK=="S380"]$SPECIES_FK <- "S210" # Merge Inshore groupers and groupers

#  Note:
#		Method	4 = bottomfishing, 5 = btm/trl mix
#		Zone	1 = Tutuila, 2 = Manua
#		Type	WD = weekday, WE = weekend
#		Charter	C = yes, N = no
#		Process	G = Tutuila, M = Manua

# ---- per Hongguang / Toby:
#	LBS_CAUGHT is the expanded landings, in lbs, and VAR_LBS_CAUGHT is the estimated variance of expanded landings (sigma^2).
#	Because the different expansion strata (year x method x zone x type x charter x species) are independent,
#	when summing across strata, you simply sum the variances and sample sizes.
#		for sample size, use NUM_INTERVIEW_POOLED (this includes all interviews in the strata, including 0s).
#	Although it might not be entirely statistically sound, Hongguang says to sum the P. rutilans with P. flavi for now.
#		so just replace SPECIES_FK = 243 with 241 now

#d[SPECIES_FK=="S243"]$SPECIES_FK<-"S241"

# retain all gear types that catch identified BMUS: '4','5','6','8','61' (bfishing, btm/trl mix, spear no tanks, atule-mixed, spear tanks)
#		note that catch of identified BMUS with gears other than bfishing and btm/trl mix are rare, but we retain those gears for landings
#		just to be complete.

d <- d[METHOD=="4"|METHOD=="5"|METHOD=="6"|METHOD=="8"|METHOD=="61"]

# Select only necessary columns
#summing the lbs caught and variance of the lbs caught by year-area-fishing method-species combination
d <- d[,list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(YEAR,ZONE,METHOD,SPECIES_FK)]


# missing_rows <- anti_join(D, d) #5084 rows in D that aren't in d
# missing_rows %>% filter(SPECIES_FK %in% bmus_fk) %>% group_by(SPECIES_FK) %>% 
# summarise(tot_lbs = sum(LBS_CAUGHT)) %>% arrange(desc(tot_lbs)) #missing catch for bmus species is ~90000 - ~5700 lbs
#==================Fix Variola louti (229) and V. albimarginata (220) issue (species IDed together from 1986 to 2015)======================
## Quick check comparing new and old data for Variola species
# D[which(YEAR == 2004 & ZONE == "Tutu'ila" &  METHOD == 4 & SPECIES_FK == "S229"),]

# D.vari <- D[YEAR<=2015&(SPECIES_FK=="S229"|SPECIES_FK=="S220"),]
# d.vari <- d[YEAR<=2015&(SPECIES_FK=="S229"|SPECIES_FK=="S220"),]

# D.vari.catch <- D.vari[,list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(YEAR,ZONE,METHOD
#     ,SPECIES_FK)] 
# d.vari.catch <- d.vari.sub[,list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(YEAR,ZONE,METHOD
#     ,SPECIES_FK)] 
# d.vari.catch$ZONE <- gsub("'", "", d.vari.catch$ZONE)

# head(d.vari.catch)

# ggplot(data = d.vari.catch) +
# geom_line(aes(x = YEAR, y = LBS_CAUGHT, color = as.factor(METHOD))) +
# geom_line(data = D.vari.catch, aes(x = YEAR, y = LBS_CAUGHT, color = as.factor(METHOD)), linetype = 2) +
# facet_grid(ZONE ~ SPECIES_FK, scales = "free")

# d[YEAR<=2015&(SPECIES_FK=="S229"|SPECIES_FK=="S220")]$SPECIES_FK <- "S99999" # Assign all records to a dummy species code (for now)

#this doesn't really do anything bc already done in line 58
d <- d[,list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(YEAR,ZONE,METHOD,SPECIES_FK)] # Sum records together

# Re-assign 1986-2015 "S99999" to both V. louti and V. albi, based on the 2016-2021 occurrence ratio obtained in 01_BBS_data_prep.r
# These ratios are: V. louti 0.236 and V.albimarginata 0.764

# Prop.Louti <- 0.236; Prop.Albi <- 1-Prop.Louti

# # For the catch
# #spreading out the lbs caught by species for each year-area-fishing method (any missing values were 0s)
# d.LBS                  <- dcast(d,YEAR+ZONE+METHOD~SPECIES_FK,value.var="LBS_CAUGHT",fill=0)
# # duplicates <- D[, .N, by = .(YEAR, ZONE, METHOD, SPECIES_FK)][N > 1]
# # duplicates
# d.LBS[YEAR<=2015]$S220 <- d.LBS[YEAR<=2015]$S99999*Prop.Albi  # Assign Prop.louti proportion to Variola catch
# d.LBS[YEAR<=2015]$S229 <- d.LBS[YEAR<=2015]$S99999*Prop.Louti # Assign Prop.louti proportion to Variola catch
# d.LBS                  <- select(d.LBS,-S99999) # Get rid of Variolas column
# d.LBS                  <- melt.data.table(d.LBS,id.vars=1:3,variable.name="SPECIES_FK",value.name="LBS_CAUGHT")

# # For the variance
# d.VAR                  <- dcast(d,YEAR+ZONE+METHOD~SPECIES_FK,value.var="VAR_LBS_CAUGHT",fill=0)
# d.VAR[YEAR<=2015]$S220 <- d.VAR[YEAR<=2015]$S99999*Prop.Albi  # Assign Prop.louti proportion to Variola catch
# d.VAR[YEAR<=2015]$S229 <- d.VAR[YEAR<=2015]$S99999*Prop.Louti # Assign Prop.louti proportion to Variola catch
# d.VAR                  <- select(d.VAR,-S99999) # Get rid of Variolas column
# d.VAR                  <- melt.data.table(d.VAR,id.vars=1:3,variable.name="SPECIES_FK",value.name="VAR_LBS_CAUGHT")

# # Merge back catch and variance
# d <- merge(d.LBS,d.VAR,by=c("YEAR","ZONE","METHOD","SPECIES_FK"))
#d$SPECIES_FK <- as.character(d$SPECIES_FK)

#==================Fix Pristipomoides flavipinnis (241) and P. filamentosus (242) issue (species IDed together from 2010 to 2015)======================
# d[(YEAR>=2010&YEAR<=2015)&(SPECIES_FK=="S241"|SPECIES_FK=="S242")]$SPECIES_FK <- "S99999" # Assign all records to a dummy species code (for now)

# d <- d[,list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(YEAR,ZONE,METHOD,SPECIES_FK)] # Sum records together by year-area-fishing method-species combination

# # Re-assign 2010-2015 "S99999" to both P. flavi and P. filamen, based on the 2016-2021 occurrence ratio obtained in 01_BBS_data_prep.r
# # These ratios are: P. flavi 0.934 and P. filamentosus 0.

# Prop.Flavi <- 0.934; Prop.Filam <- 1-Prop.Flavi

# # For the catch
# d.LBS                             <- dcast(d,YEAR+ZONE+METHOD~SPECIES_FK,value.var="LBS_CAUGHT",fill=0)
# d.LBS[YEAR>=2010&YEAR<=2015]$S241 <- d.LBS[YEAR>=2010&YEAR<=2015]$S99999*Prop.Flavi  # Assign Prop.louti proportion to Variola catch
# d.LBS[YEAR>=2010&YEAR<=2015]$S242 <- d.LBS[YEAR>=2010&YEAR<=2015]$S99999*Prop.Filam # Assign Prop.louti proportion to Variola catch
# d.LBS                             <- select(d.LBS,-S99999) # Get rid of Variolas column
# d.LBS                             <- melt.data.table(d.LBS,id.vars=1:3,variable.name="SPECIES_FK",value.name="LBS_CAUGHT")

# # For the variance
# d.VAR                             <- dcast(d,YEAR+ZONE+METHOD~SPECIES_FK,value.var="VAR_LBS_CAUGHT",fill=0)
# d.VAR[YEAR>=2010&YEAR<=2015]$S241 <- d.VAR[YEAR>=2010&YEAR<=2015]$S99999*Prop.Flavi  # Assign Prop.louti proportion to Variola catch
# d.VAR[YEAR>=2010&YEAR<=2015]$S242 <- d.VAR[YEAR>=2010&YEAR<=2015]$S99999*Prop.Filam # Assign Prop.louti proportion to Variola catch
# d.VAR                             <- select(d.VAR,-S99999) # Get rid of Variolas column
# d.VAR                             <- melt.data.table(d.VAR,id.vars=1:3,variable.name="SPECIES_FK",value.name="VAR_LBS_CAUGHT")

# # Merge back catch and variance
# d <- merge(d.LBS,d.VAR,by=c("YEAR","ZONE","METHOD","SPECIES_FK"))
# d$SPECIES_FK <- as.character(d$SPECIES_FK)

# Remove the zero catch strata
# d <- d[LBS_CAUGHT>0]

## Do we even need to do this section since we aren't including LERU in 2026 update??
#===============Fix L. rubrioperculatus (267) in the Manuas I. issue (fisher say it's common, barely recorded, lots of unidentified emperors)===============
d <- merge(d,S,by.x="SPECIES_FK",by.y="SPECIES_PK") # Add family info so we can select all Emperors quickly

d[ZONE=="Manua"&FAMILY=="Lethrinidae"]$SPECIES_FK <- "S99999" # Assign all emperor records to a dummy species code (for now)

d <- d[,list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(YEAR,ZONE,METHOD,SPECIES_FK)] # Sum records together

# Re-assign Manuas "S99999" to L. rubrioperculatus, based on the 1986-2010 occurrence ratio obtained in 01_BBS_data_prep.r
# This ratio is: 0.32

Prop.Rubrio <- 0.32; Prop.OtherEmps <- 1-Prop.Rubrio

# For the catch
d.LBS                             <- dcast(d,YEAR+ZONE+METHOD~SPECIES_FK,value.var="LBS_CAUGHT",fill=0)
d.LBS[ZONE=="Manua"]$S267 <- d.LBS[ZONE=="Manua"]$S99999*Prop.Rubrio    # Assign Prop.Rubrio proportion to LERU catch
#d.LBS[ZONE=="Manua"]$S260 <- d.LBS[ZONE=="Manua"]$S99999*Prop.OtherEmps # Assign Prop.OtherEmps proportion to other emperor catch
d.LBS                             <- select(d.LBS,-S99999) # Get rid of Variolas column
d.LBS                             <- melt.data.table(d.LBS,id.vars=1:3,variable.name="SPECIES_FK",value.name="LBS_CAUGHT")

# For the variance
d.VAR                             <- dcast(d,YEAR+ZONE+METHOD~SPECIES_FK,value.var="VAR_LBS_CAUGHT",fill=0)
d.VAR[ZONE=="Manua"]$S267 <- d.VAR[ZONE=="Manua"]$S99999*Prop.Rubrio    # Assign Prop.Rubrio proportion to LERU catch
#d.VAR[ZONE=="Manua"]$S260 <- d.VAR[ZONE=="Manua"]$S99999*Prop.OtherEmps # Assign Prop.OtherEmps proportion to other emperor catch
d.VAR                             <- select(d.VAR,-S99999) # Get rid of Variolas column
d.VAR                             <- melt.data.table(d.VAR,id.vars=1:3,variable.name="SPECIES_FK",value.name="VAR_LBS_CAUGHT")

# Merge back catch and variance
d <- merge(d.LBS,d.VAR,by=c("YEAR","ZONE","METHOD","SPECIES_FK"))

# Remove the zero catch strata
d <- d[LBS_CAUGHT>0]
d$SPECIES_FK <- as.character(d$SPECIES_FK)

#======================Break down taxonomic groups into species components using proportion table from 03_BBS_proptables.R===============================

PT            <- readRDS(paste0(root_dir, "/Outputs/BBS_Prop_Table.rds"))  # Species composition of groups, by group x period x region
PT$GROUP_FK   <- paste0("S",PT$GROUP_FK)
PT$SPECIES_FK <- paste0("S",PT$SPECIES_FK)

d$PERIOD <- 999 # Add time period that matches the one used for prop table (PT)
# d[YEAR>1985&YEAR<=1995]$PERIOD  <- 1995
# d[YEAR>1995&YEAR<=2005]$PERIOD  <- 2005
# d[YEAR>2005&YEAR<=2015]$PERIOD  <- 2015
d[YEAR>2015&YEAR<=2025]$PERIOD  <- 2025

X            <- d[SPECIES_FK=="S109"|SPECIES_FK=="S110"|SPECIES_FK=="S200"|SPECIES_FK=="S210"|SPECIES_FK=="S230"|SPECIES_FK=="S240"|SPECIES_FK=="S260"|SPECIES_FK=="S380"|SPECIES_FK=="S390"]

## There is only one record of a taxonomic group
ggplot(data=X[ZONE=="Tutuila"],aes(x=YEAR,y=LBS_CAUGHT))+
  geom_bar(stat="identity")+
  facet_wrap(~SPECIES_FK,scales="free_y")
ggsave(last_plot(),file=paste0(root_dir, "/Outputs/Summary/CATCH_GROUPED.png"),width=8,height=4)

X          <- merge(X,PT,by.x=c("SPECIES_FK","PERIOD","ZONE"),by.y=c("GROUP_FK","PERIOD","AREA_C"),allow.cartesian=T)
X$SPECIES_FK <- X$SPECIES_FK.y
X$LBS_CAUGHT <- X$LBS_CAUGHT*X$Prop
X            <- select(X,-SPECIES_FK.y,-Prop,-PERIOD)
X$SOURCE     <- "Group-level"

Y        <- select(d,-PERIOD )
Y        <- Y[SPECIES_FK!="S109"|SPECIES_FK!="S110"|SPECIES_FK!="S200"|SPECIES_FK!="S210"|SPECIES_FK!="S230"|SPECIES_FK!="S240"|SPECIES_FK!="S260"|SPECIES_FK!="S380"|SPECIES_FK!="S390"]
Y$SOURCE <- "Species-level"

Z <- rbind(X,Y)

# Add a BMUS classification to simplify further summary code
Z$BMUS <- "F"
Z[SPECIES_FK=="S247"|SPECIES_FK=="S239"|SPECIES_FK=="S111"|SPECIES_FK=="S249"|
    SPECIES_FK=="S248"|SPECIES_FK=="S267"|SPECIES_FK=="S231"|SPECIES_FK=="S242"|
    SPECIES_FK=="S241"|SPECIES_FK=="S245"|SPECIES_FK=="S229"]$BMUS <- "T"

d$BMUS <- "F"
d[SPECIES_FK=="S247"|SPECIES_FK=="S239"|SPECIES_FK=="S111"|SPECIES_FK=="S249"|
    SPECIES_FK=="S248"|SPECIES_FK=="S267"|SPECIES_FK=="S231"|SPECIES_FK=="S242"|
    SPECIES_FK=="S241"|SPECIES_FK=="S245"|SPECIES_FK=="S229"]$BMUS <- "T"

T0 <- Z[BMUS=="T",list(LBS_CAUGHT=sum(LBS_CAUGHT)),by=list(YEAR,SPECIES_FK)]
ggplot(data=T0)+geom_bar(aes(x=YEAR,y=LBS_CAUGHT,fill=SPECIES_FK),size=1,position="stack",stat="identity")+theme_bw()

# Check group-derived vs species-derived BMUS catch
T1 <- Z[BMUS=="T",list(LBS_CAUGHT=sum(LBS_CAUGHT)),by=list(YEAR,SOURCE)]
ggplot()+geom_bar(data=T1,aes(x=YEAR,y=LBS_CAUGHT,fill=SOURCE),size=1,position="stack",stat="identity")+theme_bw()

# Other tests
T2 <- Z[BMUS=="T",list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(SPECIES_FK,YEAR)]
T2$SD <- sqrt(T2$VAR_LBS_CAUGHT)

test  <- d[BMUS=="T",list(LBS_RAW=sum(LBS_CAUGHT)),by=list(YEAR,SPECIES_FK)]
test2 <- select(T2,-VAR_LBS_CAUGHT,-SD)
test3 <- merge(test,test2,by=c("YEAR","SPECIES_FK"))
ggplot(data=test3[SPECIES_FK=="S229"])+geom_line(aes(x=YEAR,y=LBS_CAUGHT),col="blue")+geom_line(aes(x=YEAR,y=LBS_RAW),col="red")


# Save catch record by ZONE, for Manua catch reconstruction
G <- Z[BMUS=="T",list(LBS_CAUGHT=sum(LBS_CAUGHT),VAR_LBS_CAUGHT=sum(VAR_LBS_CAUGHT)),by=list(SPECIES_FK,ZONE,YEAR)]
g <- G[order(SPECIES_FK,ZONE,YEAR)]

# Explore the Catch by Year and Area
#EX <- merge(G,S,by.x="SPECIES_FK",by.y="SPECIES_PK")
#EX <- EX %>% group_by(SCIENTIFIC_NAME,YEAR,ZONE) %>% summarize(LBS=sum(LBS_CAUGHT)) %>% as.data.table() %>% filter(SCIENTIFIC_NAME!="Etelis carbunculus"&SCIENTIFIC_NAME!="Pristipomoides filamentosus")
#ggplot(data=EX[YEAR<=2008],aes(x=YEAR,y=LBS,col=ZONE))+geom_line()+facet_wrap(~SCIENTIFIC_NAME,scale="free_y")+theme_bw()
#ggsave(last_plot(),file=file.path(root_dir,"CATCH_BY_AREA.png"))


# =============== Reconstruct Manua 2009-2021 based on regression with Tutuila data=====================================

# Years to consider:
# Latest: Although the total number of Manu'a interviews dropped in 2008 (about half of 2007), interviewer 19 did continue a few
#	interviews per most months until December. So, include 2008. Interviewer 08 really petered out in 2007
#	but was most active 93-96 and 2000.
# Earliest: In 1986 and 1987, the majority of bottomfishing and btm/trl mix interviewed landings were identified
#	only to group level, hence for many species, broken down catch from the group categories makes up a lot of the
#	catch. In addition, when I looked at scatterplots of manua vs. tutu catches, 1986 and 1987 were frequent outliers, 
#   with high Tutuila catches and low Manu'a catches. There were also only 2 Manu'a interviews in 1987.
#   so, do not include 1986-1987 in information used to reconstruct recent catches.

# Estimate 2009-2021 Manu'a Islands catch, by species following this approach:
#	a. "slope": Manu'a catch and variance is a proportion of Tutuila catch based on 1988-2008
#		only if p-value of regression indicates slope is not zero


Tt <- G[ZONE=="Manua",list(LBS=sum(LBS_CAUGHT)),by=list(YEAR)]
ggplot(data=Tt)+geom_bar(aes(x=YEAR,y=LBS),stat="identity")

e <- dcast(g,SPECIES_FK+YEAR~ZONE,value.var="LBS_CAUGHT")

# ggplot(data=e[YEAR>=1987&YEAR<=2008],aes(x=Tutuila,y=Manua))+geom_point()+stat_smooth(method="lm")+facet_wrap(~SPECIES_FK,scales="free")
# ggplot(data=e[YEAR>=1987&YEAR<=2008],aes(x=Tutuila,y=Manua))+geom_point()+stat_smooth()+facet_wrap(~SPECIES_FK,scales="free")

# Sp.list <- unique(E$SPECIES_FK)
# Results <- data.table();aResults<-data.table()
# for(i in 1:11){
  
#   anLM                <- lm(data=E[SPECIES_FK==Sp.list[i]&(YEAR>=1987&YEAR<=2008)],Manua~Tutuila+0)
#   aResults$SPECIES_FK <- Sp.list[i]
#   aResults$PVALUE     <- round(summary(anLM)$coefficients[4],3)
#   aResults$R2         <- round(summary(anLM)$r.squared,3)
#   aResults$COEF       <- anLM$coefficients[1]
#   Results             <- rbind(Results,aResults)
# }

# Results$KEEP <- ifelse(Results$PVALUE<=0.05,1,0)

# Add 2009-2021 Manua catch based on regression results above.
# COEF <- select(Results[KEEP==1],SPECIES_FK,COEF)
E <- readRDS(file = file.path(root_dir, "Outputs/CATCH_BBS_E_Old.rds"))
COEF <- readRDS(file = file.path(root_dir, "Outputs/CATCH_BBS_COEF_Manua.rds"))
Ee <- rbind(E, e)
Ee    <- merge(Ee,COEF,by="SPECIES_FK")

# Calculate 2009-2021 Manua catch based on Tutuila catch
Ee[YEAR>=2009]$Manua <- Ee[YEAR>=2009]$Tutuila*Ee[YEAR>=2009]$COEF
Ee                   <- select(Ee[YEAR>=2009],YEAR,SPECIES_FK,LBS_CAUGHT=Manua,)
Ee$VAR_LBS_CAUGHT    <- 0 # Set to 0 for now
Ee$ZONE              <- "Manua"

# Put back together
G <- readRDS(file = file.path(root_dir, "/Outputs/CATCH_BBS_G_Old.rds"))
Gg <- rbind(G, g)
Gg <- Gg[!(ZONE=="Manua"&YEAR>=2009)] # Remove old Manua catch
GE <- rbind(Gg,Ee)  

# Save final boat-based catch file
GE$SOURCE <- "BBS"
GE$SD.LBS <- sqrt(GE$VAR_LBS_CAUGHT)
GE        <- select(GE,SOURCE,SPECIES_FK,YEAR,AREA_C=ZONE,LBS=LBS_CAUGHT,SD.LBS)
saveRDS(GE,file=paste0(root_dir, "/Outputs/CATCH_BBS_A.rds"))

# G_new$data_set <- "new"
# G$data_set <- "old"

# G %>% 
# bind_rows(G_new) %>%
#   mutate(SPECIES = case_when(
#     SPECIES_FK == "S247" ~ "APRU",
#     SPECIES_FK == "S239" ~ "APVI",
#     SPECIES_FK == "S111" ~ "CALU",
#     SPECIES_FK == "S249" ~ "ETCA",
#     SPECIES_FK == "S248" ~ "ETCO",
#     SPECIES_FK == "S267" ~ "LERU",
#     SPECIES_FK == "S231" ~ "LUKA",
#     SPECIES_FK == "S242" ~ "PRFI",
#     SPECIES_FK == "S241" ~ "PRFL",
#     SPECIES_FK == "S245" ~ "PRZO",
#     SPECIES_FK == "S229" ~ "VALO",
#     TRUE ~ NA_character_  # default for unmatched values
#   )) %>%
# filter(SOURCE == "BBS" & AREA_C == "Tutuila") %>%
# ggplot(aes(x = YEAR, y = LBS)) + 
# geom_line(aes(color = data_set)) + 
# facet_wrap(~SPECIES, scales ="free_y")
# ggsave(last_plot(),file=paste0(root_dir, "/Outputs/Summary/catch_comparisons_new_old.png"),width=8,height=4)
