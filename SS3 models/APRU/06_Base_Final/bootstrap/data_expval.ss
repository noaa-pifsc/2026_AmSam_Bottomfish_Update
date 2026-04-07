#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Mon Apr 06 17:15:30 2026
#_expected_values
#C data file for APRU
#C file created using an r4ss function
#C file write time: 2026-04-06  17:15:28
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
1977 1 1 0.0816498 0.5
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
1995 1 1 0.433629 0.5
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
2025 1 1 0.201849 0.2
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
2016 7 1 2.65631 0.32469 #_orig_obs: 2.00418 FISHERY
2017 7 1 2.62963 0.273876 #_orig_obs: 3.83655 FISHERY
2018 7 1 2.62297 0.344738 #_orig_obs: 2.9201 FISHERY
2019 7 1 2.62923 0.339933 #_orig_obs: 2.81445 FISHERY
2020 7 1 2.65746 0.51319 #_orig_obs: 2.29963 FISHERY
2021 7 1 2.72581 0.67507 #_orig_obs: 4.67433 FISHERY
2022 7 1 2.79725 1.34121 #_orig_obs: 12.4922 FISHERY
2023 7 1 2.86015 1.05203 #_orig_obs: 0.322465 FISHERY
2024 7 1 2.90228 0.544209 #_orig_obs: 1.34148 FISHERY
2025 7 1 2.93791 0.792608 #_orig_obs: 1.84068 FISHERY
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
 2007 1 1 0 0 137  0.46907 1.55981 4.02079 10.1101 16.5365 18.8634 18.5006 17.0062 15.0438 12.7851 10.052 6.78731 3.52464 1.30788 0.432809
 2008 1 1 0 0 113  0.391535 1.30547 3.36222 8.4225 13.6613 15.4787 15.1893 14.0195 12.4259 10.5364 8.27741 5.58925 2.90382 1.07905 0.3577
 2009 1 1 0 0 106  0.376296 1.26446 3.24764 8.08627 12.9795 14.5108 14.1169 13.0342 11.5925 9.82958 7.71011 5.20475 2.70542 1.0068 0.334689
 2010 1 1 0 0 39  0.140218 0.473924 1.22549 3.05763 4.88442 5.38795 5.15963 4.72551 4.20756 3.57494 2.80161 1.88981 0.982724 0.366328 0.122254
 2011 1 1 0 0 58  0.207005 0.700529 1.81508 4.55851 7.35526 8.14077 7.72242 6.97878 6.18354 5.26298 4.12668 2.78142 1.44639 0.539881 0.180752
 2012 1 1 0 0 88  0.312461 1.0507 2.73474 6.8897 11.1899 12.5054 11.88 10.6143 9.29691 7.89577 6.19809 4.17662 2.17146 0.811384 0.272491
 2013 1 1 0 0 52  0.184176 0.618887 1.59932 4.03408 6.58136 7.41552 7.11418 6.34815 5.49172 4.62696 3.63048 2.44725 1.27214 0.475652 0.160137
 2014 1 1 0 0 73  0.260531 0.875762 2.26225 5.66964 9.20065 10.3822 10.031 9.01244 7.75136 6.45646 5.04458 3.40055 1.76792 0.661419 0.223255
 2015 1 1 0 0 96  0.346134 1.16839 3.01238 7.53436 12.1412 13.5954 13.1487 11.8992 10.2597 8.46807 6.56279 4.41633 2.29649 0.859829 0.291057
 2016 1 1 0 0 76  0.275815 0.933618 2.41389 6.03402 9.69717 10.7797 10.3512 9.38766 8.14249 6.70052 5.1453 3.44723 1.79181 0.671528 0.228054
 2017 1 1 0 0 107  0.389401 1.31971 3.41601 8.55523 13.7647 15.2684 14.5606 13.1401 11.4379 9.43191 7.19384 4.78836 2.48441 0.931888 0.317566
 2018 1 1 0 0 52  0.188948 0.63971 1.659 4.16515 6.72384 7.47257 7.1064 6.36907 5.53184 4.57524 3.47961 2.30034 1.18942 0.446249 0.152606
 2019 -1 1 0 0 81  0.29113 0.981657 2.54608 6.41042 10.4185 11.699 11.2149 10.0294 8.62492 7.11028 5.40486 3.54184 1.81472 0.678963 0.23333
 2020 -1 -1 0 0 19  0.0682898 0.230265 0.597228 1.50368 2.44385 2.7442 2.63065 2.35259 2.02313 1.66784 1.26781 0.830802 0.425675 0.159263 0.0547318
 2021 -1 1 0 0 46  0.158808 0.528584 1.36322 3.43342 5.62257 6.42993 6.3451 5.86482 5.15284 4.25201 3.20472 2.07673 1.04835 0.386979 0.131931
 2022 1 -1 0 0 4  0.0138094 0.0459638 0.118541 0.298558 0.488919 0.559124 0.551748 0.509984 0.448073 0.36974 0.278671 0.180585 0.0911606 0.0336503 0.0114723
 2023 1 -1 0 0 6  0.0207141 0.0689457 0.177811 0.447837 0.733379 0.838686 0.827622 0.764977 0.67211 0.55461 0.418007 0.270877 0.136741 0.0504755 0.0172084
 2024 1 -1 0 0 19  0.0655946 0.218328 0.563069 1.41815 2.32237 2.65584 2.6208 2.42243 2.12835 1.75626 1.32369 0.857778 0.433013 0.159839 0.0544933
 2025 -1 -1 0 0 12  0.0414282 0.137891 0.355623 0.895674 1.46676 1.67737 1.65524 1.52995 1.34422 1.10922 0.836014 0.541755 0.273482 0.100951 0.0344168
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

