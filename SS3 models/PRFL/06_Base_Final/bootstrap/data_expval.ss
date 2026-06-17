#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Mon Apr 06 19:07:13 2026
#_expected_values
#C data file for PRFL
#C file created using an r4ss function
#C file write time: 2026-04-06  19:07:11
#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
1967 #_StartYr
2025 #_EndYr
1 #_Nseas
 12 #_months/season
2 #_Nsubseasons (even number, minimum is 2)
1 #_spawn_month
-1 #_Ngenders: 1, 2, -1  (use -1 for 1 sex setup with SSB multiplied by female_frac parameter)
28 #_Nages=accumulator age, first age is always age 0
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
1967 1 1 0.0299395 0.5
1968 1 1 0.105688 0.5
1969 1 1 0.0326594 0.5
1970 1 1 0.0113398 0.5
1971 1 1 0.000999983 0.5
1972 1 1 0.308895 0.5
1973 1 1 0.432262 0.5
1974 1 1 0.298454 0.5
1975 1 1 0.395072 0.5
1976 1 1 0.322954 0.5
1977 1 1 0.142427 0.5
1978 1 1 0.0571488 0.5
1979 1 1 0.048079 0.5
1980 1 1 0.381462 0.5
1981 1 1 0.724825 0.5
1982 1 1 0.92939 0.5
1983 1 1 1.87601 0.5
1984 1 1 1.39158 0.5
1985 1 1 1.48727 0.5
1986 1 1 1.19061 0.5
1987 1 1 0.326569 0.5
1988 1 1 0.666742 0.5
1989 1 1 0.138342 0.323813
1990 1 1 0.0154192 0.5
1991 1 1 0.275768 0.419592
1992 1 1 0.0920764 0.5
1993 1 1 0.205013 0.5
1994 1 1 0.480795 0.5
1995 1 1 0.450406 0.5
1996 1 1 0.343809 0.5
1997 1 1 0.9888 0.5
1998 1 1 0.253551 0.429071
1999 1 1 0.359688 0.5
2000 1 1 0.0929871 0.21265
2001 1 1 1.24326 0.460996
2002 1 1 0.735245 0.5
2003 1 1 0.168734 0.5
2004 1 1 0.258081 0.5
2005 1 1 0.379188 0.5
2006 1 1 0.0789276 0.5
2007 1 1 0.197764 0.5
2008 1 1 0.538395 0.5
2009 1 1 1.24145 0.26664
2010 1 1 0.162835 0.356797
2011 1 1 0.356969 0.5
2012 1 1 0.288021 0.5
2013 1 1 0.280762 0.5
2014 1 1 0.292562 0.5
2015 1 1 0.554725 0.479431
2016 1 1 0.600083 0.28581
2017 1 1 0.0925273 0.336114
2018 1 1 0.160566 0.310018
2019 1 1 0.114757 0.378188
2020 1 1 0.0752981 0.407456
2021 1 1 0.0113849 0.3993
2022 1 1 0.0181396 0.5
2023 1 1 0.0757484 0.495937
2024 1 1 0.426371 0.38829
2025 1 1 0.092528 0.365683
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
2016 7 1 1.03194 0.413627 #_orig_obs: 1.62876 FISHERY
2017 7 1 1.04875 0.423076 #_orig_obs: 0.547681 FISHERY
2018 7 1 1.1107 0.322296 #_orig_obs: 1.14405 FISHERY
2019 7 1 1.16513 0.413219 #_orig_obs: 0.625894 FISHERY
2020 7 1 1.22302 0.450625 #_orig_obs: 0.812478 FISHERY
2022 7 1 1.34669 0.891842 #_orig_obs: 2.2463 FISHERY
2023 7 1 1.39453 0.579796 #_orig_obs: 0.870253 FISHERY
2024 7 1 1.39518 0.367431 #_orig_obs: 2.59283 FISHERY
2025 7 1 1.39148 0.584939 #_orig_obs: 3.27279 FISHERY
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
53 # maximum size in the population (lower edge of last bin) 
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
11 #_N_LengthBins
 18 21 24 27 30 33 36 39 42 45 48
#_yr month fleet sex part Nsamp datavector(female-male)
 2011 -1 1 0 0 94  0.297665 2.65083 5.06199 12.774 14.0672 16.3783 17.9726 14.8733 7.42561 2.10022 0.398227
 2012 -1 -1 0 0 79  0.250165 2.22782 4.25423 10.7356 11.8225 13.7647 15.1046 12.4999 6.24067 1.76508 0.33468
 2013 1 1 0 0 83  0.258438 2.28682 4.38767 11.0748 12.1614 14.3578 16.1745 13.4418 6.6408 1.86337 0.352582
 2015 1 1 0 0 40  0.123494 1.086 2.05527 5.16606 5.69852 6.81724 7.87796 6.71675 3.34815 0.936001 0.174555
 2018 -1 1 0 0 52  0.151619 1.3065 2.52931 6.44081 7.25498 8.88339 10.394 8.97182 4.54091 1.28645 0.24018
 2019 1 -1 0 0 16  0.0466519 0.402001 0.778249 1.98179 2.2323 2.73335 3.19816 2.76056 1.3972 0.39583 0.0739016
 2020 -1 -1 0 0 12  0.034989 0.301501 0.583687 1.48634 1.67423 2.05001 2.39862 2.07042 1.0479 0.296872 0.0554262
 2022 -1 1 0 0 70  0.191655 1.6014 3.08376 7.8331 8.89333 11.3517 14.317 13.284 7.03057 2.03732 0.376116
 2023 1 -1 0 0 9  0.0246413 0.205894 0.396483 1.00711 1.14343 1.4595 1.84076 1.70795 0.903931 0.261942 0.0483578
 2024 1 -1 0 0 34  0.0930895 0.777823 1.49783 3.80465 4.31962 5.51368 6.95398 6.45224 3.41485 0.989557 0.182685
 2025 -1 -1 0 0 25  0.0684482 0.571929 1.10134 2.79754 3.17619 4.05417 5.11322 4.7443 2.51092 0.727616 0.134327
-9999 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
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
# 0 0 67 67 0 0 0 #_fleet:1_FISHERY
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

