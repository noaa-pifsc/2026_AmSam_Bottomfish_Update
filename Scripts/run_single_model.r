library(r4ss)

root_dir <- this.path::here(.. = 1)
source(file.path(root_dir,"Scripts","02_SS scripts","01_Build_All_SS.R"))



scenario <- "003_new_data_all"
Build_All_SS(species = "CALU",
    scenario = "base", 
    startyr = 1967,
    endyr = 2024,
    fleets = 1, 
    M_option = "Fry_Then",
    GROWTH_option = "SW_BBS_BIOS",
    LW_option = "Kamikawa",
    MAT_option = "SW_BBS_BIOS",
    SR_option = "FishLife",
    EST_option = "Normal",
    initF = FALSE,
    lambdas = F,
    includeCPUE = TRUE,
    superyear = TRUE,
    superyear_blocks = list(c(2009,2011),c(2016,2017),c(2018,2020)),
    N_samp = 45,
    init_values = 0, 
    parmtrace = 0,
    last_est_phs = 10,
    seed = 0123,
    F_report_basis = 0, 
    benchmarks = 1,
    MSY = 2,
    SPR.target = 0.4,
    Btarget = 0.29,
    Bmark_years = c(0,0,0,0,0,0,0,0,0,0),
    Bmark_relF_Basis = 1,
    Forecast = -1,
    Nforeyrs = 0, 
    Fcast_years = c(0,0,0,0,-999,0),
    ControlRule = 0,
    root_dir = root_dir,
    file_dir = scenario,
    template_dir = file.path(root_dir, 
                            "SS3 models", "TEMPLATE_FILES"), 
    out_dir = file.path(root_dir, "SS3 models"),
    write_files = TRUE,
    runmodels = TRUE,
    ext_args = "",
    do_retro = FALSE,
    retro_years = 0:-5,
    do_profile = FALSE,
    profile = "SR_LN(R0)",
    profile.vec = seq(8.2, 8.4, .1),
    do_jitter = FALSE,
    Njitter = 200,
    jitterFraction = 0.1,
    printreport = FALSE,
    r4ssplots = TRUE,
    readGoogle = TRUE
)

mods <- SSgetoutput(
    dirvec = c(file.path(root_dir, "SS3 models", "CALU", "003_new_data_all"), 
                file.path(root_dir, "SS3 models", "CALU", "01_Base"))) 
mods_sum <- SSsummarize(mods)
SSplotComparisons(mods_sum, legendlabels = c("new", "old"))


mods <- SSgetoutput(
    dirvec = c(file.path(root_dir, "SS3 models", "PRFL", "003_new_cpue_2"), 
                file.path(root_dir, "SS3 models", "PRFL", "01_Base"))) 
mods_sum <- SSsummarize(mods)
SSplotComparisons(mods_sum)

mods_sum$indices %>%
ggplot(aes(x = Yr, y = Obs)) +
geom_point(aes(color = name)) 
