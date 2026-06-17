library(r4ss)

root_dir <- this.path::here(.. = 1)
source(file.path(root_dir,"Scripts","02_SS scripts","01_Build_All_SS.R"))

r4ss:::get_ss3_exe(dir =  "C:/Users/Megumi.Oshima/Documents/2026_AmSam_Bottomfish_Update/SS3 models/PRZO/003_new_catch",version = "v3.30.19.01")

scenario <- "005_2025_endyr"
Build_All_SS(species = "APRU",
    scenario = "base", 
    startyr = 1967,
    endyr = 2025,
    fleets = 1, 
    M_option = "SW_Then",
    GROWTH_option = "SW_BBS_BIOS",
    LW_option = "Kamikawa",
    MAT_option = "SW_BBS_BIOS",
    SR_option = "FishLife",
    EST_option = "Normal",
    initF = FALSE,
    lambdas = F,
    includeCPUE = TRUE,
    superyear = TRUE,
    superyear_blocks = list(c(2019,2020),c(2022,2024)),
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
    profile.vec = c(0.5,1.5),
    do_jitter = FALSE,
    Njitter = 50,
    jitterFraction = 0.1,
    printreport = FALSE,
    r4ssplots = FALSE,
    readGoogle = TRUE
)

mods <- SSgetoutput(
    dirvec = c(file.path(root_dir, "SS3 models", "PRZO", "004_new_catch_size_cpue"), 
                file.path(root_dir, "SS3 models", "PRZO", "005_2025_endyr")))
                file.path(root_dir, "SS3 models", "PRZO", "003_new_catch_size"),
                file.path(root_dir, "SS3 models", "PRZO", "002_new_catch"),
                file.path(root_dir, "SS3 models", "PRZO", "01_Base"))) 
mods_sum <- SSsummarize(mods)
SSplotComparisons(mods_sum, legendlabels = c("new_catch_size_cpue", "new_catch_size", "new_catch", "old"), 
print = TRUE, plotdir = file.path(root_dir, "SS3 models", "PRZO", "004_new_catch_size_cpue"))
dev.off()

mods <- SSgetoutput(
    dirvec = c(file.path(root_dir, "SS3 models", "APRU", "005_2025_endyr"), 
                file.path(root_dir, "SS3 models", "APRU", "004_new_catch_size_cpue"))) 
mods_sum <- SSsummarize(mods)
SSplotComparisons(mods_sum)

mods_sum$indices %>%
ggplot(aes(x = Yr, y = Obs)) +
geom_point(aes(color = name)) 


retros <- retro(dir=file.path(root_dir, "SS3 models", "APRU", "002_new_catch"), 
               oldsubdir="", newsubdir="Retrospectives", years=0:-1, exe = "ss_opt_win.exe")

check_exe(exe = "ss_opt_win", dir  = file.path(root_dir, "SS3 models", "APRU", "002_new_catch"))
