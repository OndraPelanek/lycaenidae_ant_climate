# Rerun the whole analysis: knit the notebooks in order, each in a fresh R session. Run from the
# repository root:
#   Rscript code/run_all.R            all notebooks
#   Rscript code/run_all.R s02        from s02 to the last notebook
#   Rscript code/run_all.R s01 s01    s01 only
# Each notebook is knitted with resrepo::knit_to_results(), as by Knit in RStudio, so its
# rendered HTML is saved in results/<notebook>/. The run stops at the first notebook that fails.

notebooks <- c("s01_prepare_climate", "s02_build_assemblages", "s03_explore_climate",
               "s04_fit_phylogenetic_models", "s05_compare_regions", "s06_test_stability",
               "s07_compare_mediterranean", "s08_test_southern_drivers", "s09_test_history",
               "s10_test_diversification", "s11_test_seasonality", "s12_audit_evidence",
               "s13_compare_matched_climates", "s14_test_null_models", "s15_test_association",
               "s16_make_maps", "s17_make_figures", "s18_audit_shared_climates",
               "s19_test_mixed_genera", "s20_predict_held_out", "s21_test_ant_partners",
               "s23_test_dispersal", "s24_compare_all_climates",
               "s25_test_convergence", "s26_test_knowledge", "s27_test_ant_communities",
               "s28_test_robustness", "s29_test_dry_availability", "s30_test_ant_traits",
               "s31_test_dry_habitat", "s32_test_flight_timing", "s33_test_confinement",
               "s34_test_niche_availability", "s35_prepare_dry_niche", "s36_test_dry_niche",
               "s37_test_dry_niche_v2", "s38_diagnose_identifiability", "s39_audit_occurrences_origins",
               "s40_simulate_power", "s41_test_matched_case_case", "s42_test_four_strategies",
               "s43_decompose_southern_faunas", "s44_test_confinement_contrasts",
               # The paper figures combine the outputs of s06-s44, so they come last
               "s22_make_paper_figures")
steps <- substr(notebooks, 1, 3)

# --- Notebooks to run ---
args <- commandArgs(trailingOnly = TRUE)
from <- if (length(args) >= 1) match(args[1], steps) else 1L
to <- if (length(args) >= 2) match(args[2], steps) else length(steps)
if (is.na(from) || is.na(to) || from > to) {
  stop("Give the first and, optionally, the last notebook as ", paste(steps, collapse = ", "),
       ", for example: Rscript code/run_all.R s02")
}

# --- Repository root and Pandoc ---
if (!file.exists(".resrepo_version")) stop("Run this script from the repository root.")
# Pandoc ships with RStudio; outside RStudio, use its bundled copy when none is on the PATH.
if (!rmarkdown::pandoc_available() && .Platform$OS.type == "windows") {
  candidate <- "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools"
  if (file.exists(file.path(candidate, "pandoc.exe"))) Sys.setenv(RSTUDIO_PANDOC = candidate)
}
if (!rmarkdown::pandoc_available()) stop("Pandoc is required; set RSTUDIO_PANDOC to its directory.")

# --- Knit the notebooks, each in a fresh R session ---
rscript <- file.path(R.home("bin"), "Rscript")
started <- Sys.time()
for (i in from:to) {
  message(format(Sys.time(), "%Y-%m-%d %H:%M"), "  knitting ", notebooks[i])
  call <- sprintf("resrepo::knit_to_results('code/%s.Rmd')", notebooks[i])
  status <- system2(rscript, c("-e", shQuote(call)))
  if (status != 0) {
    stop(notebooks[i], " failed. After fixing it, resume with: Rscript code/run_all.R ", steps[i])
  }
}
message(format(Sys.time(), "%Y-%m-%d %H:%M"), "  finished in ",
        format(round(difftime(Sys.time(), started, units = "hours"), 2)))
