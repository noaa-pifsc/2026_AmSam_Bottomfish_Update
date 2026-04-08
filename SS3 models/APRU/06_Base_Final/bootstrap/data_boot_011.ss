#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Tue Apr 07 08:59:01 2026
#_bootdata:_13
#C data file for APRU
#C file created using an r4ss function
#C file write time: 2026-04-06  17:43:24
#_bootstrap file: 11  irand_seed: 123 first rand#: 1.88328
#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
1967 #_StartYr
2025 #_EndYr
1 #_Nseas
 12 #_months/season
2 #_Nsubseasons (even number, minimum is 2)
1 #_spawn_month
-1 #_Ngenders: 1, 2, -1  (use -1 for 1 sex setup with SSB multiplied by female_frac parameter)
30 #_Nages=accumulator age, first age is always age 0
1 #_Nareas
1 #_Nfleets (including surveys)
#_fleet_type: 1=catch fleet; 2=bycatch only fleet; 3=survey; 4=predator(M2) 
#_sample_timing: -1 for fishing fleet to use season-long catch-at-age for observations, or 1 to use observation month;  (always 1 for surveys)
#_fleet_area:  area the fleet/survey operates in 
#_units of catch:  1=bio; 2=num (ignored for surveys; their units read later)
#_catch_mult: 0=no; 1=yes
#_rows are fleets
#_fleet_type fishery_timing area catch_units need_catch_mult fleetname
 1 -1 1 1 0 FISHERY  # 1
#Bycatch_fleet_input_goes_next
#a:  fleet index
#b:  1=include dead bycatch in total dead catch for F0.1 and MSY optimizations and forecast ABC; 2=omit from total catch for these purposes (but still include the mortality)
#c:  1=Fmult scales with other fleets; 2=bycatch F constant at input value; 3=bycatch F from range of years
#d:  F or first year of range
#e:  last year of range
#f:  not used
# a   b   c   d   e   f 
#_catch_biomass(mtons):_columns_are_fisheries,year,season
#_catch:_columns_are_year,season,fleet,catch,catch_se
#_Catch data: yr, seas, fleet, catch, catch_se
-999 1 1 0 0.01
1967 1 1 0.0632396 0.5
1968 1 1 0.0545525 0.5
1969 1 1 0.0108904 0.5
1970 1 1 0.00550878 0.5
1971 1 1 0.000567579 0.5
1972 1 1 0.201397 0.5
1973 1 1 0.258539 0.5
1974 1 1 0.0640142 0.5
1975 1 1 0.0976391 0.5
1976 1 1 0.396823 0.5
1977 1 1 0.0460861 0.5
1978 1 1 0.0162485 0.5
1979 1 1 0.0270969 0.5
1980 1 1 1.59021 0.5
1981 1 1 0.424629 0.5
1982 1 1 1.6336 0.5
1983 1 1 1.91998 0.5
1984 1 1 1.27952 0.5
1985 1 1 3.13263 0.5
1986 1 1 3.00054 0.5
1987 1 1 0.521178 0.5
1988 1 1 0.510787 0.5
1989 1 1 0.545832 0.32586
1990 1 1 0.0785565 0.5
1991 1 1 0.0587413 0.480854
1992 1 1 2.64371 0.5
1993 1 1 0.147698 0.5
1994 1 1 0.864818 0.363779
1995 1 1 0.308973 0.5
1996 1 1 1.7223 0.5
1997 1 1 1.65127 0.260358
1998 1 1 0.0372425 0.5
1999 1 1 0.139209 0.5
2000 1 1 0.543045 0.5
2001 1 1 0.397651 0.348732
2002 1 1 1.35618 0.5
2003 1 1 0.133409 0.310752
2004 1 1 0.257075 0.5
2005 1 1 0.238547 0.5
2006 1 1 0.366432 0.5
2007 1 1 0.978926 0.5
2008 1 1 0.950808 0.5
2009 1 1 4.75707 0.2
2010 1 1 0.88814 0.273691
2011 1 1 1.52294 0.5
2012 1 1 0.137628 0.5
2013 1 1 0.485315 0.5
2014 1 1 1.27546 0.5
2015 1 1 2.60091 0.277979
2016 1 1 1.17531 0.218319
2017 1 1 2.64172 0.2
2018 1 1 0.64285 0.312542
2019 1 1 1.48622 0.34192
2020 1 1 0.237393 0.394157
2021 1 1 0.0297123 0.452443
2022 1 1 0.0617526 0.5
2023 1 1 0.0921651 0.5
2024 1 1 0.267561 0.404268
2025 1 1 0.150765 0.2
-9999 0 0 0 0
#
 #_CPUE_and_surveyabundance_observations
