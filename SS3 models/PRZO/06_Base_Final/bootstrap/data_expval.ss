#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Mon Apr 06 19:25:49 2026
#_expected_values
#C data file for PRZO
#C file created using an r4ss function
#C file write time: 2026-04-06  19:25:47
#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
1967 #_StartYr
2025 #_EndYr
1 #_Nseas
 12 #_months/season
2 #_Nsubseasons (even number, minimum is 2)
1 #_spawn_month
2 #_Ngenders: 1, 2, -1  (use -1 for 1 sex setup with SSB multiplied by female_frac parameter)
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
1967 1 1 0.0158796 0.5
1968 1 1 0.0562487 0.5
1969 1 1 0.0172396 0.5
1970 1 1 0.00634985 0.5
1971 1 1 0.000999977 0.5
1972 1 1 0.164646 0.5
1973 1 1 0.230415 0.5
1974 1 1 0.159206 0.5
1975 1 1 0.210465 0.5
1976 1 1 0.172356 0.5
1977 1 1 0.075748 0.5
1978 1 1 0.0303892 0.5
1979 1 1 0.0253993 0.5
1980 1 1 0.37647 0.5
1981 1 1 0.715751 0.5
1982 1 1 0.917593 0.5
1983 1 1 1.85195 0.5
1984 1 1 1.37384 0.5
1985 1 1 1.46778 0.5
1986 1 1 0.671291 0.5
1987 1 1 0.136021 0.5
1988 1 1 0.356972 0.5
1989 1 1 0.214464 0.46734
1990 1 1 0.158221 0.5
1991 1 1 0.0444306 0.2
1992 1 1 0.126064 0.5
1993 1 1 0.0943283 0.5
1994 1 1 0.297507 0.2
1995 1 1 0.175509 0.5
1996 1 1 0.190931 0.5
1997 1 1 0.319738 0.5
1998 1 1 0.170978 0.5
1999 1 1 0.114747 0.5
2000 1 1 0.0594144 0.2
2001 1 1 0.077104 0.5
2002 1 1 0.0576061 0.5
2003 1 1 0.0571467 0.5
2004 1 1 0.0857256 0.5
2005 1 1 0.165552 0.5
2006 1 1 0.0612273 0.5
2007 1 1 0.130625 0.5
2008 1 1 0.25582 0.5
2009 1 1 0.0943464 0.329973
2010 1 1 0.0857269 0.318367
2011 1 1 0.0757474 0.5
2012 1 1 0.0317459 0.5
2013 1 1 0.0734777 0.5
2014 1 1 0.127006 0.5
2015 1 1 0.109767 0.5
2016 1 1 0.259444 0.2
2017 1 1 0.244933 0.2
2018 1 1 0.126546 0.218618
2019 1 1 0.0716678 0.273842
2020 1 1 0.0503485 0.418
2021 1 1 0.00637732 0.453778
2022 1 1 0.0149696 0.32521
2023 1 1 0.0122497 0.463714
2024 1 1 0.0557885 0.458732
2025 1 1 0.0163296 0.299352
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
2016 7 1 0.473108 0.26565 #_orig_obs: 0.791646 FISHERY
2017 7 1 0.467627 0.285772 #_orig_obs: 0.717598 FISHERY
2018 7 1 0.468346 0.309554 #_orig_obs: 0.460041 FISHERY
2019 7 1 0.477191 0.554613 #_orig_obs: 0.174581 FISHERY
2020 7 1 0.48912 0.604343 #_orig_obs: 0.224391 FISHERY
2023 7 1 0.530971 1.29552 #_orig_obs: 0.0917215 FISHERY
2024 7 1 0.540763 0.526024 #_orig_obs: 0.146969 FISHERY
2025 7 1 0.549096 0.877069 #_orig_obs: 0.218985 FISHERY
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
44 # maximum size in the population (lower edge of last bin) 
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
13 #_N_LengthBins
 16 18 20 22 24 26 28 30 32 34 36 38 40
#_yr month fleet sex part Nsamp datavector(female-male)
 2007 1 1 0 0 57  0.343757 0.485522 2.30462 5.63699 6.44161 7.79922 7.95982 8.11074 7.458 5.57269 3.18527 1.29363 0.408137 0 0 0 0 0 0 0 0 0 0 0 0 0
 2009 -1 1 0 0 38  0.214136 0.301842 1.43273 3.50845 4.03143 4.91243 5.07336 5.29225 5.11068 4.09075 2.52545 1.12117 0.385298 0 0 0 0 0 0 0 0 0 0 0 0 0
 2010 1 -1 0 0 16  0.0901627 0.127091 0.603255 1.47724 1.69745 2.06839 2.13615 2.22832 2.15187 1.72242 1.06335 0.472073 0.162231 0 0 0 0 0 0 0 0 0 0 0 0 0
 2011 -1 -1 0 0 13  0.0732572 0.103262 0.490145 1.20026 1.37917 1.68057 1.73562 1.81051 1.74839 1.39947 0.863971 0.38356 0.131812 0 0 0 0 0 0 0 0 0 0 0 0 0
 2012 -1 1 0 0 62  0.328019 0.460704 2.17362 5.32453 6.16435 7.61831 8.07237 8.66356 8.62522 7.13926 4.5613 2.10999 0.75877 0 0 0 0 0 0 0 0 0 0 0 0 0
 2013 1 -1 0 0 16  0.0846501 0.118891 0.560935 1.37407 1.5908 1.96602 2.08319 2.23576 2.22586 1.84239 1.17711 0.544514 0.195812 0 0 0 0 0 0 0 0 0 0 0 0 0
 2014 -1 -1 0 0 6  0.0317438 0.0445843 0.21035 0.515277 0.59655 0.737256 0.781197 0.838409 0.834698 0.690897 0.441416 0.204193 0.0734293 0 0 0 0 0 0 0 0 0 0 0 0 0
 2015 -1 1 0 0 68  0.354474 0.497038 2.33195 5.69279 6.54659 8.04973 8.53373 9.3112 9.56888 8.19967 5.39727 2.5675 0.949188 0 0 0 0 0 0 0 0 0 0 0 0 0
 2016 -1 -1 0 0 32  0.166811 0.2339 1.09739 2.67896 3.08075 3.78811 4.01587 4.38174 4.503 3.85867 2.53989 1.20824 0.446677 0 0 0 0 0 0 0 0 0 0 0 0 0
 2017 1 1 0 0 61  0.321068 0.450799 2.12196 5.16841 5.88392 7.1819 7.57274 8.25069 8.5252 7.37797 4.90679 2.35829 0.880254 0 0 0 0 0 0 0 0 0 0 0 0 0
-9999 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
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
# 0 0 101646403 -1025310653 0 0 0 #_fleet:1_FISHERY
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

