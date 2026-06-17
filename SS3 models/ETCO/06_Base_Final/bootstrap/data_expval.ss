#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Mon Apr 06 17:47:02 2026
#_expected_values
#C data file for ETCO
#C file created using an r4ss function
#C file write time: 2026-04-06  17:47:00
#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
1967 #_StartYr
2025 #_EndYr
1 #_Nseas
 12 #_months/season
2 #_Nsubseasons (even number, minimum is 2)
1 #_spawn_month
2 #_Ngenders: 1, 2, -1  (use -1 for 1 sex setup with SSB multiplied by female_frac parameter)
55 #_Nages=accumulator age, first age is always age 0
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
#_catch:_columns_are_year,season,fleet,catch,catch_se
#_Catch data: yr, seas, fleet, catch, catch_se
-999 1 1 0 0.01
1967 1 1 0.0775598 0.5
1968 1 1 0.273059 0.5
1969 1 1 0.0843698 0.5
1970 1 1 0.0299399 0.5
1971 1 1 0.000999998 0.5
1972 1 1 0.798318 0.5
1973 1 1 1.11674 0.5
1974 1 1 0.771558 0.5
1975 1 1 1.02149 0.5
1976 1 1 0.834608 0.5
1977 1 1 0.368319 0.5
1978 1 1 0.14742 0.5
1979 1 1 0.12428 0.5
1980 1 1 1.89193 0.5
1981 1 1 3.59471 0.5
1982 1 1 4.6103 0.5
1983 1 1 9.30496 0.5
1984 1 1 6.90184 0.5
1985 1 1 7.37583 0.5
1986 1 1 3.95938 0.5
1987 1 1 0.796956 0.5
1988 1 1 1.37392 0.5
1989 1 1 0.667687 0.410435
1990 1 1 0.143339 0.5
1991 1 1 0.313889 0.5
1992 1 1 0.0136099 0.5
1993 1 1 0.836876 0.461778
1994 1 1 1.15893 0.213268
1995 1 1 1.38481 0.346758
1996 1 1 1.22605 0.5
1997 1 1 1.95225 0.31522
1998 1 1 2.26976 0.258636
1999 1 1 0.968866 0.413156
2000 1 1 0.333839 0.459847
2001 1 1 2.09695 0.35261
2002 1 1 0.673127 0.5
2003 1 1 0.471738 0.463612
2004 1 1 0.715767 0.5
2005 1 1 1.30633 0.5
2006 1 1 0.217719 0.5
2007 1 1 1.36077 0.5
2008 1 1 2.04115 0.482475
2009 1 1 3.25043 0.22864
2010 1 1 0.827347 0.338195
2011 1 1 2.45347 0.5
2012 1 1 0.51165 0.5
2013 1 1 1.27005 0.5
2014 1 1 2.30787 0.375471
2015 1 1 1.92322 0.230871
2016 1 1 3.06083 0.209085
2017 1 1 1.51408 0.207125
2018 1 1 1.51998 0.227297
2019 1 1 0.623687 0.287378
2020 1 1 0.633207 0.357784
2021 1 1 0.155579 0.5
2022 1 1 0.01179 0.5
2023 1 1 0.266999 0.45
2024 1 1 1.04099 0.362411
2025 1 1 0.351989 0.2
-9999 0 0 0 0
#
#
 #_CPUE_and_surveyabundance_observations
