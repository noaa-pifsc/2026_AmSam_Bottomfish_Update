#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Tue Apr 07 08:59:01 2026
#_bootdata:_26
#C data file for APRU
#C file created using an r4ss function
#C file write time: 2026-04-06  17:43:24
#_bootstrap file: 24  irand_seed: 123 first rand#: 0.847116
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
1967 1 1 0.0101998 0.5
1968 1 1 0.0532421 0.5
1969 1 1 0.0114198 0.5
1970 1 1 0.00481287 0.5
1971 1 1 0.00054285 0.5
1972 1 1 0.175086 0.5
1973 1 1 0.540883 0.5
1974 1 1 0.0840178 0.5
1975 1 1 0.232675 0.5
1976 1 1 0.189607 0.5
1977 1 1 0.0832551 0.5
1978 1 1 0.0131727 0.5
1979 1 1 0.0259078 0.5
1980 1 1 1.28258 0.5
1981 1 1 0.662972 0.5
1982 1 1 2.45548 0.5
1983 1 1 1.8832 0.5
1984 1 1 1.71934 0.5
1985 1 1 1.50269 0.5
1986 1 1 2.11742 0.5
1987 1 1 0.390893 0.5
1988 1 1 0.700101 0.5
1989 1 1 0.566169 0.32586
1990 1 1 0.0419361 0.5
1991 1 1 0.0546477 0.480854
1992 1 1 2.38411 0.5
1993 1 1 0.213914 0.5
1994 1 1 0.360934 0.363779
1995 1 1 0.115879 0.5
1996 1 1 0.424351 0.5
1997 1 1 1.1797 0.260358
1998 1 1 0.0620574 0.5
1999 1 1 0.155107 0.5
2000 1 1 0.472562 0.5
2001 1 1 0.451045 0.348732
2002 1 1 1.95007 0.5
2003 1 1 0.123336 0.310752
2004 1 1 0.494889 0.5
2005 1 1 0.196461 0.5
2006 1 1 0.219596 0.5
2007 1 1 0.540431 0.5
2008 1 1 0.607788 0.5
2009 1 1 3.23247 0.2
2010 1 1 0.65249 0.273691
2011 1 1 0.687792 0.5
2012 1 1 0.362232 0.5
2013 1 1 0.587965 0.5
2014 1 1 0.747553 0.5
2015 1 1 1.68389 0.277979
2016 1 1 1.85071 0.218319
2017 1 1 1.64457 0.2
2018 1 1 0.526746 0.312542
2019 1 1 1.86055 0.34192
2020 1 1 0.343597 0.394157
2021 1 1 0.0346418 0.452443
2022 1 1 0.0798924 0.5
2023 1 1 0.0354762 0.5
2024 1 1 0.260536 0.404268
2025 1 1 0.157646 0.2
-9999 0 0 0 0
#
 #_CPUE_and_surveyabundance_observations
#_Units:  0=numbers; 1=biomass; 2=F; 30=spawnbio; 31=recdev; 32=spawnbio*recdev; 33=recruitment; 34=depletion(&see Qsetup); 35=parm_dev(&see Qsetup)
#_Errtype:  -1=normal; 0=lognormal; >0=T
#_SD_Report: 0=no sdreport; 1=enable sdreport
#_Fleet Units Errtype SD_Report
1 1 0 0 # FISHERY
#_year month index obs err
2016 7 1 3.94033 0.32469 #_orig_obs: 2.00418 FISHERY
2017 7 1 2.50388 0.273876 #_orig_obs: 3.83655 FISHERY
2018 7 1 4.59436 0.344738 #_orig_obs: 2.9201 FISHERY
2019 7 1 3.95994 0.339933 #_orig_obs: 2.81445 FISHERY
2020 7 1 4.02201 0.51319 #_orig_obs: 2.29963 FISHERY
2021 7 1 2.18484 0.67507 #_orig_obs: 4.67433 FISHERY
2022 7 1 1.53812 1.34121 #_orig_obs: 12.4922 FISHERY
2023 7 1 15.7106 1.05203 #_orig_obs: 0.322465 FISHERY
2024 7 1 4.68779 0.544209 #_orig_obs: 1.34148 FISHERY
2025 7 1 1.34652 0.792608 #_orig_obs: 1.84068 FISHERY
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
 2007 1 1 0 0 108  0 1 1 17 15 14 7 14 12 10 5 7 3 1 1
 2008 1 1 0 0 89  1 1 4 7 8 10 19 10 11 4 3 4 1 4 2
 2009 1 1 0 0 84  0 1 1 5 14 5 10 17 7 12 6 3 2 1 0
 2010 1 1 0 0 31  0 1 1 1 9 2 5 3 2 2 0 3 1 1 0
 2011 1 1 0 0 46  0 0 3 5 5 6 8 4 0 6 5 1 1 2 0
 2012 1 1 0 0 69  0 0 3 3 7 10 10 7 7 7 8 6 0 0 1
 2013 1 1 0 0 41  1 1 1 1 4 9 7 5 2 4 2 3 1 0 0
 2014 1 1 0 0 58  1 1 1 3 9 12 10 5 6 2 5 2 1 0 0
 2015 1 1 0 0 76  0 0 0 4 11 15 12 10 8 8 5 1 1 0 1
 2016 1 1 0 0 60  1 1 0 1 4 11 12 9 8 7 2 0 2 1 1
 2017 1 1 0 0 84  0 0 5 6 13 11 9 10 7 7 9 3 2 2 0
 2018 1 1 0 0 41  0 3 0 4 6 7 4 4 7 3 2 1 0 0 0
 2019 -1 1 0 0 64  0 0 3 5 11 13 9 6 6 4 3 3 0 0 1
 2020 -1 -1 0 0 15  0 1 0 2 2 1 4 2 1 0 1 1 0 0 0
 2021 -1 1 0 0 36  0 2 0 2 7 5 3 7 6 1 2 0 1 0 0
 2022 1 -1 0 0 3  0 0 0 0 1 0 0 1 1 0 0 0 0 0 0
 2023 1 -1 0 0 4  0 0 0 1 0 1 0 2 0 0 0 0 0 0 0
 2024 1 -1 0 0 15  0 1 0 0 1 0 4 1 0 4 2 2 0 0 0
 2025 -1 -1 0 0 9  0 0 0 1 2 2 0 1 1 1 1 0 0 0 0
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