#_Units:  0=numbers; 1=biomass; 2=F; 30=spawnbio; 31=recdev; 32=spawnbio*recdev; 33=recruitment; 34=depletion(&see Qsetup); 35=parm_dev(&see Qsetup)
#_Errtype:  -1=normal; 0=lognormal; >0=T
#_SD_Report: 0=no sdreport; 1=enable sdreport
#_Fleet Units Errtype SD_Report
1 1 0 0 # FISHERY
#_year month index obs err
2016 7 1 1.97743 0.32469 #_orig_obs: 2.00418 FISHERY
2017 7 1 2.31259 0.273876 #_orig_obs: 3.83655 FISHERY
2018 7 1 1.85288 0.344738 #_orig_obs: 2.9201 FISHERY
2019 7 1 2.22873 0.339933 #_orig_obs: 2.81445 FISHERY
2020 7 1 1.60452 0.51319 #_orig_obs: 2.29963 FISHERY
2021 7 1 2.82011 0.67507 #_orig_obs: 4.67433 FISHERY
2022 7 1 1.894 1.34121 #_orig_obs: 12.4922 FISHERY
2023 7 1 3.65498 1.05203 #_orig_obs: 0.322465 FISHERY
2024 7 1 3.74551 0.544209 #_orig_obs: 1.34148 FISHERY
2025 7 1 4.06434 0.792608 #_orig_obs: 1.84068 FISHERY
-9999 1 1 1 1 # terminator for survey observations 
#
0 #_N_fleets_with_discard
#_discard_units (1=same_as_catchunits(bio/num); 2=fraction; 3=numbers)
#_discard_errtype:  >0 for DF of T-dist(read CV below); 0 for normal with CV; -1 for normal with se; -2 for lognormal; -3 for trunc normal with CV
# note: only enter units and errtype for fleets with discard 
# note: discard data is the total for an entire season, so input of month here must be to a month in that season
#_Fleet units errtype
# -9999 0 0 0.0 0.0 # terminator for discard data 
#
0 #_use meanbodysize_data (0/1)
#_COND_0 #_DF_for_meanbodysize_T-distribution_like
# note:  type=1 for mean length; type=2 for mean body weight 
#_yr month fleet part type obs stderr
#  -9999 0 0 0 0 0 0 # terminator for mean body size data 
#
# set up population length bin structure (note - irrelevant if not using size data and using empirical wtatage
2 # length bin method: 1=use databins; 2=generate from binwidth,min,max below; 3=read vector
1 # binwidth for population size comp 
1 # minimum size in the population (lower edge of first bin and size at age 0.00) 
100 # maximum size in the population (lower edge of last bin) 
1 # use length composition data (0/1)
#_mintailcomp: upper and lower distribution for females and males separately are accumulated until exceeding this level.
#_addtocomp:  after accumulation of tails; this value added to all bins
#_combM+F: males and females treated as combined gender below this bin number 
#_compressbins: accumulate upper tail by this number of bins; acts simultaneous with mintailcomp; set=0 for no forced accumulation
#_Comp_Error:  0=multinomial, 1=dirichlet
#_ParmSelect:  parm number for dirichlet
#_minsamplesize: minimum sample size; set to 1 to match 3.24, minimum value is 0.001
#
#_mintailcomp addtocomp combM+F CompressBins CompError ParmSelect minsamplesize
-1 0.001 0 0 1 1 0.001 #_fleet:1_FISHERY
15 #_N_LengthBins
 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90
