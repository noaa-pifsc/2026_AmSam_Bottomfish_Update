#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Tue Apr 07 08:59:01 2026
#_bootdata:_23
#C data file for APRU
#C file created using an r4ss function
#C file write time: 2026-04-06  17:43:24
#_bootstrap file: 21  irand_seed: 123 first rand#: -0.0992735
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
1967 1 1 0.0127496 0.5
1968 1 1 0.0377043 0.5
1969 1 1 0.0292961 0.5
1970 1 1 0.00237005 0.5
1971 1 1 0.000329386 0.5
1972 1 1 0.255612 0.5
1973 1 1 0.235774 0.5
1974 1 1 0.0379928 0.5
1975 1 1 0.0657311 0.5
1976 1 1 0.246737 0.5
1977 1 1 0.0671014 0.5
1978 1 1 0.00347687 0.5
1979 1 1 0.0191062 0.5
1980 1 1 0.315075 0.5
1981 1 1 1.40874 0.5
1982 1 1 0.969502 0.5
1983 1 1 0.90954 0.5
1984 1 1 1.58307 0.5
1985 1 1 7.09089 0.5
1986 1 1 2.11608 0.5
1987 1 1 0.328087 0.5
1988 1 1 0.598162 0.5
1989 1 1 0.400742 0.32586
1990 1 1 0.0387255 0.5
1991 1 1 0.0604556 0.480854
1992 1 1 2.75617 0.5
1993 1 1 0.16305 0.5
1994 1 1 1.07769 0.363779
1995 1 1 0.111076 0.5
1996 1 1 1.3322 0.5
1997 1 1 1.82695 0.260358
1998 1 1 0.14458 0.5
1999 1 1 0.202011 0.5
2000 1 1 0.472101 0.5
2001 1 1 0.250013 0.348732
2002 1 1 1.30071 0.5
2003 1 1 0.134139 0.310752
2004 1 1 0.151965 0.5
2005 1 1 0.203975 0.5
2006 1 1 0.237614 0.5
2007 1 1 0.909005 0.5
2008 1 1 1.22861 0.5
2009 1 1 3.0046 0.2
2010 1 1 0.875756 0.273691
2011 1 1 0.825137 0.5
2012 1 1 0.137489 0.5
2013 1 1 1.02789 0.5
2014 1 1 0.47258 0.5
2015 1 1 3.78136 0.277979
2016 1 1 1.77534 0.218319
2017 1 1 1.98376 0.2
2018 1 1 0.821699 0.312542
2019 1 1 1.51578 0.34192
2020 1 1 0.225982 0.394157
2021 1 1 0.0739656 0.452443
2022 1 1 0.021334 0.5
2023 1 1 0.0276991 0.5
2024 1 1 0.318789 0.404268
2025 1 1 0.140009 0.2
-9999 0 0 0 0
#
 #_CPUE_and_surveyabundance_observations
#_Units:  0=numbers; 1=biomass; 2=F; 30=spawnbio; 31=recdev; 32=spawnbio*recdev; 33=recruitment; 34=depletion(&see Qsetup); 35=parm_dev(&see Qsetup)
#_Errtype:  -1=normal; 0=lognormal; >0=T
#_SD_Report: 0=no sdreport; 1=enable sdreport
#_Fleet Units Errtype SD_Report
1 1 0 0 # FISHERY
#_year month index obs err
2016 7 1 6.85343 0.32469 #_orig_obs: 2.00418 FISHERY
2017 7 1 3.50701 0.273876 #_orig_obs: 3.83655 FISHERY
2018 7 1 2.26357 0.344738 #_orig_obs: 2.9201 FISHERY
2019 7 1 2.02576 0.339933 #_orig_obs: 2.81445 FISHERY
2020 7 1 2.26328 0.51319 #_orig_obs: 2.29963 FISHERY
2021 7 1 2.62701 0.67507 #_orig_obs: 4.67433 FISHERY
2022 7 1 1.90009 1.34121 #_orig_obs: 12.4922 FISHERY
2023 7 1 2.01275 1.05203 #_orig_obs: 0.322465 FISHERY
2024 7 1 3.18109 0.544209 #_orig_obs: 1.34148 FISHERY
2025 7 1 5.42202 0.792608 #_orig_obs: 1.84068 FISHERY
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
 2007 1 1 0 0 108  1 3 6 10 13 15 10 18 7 11 4 6 3 1 0
 2008 1 1 0 0 89  1 0 1 8 14 13 18 10 6 8 3 6 1 0 0
 2009 1 1 0 0 84  1 0 2 7 14 7 8 13 11 8 6 4 2 1 0
 2010 1 1 0 0 31  0 0 1 0 6 5 3 3 6 4 1 0 2 0 0
 2011 1 1 0 0 46  0 0 2 5 7 4 8 9 4 4 1 0 1 1 0
 2012 1 1 0 0 69  0 0 1 4 10 9 12 8 4 5 6 7 2 1 0
 2013 1 1 0 0 41  1 1 0 3 4 8 7 5 5 2 2 1 2 0 0
 2014 1 1 0 0 58  0 0 0 5 6 9 7 6 6 10 5 3 0 0 1
 2015 1 1 0 0 76  0 0 1 4 10 9 9 14 9 7 6 2 5 0 0
 2016 1 1 0 0 60  0 0 2 5 8 7 8 8 6 4 6 2 4 0 0
 2017 1 1 0 0 84  0 1 1 9 6 6 10 15 14 6 7 3 4 2 0
 2018 1 1 0 0 41  1 1 0 2 7 8 4 8 4 2 4 0 0 0 0
 2019 -1 1 0 0 64  0 1 5 7 4 6 10 7 6 9 3 3 2 1 0
 2020 -1 -1 0 0 15  0 0 0 1 1 4 0 4 2 1 2 0 0 0 0
 2021 -1 1 0 0 36  0 0 0 4 3 3 7 5 4 2 6 2 0 0 0
 2022 1 -1 0 0 3  0 0 0 0 0 0 0 0 0 2 0 0 0 1 0
 2023 1 -1 0 0 4  0 0 0 1 0 1 0 0 0 1 1 0 0 0 0
 2024 1 -1 0 0 15  0 1 0 2 0 1 1 2 2 1 1 3 0 0 1
 2025 -1 -1 0 0 9  0 1 0 2 0 0 0 2 3 0 0 0 1 0 0
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

