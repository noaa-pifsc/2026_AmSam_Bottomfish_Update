#V3.30.19.01;_fast(opt);_compile_date:_Apr 15 2022;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_12.3
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-stock-synthesis/stock-synthesis
#_Start_time: Tue Apr 07 08:59:01 2026
#_expected_values
#C data file for APRU
#C file created using an r4ss function
#C file write time: 2026-04-06  17:43:24
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
1967 1 1 0.0167213 0.5
1968 1 1 0.0872342 0.5
1969 1 1 0.0175856 0.5
1970 1 1 0.00727346 0.5
1971 1 1 0.000493523 0.5
1972 1 1 0.187375 0.5
1973 1 1 0.334131 0.5
1974 1 1 0.0928574 0.5
1975 1 1 0.103696 0.5
1976 1 1 0.261535 0.5
1977 1 1 0.0689091 0.5
1978 1 1 0.0119878 0.5
1979 1 1 0.0300405 0.5
1980 1 1 1.1077 0.5
1981 1 1 0.996963 0.5
1982 1 1 2.0791 0.5
1983 1 1 1.72281 0.5
1984 1 1 1.60422 0.5
1985 1 1 4.24889 0.5
1986 1 1 3.20501 0.5
1987 1 1 0.319799 0.5
1988 1 1 0.671249 0.5
1989 1 1 0.508837 0.32586
1990 1 1 0.101088 0.5
1991 1 1 0.0773209 0.480854
1992 1 1 1.84905 0.5
1993 1 1 0.162204 0.5
1994 1 1 0.639929 0.363779
1995 1 1 0.204159 0.5
1996 1 1 1.03486 0.5
1997 1 1 1.37586 0.260358
1998 1 1 0.0918244 0.5
1999 1 1 0.267684 0.5
2000 1 1 0.677534 0.5
2001 1 1 0.476127 0.348732
2002 1 1 2.21828 0.5
2003 1 1 0.119191 0.310752
2004 1 1 0.288971 0.5
2005 1 1 0.280494 0.5
2006 1 1 0.28283 0.5
2007 1 1 1.43271 0.5
2008 1 1 0.792485 0.5
2009 1 1 3.77478 0.2
2010 1 1 0.650941 0.273691
2011 1 1 0.72055 0.5
2012 1 1 0.29317 0.5
2013 1 1 1.0593 0.5
2014 1 1 0.998651 0.5
2015 1 1 2.76563 0.277979
2016 1 1 1.66984 0.218319
2017 1 1 1.97624 0.2
2018 1 1 0.780729 0.312542
2019 1 1 1.2329 0.34192
2020 1 1 0.320177 0.394157
2021 1 1 0.0482162 0.452443
2022 1 1 0.0512791 0.5
2023 1 1 0.0646513 0.5
2024 1 1 0.422274 0.404268
2025 1 1 0.150746 0.2
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
2016 7 1 2.68373 0.32469 #_orig_obs: 2.00418 FISHERY
2017 7 1 2.62813 0.273876 #_orig_obs: 3.83655 FISHERY
2018 7 1 2.60817 0.344738 #_orig_obs: 2.9201 FISHERY
2019 7 1 2.61862 0.339933 #_orig_obs: 2.81445 FISHERY
2020 7 1 2.64575 0.51319 #_orig_obs: 2.29963 FISHERY
2021 7 1 2.7144 0.67507 #_orig_obs: 4.67433 FISHERY
2022 7 1 2.78972 1.34121 #_orig_obs: 12.4922 FISHERY
2023 7 1 2.85983 1.05203 #_orig_obs: 0.322465 FISHERY
2024 7 1 2.91174 0.544209 #_orig_obs: 1.34148 FISHERY
2025 7 1 2.95518 0.792608 #_orig_obs: 1.84068 FISHERY
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
 2007 1 1 0 0 137  0.469322 1.5618 4.0259 10.1193 16.5438 18.8829 18.5509 17.0702 15.0872 12.7974 10.0304 6.72201 3.45099 1.26839 0.419311
 2008 1 1 0 0 113  0.390025 1.30124 3.35673 8.4237 13.6734 15.4884 15.2103 14.0623 12.4687 10.5563 8.26848 5.54839 2.85375 1.05079 0.347594
 2009 1 1 0 0 106  0.374492 1.25835 3.2325 8.05421 12.9545 14.5155 14.1379 13.0739 11.6447 9.86826 7.71984 5.18327 2.6707 0.985384 0.326543
 2010 1 1 0 0 39  0.140424 0.474635 1.22849 3.06335 4.88419 5.38308 5.15874 4.72905 4.21702 3.58472 2.8037 1.88236 0.971406 0.359322 0.119529
 2011 1 1 0 0 58  0.206402 0.699827 1.81326 4.56157 7.36462 8.13907 7.71662 6.98002 6.19267 5.27649 4.13298 2.77466 1.43328 0.531274 0.17726
 2012 1 1 0 0 88  0.309922 1.04134 2.71799 6.85921 11.1726 12.5167 11.8888 10.6248 9.31799 7.92402 6.21916 4.17788 2.15952 0.801837 0.268274
 2013 1 1 0 0 52  0.18229 0.611049 1.58094 4.00043 6.55132 7.41121 7.13102 6.36564 5.51113 4.64977 3.64996 2.45501 1.26986 0.472082 0.158292
 2014 1 1 0 0 73  0.256636 0.860005 2.22265 5.58823 9.11937 10.355 10.0582 9.06409 7.80196 6.50618 5.08772 3.42493 1.7733 0.659938 0.22173
 2015 1 1 0 0 96  0.342887 1.15465 2.97174 7.4254 11.987 13.5066 13.1598 11.9775 10.354 8.55512 6.63681 4.46312 2.3132 0.861944 0.290291
 2016 1 1 0 0 76  0.276673 0.937064 2.42018 6.02987 9.6338 10.6774 10.2952 9.40079 8.19409 6.7567 5.19385 3.47928 1.80405 0.673412 0.227651
 2017 1 1 0 0 107  0.392456 1.33713 3.45618 8.63094 13.7955 15.1681 14.4124 13.0664 11.4501 9.47961 7.24162 4.82142 2.49736 0.933774 0.317002
 2018 1 1 0 0 52  0.190539 0.648074 1.68703 4.22978 6.79038 7.47411 7.03663 6.29129 5.49526 4.57224 3.48737 2.30724 1.19178 0.446124 0.152161
 2019 -1 1 0 0 81  0.292399 0.988183 2.56976 6.47991 10.5429 11.815 11.2356 9.93612 8.49342 7.02626 5.37182 3.5304 1.80948 0.676473 0.232313
 2020 -1 -1 0 0 19  0.0685875 0.231796 0.602783 1.51998 2.47302 2.77142 2.63551 2.33069 1.99228 1.64813 1.26006 0.828119 0.424447 0.158679 0.0544933
 2021 -1 1 0 0 46  0.158787 0.529035 1.36584 3.44402 5.64613 6.46262 6.38063 5.89152 5.15019 4.21306 3.15774 2.04834 1.03722 0.383744 0.131119
 2022 1 -1 0 0 4  0.0138076 0.046003 0.118769 0.29948 0.490968 0.561967 0.554837 0.512307 0.447843 0.366353 0.274586 0.178116 0.090193 0.0333691 0.0114017
 2023 1 -1 0 0 6  0.0207114 0.0690045 0.178153 0.44922 0.736452 0.84295 0.832256 0.76846 0.671764 0.54953 0.411879 0.267174 0.13529 0.0500536 0.0171025
 2024 1 -1 0 0 19  0.0655861 0.218514 0.564151 1.42253 2.3321 2.66934 2.63548 2.43346 2.12725 1.74018 1.30428 0.846052 0.428417 0.158503 0.054158
 2025 -1 -1 0 0 12  0.0414228 0.138009 0.356306 0.898439 1.4729 1.6859 1.66451 1.53692 1.34353 1.09906 0.823759 0.534348 0.270579 0.100107 0.034205
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

