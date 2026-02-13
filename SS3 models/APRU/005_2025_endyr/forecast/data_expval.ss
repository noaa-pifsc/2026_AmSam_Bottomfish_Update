#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Fri Feb 13 11:40:03 2026
#_expected_values
#C data file for APRU
#C file created using an r4ss function
#C file write time: 2026-02-13  11:14:27
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
#_catch:_columns_are_year,season,fleet,catch,catch_se
#_Catch data: yr, seas, fleet, catch, catch_se
-999 1 1 0 0.01
1967 1 1 0.0172399 0.5
1968 1 1 0.0603298 0.5
1969 1 1 0.0185999 0.5
1970 1 1 0.00679998 0.5
1971 1 1 0.000999997 0.5
1972 1 1 0.176899 0.5
1973 1 1 0.247209 0.5
1974 1 1 0.170999 0.5
1975 1 1 0.226339 0.5
1976 1 1 0.185069 0.5
1977 1 1 0.0816497 0.5
1978 1 1 0.0326599 0.5
1979 1 1 0.0276699 0.5
1980 1 1 0.661338 0.5
1981 1 1 1.2569 0.5
1982 1 1 1.61206 0.5
1983 1 1 3.25315 0.5
1984 1 1 2.4131 0.5
1985 1 1 2.57866 0.5
1986 1 1 1.56579 0.5
1987 1 1 0.465838 0.5
1988 1 1 1.15303 0.5
1989 1 1 0.585588 0.32586
1990 1 1 0.0648598 0.5
1991 1 1 0.12156 0.480854
1992 1 1 0.324319 0.5
1993 1 1 0.181889 0.5
1994 1 1 0.688548 0.363779
1995 1 1 0.433628 0.5
1996 1 1 1.31451 0.5
1997 1 1 1.29138 0.260358
1998 1 1 0.174629 0.5
1999 1 1 0.400979 0.5
2000 1 1 0.522538 0.5
2001 1 1 0.553378 0.348732
2002 1 1 2.20581 0.5
2003 1 1 0.248109 0.310752
2004 1 1 0.439078 0.5
2005 1 1 0.472188 0.5
2006 1 1 0.198669 0.5
2007 1 1 1.25373 0.5
2008 1 1 1.63836 0.5
2009 1 1 3.2527 0.2
2010 1 1 0.677667 0.273691
2011 1 1 1.18886 0.5
2012 1 1 0.531159 0.5
2013 1 1 1.3381 0.5
2014 1 1 1.63111 0.5
2015 1 1 1.8452 0.277979
2016 1 1 1.42836 0.218319
2017 1 1 1.56488 0.2
2018 1 1 0.902186 0.312542
2019 1 1 1.24375 0.34192
2020 1 1 0.239039 0.394157
2021 1 1 0.0335699 0.452443
2022 1 1 0.0585098 0.5
2023 1 1 0.153769 0.5
2024 1 1 0.531608 0.404268
2025 1 1 0.531608 0.404268
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
2016 7 1 3.12126 0.325456 #_orig_obs: 2.18837 FISHERY
2017 7 1 3.08929 0.26956 #_orig_obs: 4.16471 FISHERY
2018 7 1 3.08131 0.336674 #_orig_obs: 3.55139 FISHERY
2019 7 1 3.08883 0.334198 #_orig_obs: 3.2903 FISHERY
2020 7 1 3.12269 0.499921 #_orig_obs: 3.09871 FISHERY
2021 7 1 3.20464 0.655978 #_orig_obs: 5.53917 FISHERY
2022 7 1 3.29028 1.30113 #_orig_obs: 15.5935 FISHERY
2023 7 1 3.36565 1.02082 #_orig_obs: 0.429893 FISHERY
2024 7 1 3.41611 0.537491 #_orig_obs: 1.53809 FISHERY
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
 2007 1 1 0 0 137  0.466685 1.51773 3.87673 9.81304 16.3444 18.8965 18.6331 17.1542 15.1739 12.8863 10.1222 6.82743 3.54147 1.31257 0.433688
 2008 1 1 0 0 113  0.389613 1.27053 3.24275 8.1782 13.5074 15.5081 15.2969 14.1389 12.5324 10.6197 8.33479 5.62187 2.91747 1.08286 0.358423
 2009 1 1 0 0 106  0.374597 1.23129 3.13448 7.8579 12.8428 14.5455 14.2182 13.1423 11.6886 9.90545 7.76206 5.23394 2.71751 1.01014 0.33532
 2010 1 1 0 0 39  0.139614 0.461613 1.18307 2.97244 4.83623 5.40499 5.19888 4.76444 4.24106 3.60139 2.81971 1.89985 0.986807 0.367438 0.122459
 2011 1 1 0 0 58  0.206094 0.682292 1.75211 4.43059 7.2811 8.16812 7.7853 7.03845 6.23232 5.30076 4.1526 2.79571 1.45212 0.541417 0.18103
 2012 1 1 0 0 88  0.311066 1.02314 2.6394 6.69529 11.075 12.5454 11.9796 10.7098 9.37144 7.95105 6.2356 4.19721 2.1796 0.813522 0.272867
 2013 1 1 0 0 52  0.183347 0.602632 1.54335 3.91966 6.51251 7.43736 7.17295 6.4071 5.53751 4.65926 3.65172 2.45881 1.27665 0.47681 0.160333
 2014 1 1 0 0 73  0.25939 0.852874 2.18352 5.50974 9.10548 10.4125 10.112 9.0958 7.81786 6.50204 5.07309 3.41566 1.77371 0.662854 0.223482
 2015 1 1 0 0 96  0.344679 1.13816 2.90835 7.32425 12.0193 13.6375 13.2542 12.0072 10.348 8.5288 6.59899 4.43463 2.30326 0.861432 0.291283
 2016 1 1 0 0 76  0.274691 0.909609 2.33103 5.86711 9.60243 10.8162 10.4356 9.47183 8.21157 6.74885 5.17336 3.46057 1.79647 0.672556 0.228172
 2017 1 1 0 0 107  0.387841 1.28589 3.29916 8.31968 13.632 15.3228 14.6823 13.2583 11.5334 9.49937 7.23282 4.8059 2.49006 0.932996 0.317646
 2018 1 1 0 0 52  0.188189 0.623288 1.60213 4.05027 6.6591 7.49982 7.16695 6.42728 5.57778 4.60747 3.49828 2.30842 1.19177 0.446631 0.152604
 2019 -1 1 0 0 81  0.289908 0.956203 2.45792 6.23104 10.3142 11.7388 11.3107 10.1241 8.69894 7.16055 5.43362 3.55389 1.81773 0.679223 0.233231
 2020 -1 -1 0 0 19  0.0680031 0.224295 0.576549 1.4616 2.41938 2.75354 2.65313 2.37478 2.04049 1.67964 1.27455 0.833628 0.426381 0.159324 0.0547086
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