#_Units:  0=numbers; 1=biomass; 2=F; 30=spawnbio; 31=recdev; 32=spawnbio*recdev; 33=recruitment; 34=depletion(&see Qsetup); 35=parm_dev(&see Qsetup)
#_Errtype:  -1=normal; 0=lognormal; >0=T
#_SD_Report: 0=no sdreport; 1=enable sdreport
#_Fleet Units Errtype SD_Report
1 1 0 0 # FISHERY
#_year month index obs err
2016 7 1 4.19004 0.373293 #_orig_obs: 6.1399 FISHERY
2017 7 1 4.09217 0.446175 #_orig_obs: 2.8781 FISHERY
2018 7 1 4.0802 0.371427 #_orig_obs: 5.1335 FISHERY
2019 7 1 4.11821 0.494961 #_orig_obs: 2.93301 FISHERY
2020 7 1 4.2063 0.619678 #_orig_obs: 8.40102 FISHERY
2021 7 1 4.32001 1.2104 #_orig_obs: 2.09699 FISHERY
2024 7 1 4.6878 0.534672 #_orig_obs: 3.63502 FISHERY
2025 7 1 4.75975 1.45103 #_orig_obs: 0.140903 FISHERY
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
# sex codes:  0=combined; 1=use female only; 2=use male only; 3=use both as joint sexxlength distribution
# partition codes:  (0=combined; 1=discard; 2=retained
15 #_N_LengthBins
 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90
#_yr month fleet sex part Nsamp datavector(female-male)
 2007 1 1 0 0 81  1.46186 1.01919 1.91394 2.78242 3.83562 5.20867 6.73734 8.17895 9.38937 10.1105 10.159 9.27504 6.6906 3.17171 1.06578 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2008 1 1 0 0 89  1.62289 1.13086 2.11734 3.082 4.24295 5.73133 7.38657 8.9558 10.2515 11.0878 11.1811 10.1838 7.34568 3.50194 1.17856 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2009 1 1 0 0 88  1.64158 1.1465 2.14979 3.10922 4.275 5.74763 7.34061 8.84735 10.0683 10.8728 10.9947 9.99828 7.20015 3.44537 1.16278 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2011 1 1 0 0 57  1.07195 0.750077 1.41822 2.06648 2.83724 3.80122 4.83332 5.75335 6.47703 6.94359 7.04131 6.4204 4.61506 2.21736 0.75337 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2012 1 1 0 0 54  1.0157 0.7103 1.33607 1.96081 2.70576 3.63653 4.61471 5.48567 6.13829 6.54661 6.62905 6.05678 4.35526 2.0946 0.713863 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2013 1 1 0 0 53  0.98666 0.68947 1.30058 1.89436 2.63598 3.56861 4.54887 5.41262 6.04987 6.42408 6.49393 5.94597 4.2826 2.06185 0.704546 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2014 1 1 0 0 103  1.93586 1.34807 2.53078 3.70127 5.10485 6.94745 8.89785 10.5917 11.811 12.47 12.5433 11.4818 8.28014 3.98955 1.36636 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2015 1 1 0 0 60  1.14032 0.796974 1.49615 2.17012 3.00045 4.05145 5.20823 6.21596 6.91482 7.2602 7.25189 6.62106 4.77791 2.30382 0.790634 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2016 1 1 0 0 58  1.12057 0.783434 1.47602 2.1401 2.93225 3.95461 5.04867 6.03992 6.71613 7.014 6.95056 6.315 4.55516 2.19785 0.755709 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2017 1 1 0 0 40  0.780564 0.547072 1.03108 1.50231 2.05755 2.75448 3.50454 4.17546 4.65037 4.83996 4.75918 4.29578 3.09368 1.4935 0.514479 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2018 -1 1 0 0 85  1.62833 1.13623 2.14267 3.14074 4.35216 5.88596 7.49684 8.91141 9.94468 10.4146 10.1811 9.06489 6.48509 3.13234 1.083 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2019 1 -1 0 0 20  0.383137 0.267349 0.504158 0.738998 1.02404 1.38493 1.76396 2.0968 2.33992 2.4505 2.39554 2.13292 1.5259 0.737021 0.254823 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 2020 -1 -1 0 0 12  0.229882 0.16041 0.302495 0.443399 0.614422 0.830959 1.05838 1.25808 1.40395 1.4703 1.43732 1.27975 0.915542 0.442212 0.152894 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
-9999 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
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
# 0 0 70058051 67 0 0 0 #_fleet:1_FISHERY
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