# sex codes:  0=combined; 1=use female only; 2=use male only; 3=use both as joint sexxlength distribution
# partition codes:  (0=combined; 1=discard; 2=retained
#_yr month fleet sex part Nsamp datavector(female-male)
 2007 1 1 0 0 108  0 3 7 5 16 20 14 10 11 7 13 1 1 0 0
 2008 1 1 0 0 89  1 1 3 3 11 17 12 8 6 12 3 3 7 1 1
 2009 1 1 0 0 84  1 1 2 7 10 6 13 14 7 7 7 4 4 1 0
 2010 1 1 0 0 31  0 0 1 3 3 2 4 5 5 4 1 1 2 0 0
 2011 1 1 0 0 46  1 0 0 6 4 4 6 8 5 8 3 1 0 0 0
 2012 1 1 0 0 69  0 0 1 5 9 8 13 5 10 6 6 6 0 0 0
 2013 1 1 0 0 41  0 1 0 0 9 7 9 3 2 4 2 4 0 0 0
 2014 1 1 0 0 58  0 2 0 3 10 8 10 6 5 3 7 2 2 0 0
 2015 1 1 0 0 76  0 3 1 7 6 14 9 7 15 1 8 1 2 1 1
 2016 1 1 0 0 60  0 1 0 6 9 7 9 7 4 3 6 7 0 1 0
 2017 1 1 0 0 84  1 2 2 12 11 7 15 9 5 8 1 8 3 0 0
 2018 1 1 0 0 41  0 3 0 2 7 3 5 4 6 5 3 1 0 2 0
 2019 -1 1 0 0 64  1 0 3 5 14 7 10 6 7 6 2 1 1 1 0
 2020 -1 -1 0 0 15  0 0 0 4 2 5 0 2 1 0 1 0 0 0 0
 2021 -1 1 0 0 36  0 2 0 2 6 4 4 3 5 4 2 2 0 2 0
 2022 1 -1 0 0 3  0 0 0 0 0 0 0 0 2 1 0 0 0 0 0
 2023 1 -1 0 0 4  0 0 1 0 0 0 1 1 1 0 0 0 0 0 0
 2024 1 -1 0 0 15  0 0 0 1 3 2 1 2 2 0 1 1 2 0 0
 2025 -1 -1 0 0 9  0 1 0 2 0 1 2 0 1 1 1 0 0 0 0
-9999 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
#
0 #_N_age_bins
# 0 #_N_ageerror_definitions
#_mintailcomp: upper and lower distribution for females and males separately are accumulated until exceeding this level.
#_addtocomp:  after accumulation of tails; this value added to all bins
#_combM+F: males and females treated as combined gender below this bin number 
#_compressbins: accumulate upper tail by this number of bins; acts simultaneous with mintailcomp; set=0 for no forced accumulation
#_Comp_Error:  0=multinomial, 1=dirichlet
#_ParmSelect:  parm number for dirichlet
#_minsamplesize: minimum sample size; set to 1 to match 3.24, minimum value is 0.001
#
#_mintailcomp addtocomp combM+F CompressBins CompError ParmSelect minsamplesize
# 0 0 -361234365 1800405059 0 0 0 #_fleet:1_FISHERY
# 0 #_Lbin_method_for_Age_Data: 1=poplenbins; 2=datalenbins; 3=lengths
# sex codes:  0=combined; 1=use female only; 2=use male only; 3=use both as joint sexxlength distribution
# partition codes:  (0=combined; 1=discard; 2=retained
#_yr month fleet sex part ageerr Lbin_lo Lbin_hi Nsamp datavector(female-male)
# -9999  0 0 0 0 0 0 0 0
#
0 #_Use_MeanSize-at-Age_obs (0/1)
#
0 #_N_environ_variables
# -2 in yr will subtract mean for that env_var; -1 will subtract mean and divide by stddev (e.g. Z-score)
#Yr Variable Value
#
0 # N sizefreq methods to read 
#
0 # do tags (0/1)
#
0 #    morphcomp data(0/1) 
#  Nobs, Nmorphs, mincomp
#  yr, seas, type, partition, Nsamp, datavector_by_Nmorphs
#
0  #  Do dataread for selectivity priors(0/1)
 # Yr, Seas, Fleet,  Age/Size,  Bin,  selex_prior,  prior_sd
 # feature not yet implemented
#
999

