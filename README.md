# Climate and the geography of ant-interaction strategies in lycaenid butterflies

This repository contains the analysis of how much of the geographic variation in the ant-interaction strategies of lycaenid butterflies (none, facultative, obligate mutualism and obligate parasitism) is associated with present and past climate. It builds on [`butterfly_ant_interactions`](https://github.com/OndraPelanek/butterfly_ant_interactions), which compiled the interaction dataset, cleaned the GBIF occurrences and mapped the proportions of the strategies in 500-km equal-area cells; its species table and cleaned records are the starting data here. The study is at an exploratory stage: the hypotheses and the planned design are in [`writing/study_plan.md`](writing/study_plan.md), and the literature behind them in [`writing/literature_review.md`](writing/literature_review.md).

## Workflow

R Markdown notebooks in `code/` are run in numerical order:

1.  [`s01_prepare_climate.Rmd`](code/s01_prepare_climate.Rmd) summarises present climate (WorldClim 2.1), productivity, the anomaly and velocity of climate change since the Last Glacial Maximum and climate variability over the last 800,000 years (Krapp et al. 2021, through `pastclim`), and realms and biomes, in 250-, 500- and 1,000-km Equal Earth cells.
2.  [`s02_build_assemblages.Rmd`](code/s02_build_assemblages.Rmd) places every species in the cells holding its cleaned records, counts the species of each strategy per cell (checked against the cell table of `butterfly_ant_interactions`) and summarises the climate of each species.
3.  [`s03_explore_climate.Rmd`](code/s03_explore_climate.Rmd) explores the associations: predictor collinearity, single-predictor models, the partitioning of deviance among present climate, past climate, space and realm, transfer of climate models between realms (with extrapolation and coverage checks), and species-level models separating differences within and between genera.
4.  [`s04_fit_phylogenetic_models.Rmd`](code/s04_fit_phylogenetic_models.Rmd) models the strategies of species: phylogenetic logistic regression on two trees, the partition of climate and lineage, the transfer of climate-only models to held-out genera and subfamilies, and the aggregation of species predictions to the cell maps.
5.  [`s05_compare_regions.Rmd`](code/s05_compare_regions.Rmd) compares climate relationships within eight biogeographic regions, separates lineage turnover from change within lineages along climate gradients, and checks robustness to grain, grid (Equal Earth squares and ISEA hexagons), weighting and minimum species.
6.  [`s06_test_stability.Rmd`](code/s06_test_stability.Rmd) tests whether the obligacy signal reflects glacial stability or southern geography.
7.  [`s07_compare_mediterranean.Rmd`](code/s07_compare_mediterranean.Rmd) compares the five Mediterranean-climate regions, overall and as climate-matched cells.
8.  [`s08_test_southern_drivers.Rmd`](code/s08_test_southern_drivers.Rmd) tests soils, fire and seasonal drought as explanations of the southern concentration of obligate associates.
9.  [`s09_test_history.Rmd`](code/s09_test_history.Rmd) reconstructs how that concentration arose: correlated evolution with hemisphere and the origins of obligacy by region.
10. [`s10_test_diversification.Rmd`](code/s10_test_diversification.Rmd) checks the origins on a tree of genera and compares the diversification rates of obligate and other genera.
11. [`s11_test_seasonality.Rmd`](code/s11_test_seasonality.Rmd) tests the association of precipitation seasonality with obligacy under strong controls (evidence basis, large genera, regions, genera, phylogeny) and the prediction of each held-out subfamily.
12. [`s12_audit_evidence.Rmd`](code/s12_audit_evidence.Rmd) tabulates the evidence behind the strategies by region and lineage, and repeats the main species-level results out of sample and with species-specific evidence only.
13. [`s13_compare_matched_climates.Rmd`](code/s13_compare_matched_climates.Rmd) compares the strategies of regions within climates they share (Mediterranean-climate regions, and the same climates elsewhere), with completeness bounds and genus resampling.
14. [`s14_test_null_models.Rmd`](code/s14_test_null_models.Rmd) tests the seasonality and lineage-turnover results against permutations within genera, and counts the origins of obligacy on trees without grafted species.
15. [`s15_test_association.Rmd`](code/s15_test_association.Rmd) analyses ant association (non-associated against associated species) along latitude and temperature in the Holarctic and among species of every region.
16. [`s16_make_maps.Rmd`](code/s16_make_maps.Rmd) draws the world maps of the strategies and of the climates shared with the Cape and southern Australia.
17. [`s17_make_figures.Rmd`](code/s17_make_figures.Rmd) combines the outputs of earlier notebooks into the main figures of the working manuscript.
18. [`s18_audit_shared_climates.Rmd`](code/s18_audit_shared_climates.Rmd) audits the comparison within shared climates: standardised composition, climatic balance, retention, sensitivity to the strata and genus weighting.
19. [`s19_test_mixed_genera.Rmd`](code/s19_test_mixed_genera.Rmd) separates precipitation seasonality from drought, corrects for multiple testing and tests every genus with obligate and facultative species against permutations.
20. [`s20_predict_held_out.Rmd`](code/s20_predict_held_out.Rmd) predicts held-out realms and subfamilies, with calibration, discrimination and climatic novelty.
21. [`s21_test_ant_partners.Rmd`](code/s21_test_ant_partners.Rmd) adds ant richness and the partner genera of obligate species.
22. [`s22_make_paper_figures.Rmd`](code/s22_make_paper_figures.Rmd) combines the outputs into the main figures of the paper.
23. [`s23_test_dispersal.Rmd`](code/s23_test_dispersal.Rmd) tests whether obligate lineages spread less than other lineages of the same age and size.
24. [`s24_compare_all_climates.Rmd`](code/s24_compare_all_climates.Rmd) compares every pair of regions within the climates they share, with southern Africa and Australia against all others.
25. [`s25_test_convergence.Rmd`](code/s25_test_convergence.Rmd) estimates how often obligacy arose per million years of lineage history in each group of regions.
26. [`s26_test_knowledge.Rmd`](code/s26_test_knowledge.Rmd) tests whether knowledge of life histories could explain the regional ordering of obligacy.
27. [`s27_test_ant_communities.Rmd`](code/s27_test_ant_communities.Rmd) relates obligacy to the dominance of partner ant genera in sampled local ant communities.
28. [`s28_test_robustness.Rmd`](code/s28_test_robustness.Rmd) checks the main results against a flexible climate model, species-specific evidence and genus-level analyses of dry seasons.
29. [`s29_test_dry_availability.Rmd`](code/s29_test_dry_availability.Rmd) separates the dry months available where each species occurs from its use of drier places within them.
30. [`s30_test_ant_traits.Rmd`](code/s30_test_ant_traits.Rmd) tests the colony size, queen number and supercoloniality of the ant species recorded with obligate and facultative lycaenids.
31. [`s31_test_dry_habitat.Rmd`](code/s31_test_dry_habitat.Rmd) asks whether the drier places of obligate mutualists differ in rain, warmth, elevation or vegetation, or only in the length of the dry season.
32. [`s32_test_flight_timing.Rmd`](code/s32_test_flight_timing.Rmd) asks whether obligate mutualists fly in or just after the dry season more than facultative relatives (an indirect guide to larval timing).
33. [`s33_test_confinement.Rmd`](code/s33_test_confinement.Rmd) tests how robust the confinement of obligate genera is (definitions, completeness, grain, sampling, clades, sister contrasts).
34. [`s34_test_niche_availability.Rmd`](code/s34_test_niche_availability.Rmd) compares water availability used and accessible (independent buffers, sampling-adjusted background, five measures) in the mixed genera.
35. [`s35_prepare_dry_niche.Rmd`](code/s35_prepare_dry_niche.Rmd) prepares the dry-niche test: an all-butterfly GBIF background, accessible areas defined in advance, and water and temperature predictors.
36. [`s36_test_dry_niche.Rmd`](code/s36_test_dry_niche.Rmd) tests whether obligate mutualists repeatedly occupy drier environments than their facultative congeners after accounting for availability, recording effort and relatedness (one estimate per genus, pooled).
37. [`s37_test_dry_niche_v2.Rmd`](code/s37_test_dry_niche_v2.Rmd) is version 2 of that test, declared in advance in `writing/dry_niche_v2_plan.md`: supplemented occurrences, one contrast per origin of obligate mutualism and a joint model.
38. [`s38_diagnose_identifiability.Rmd`](code/s38_diagnose_identifiability.Rmd) checks whether drought can be told apart from warmth within each contrast.
39. [`s39_audit_occurrences_origins.Rmd`](code/s39_audit_occurrences_origins.Rmd) audits the GBIF supplementation and counts independent origins.
40. [`s40_simulate_power.Rmd`](code/s40_simulate_power.Rmd) simulates which data additions would resolve the dry-niche contrast.
41. [`s41_test_matched_case_case.Rmd`](code/s41_test_matched_case_case.Rmd) compares mutualists and facultative relatives at matched temperature (and biome).
42. [`s42_test_four_strategies.Rmd`](code/s42_test_four_strategies.Rmd) relates the four strategies to warmth, dry-season length and water stress.
43. [`s43_decompose_southern_faunas.Rmd`](code/s43_decompose_southern_faunas.Rmd) decomposes the obligate faunas and tests them against a lineage-conserving null.
44. [`s44_test_confinement_contrasts.Rmd`](code/s44_test_confinement_contrasts.Rmd) tests whether confinement replicates across independent origins.

The full record of the findings, with the ideas and projects the paper has no space for, is the working document [`writing/climate_manuscript.Rmd`](writing/climate_manuscript.Rmd), and the focused paper for Global Ecology and Biogeography, with its Supporting Information, is drafted in [`writing/paper_draft.Rmd`](writing/paper_draft.Rmd); both are rendered by `Rscript code/render_manuscript.R`.

Each notebook reads the raw data and the outputs of earlier notebooks and writes its outputs to its own folder in `data/intermediate`. The [code README](code/README.md) describes the notebooks and the shared functions, and the [data README](data/README.md) the raw and generated data.

## Reproducing the analysis

Use R 4.5.2. The packages are recorded with `renv` in a project library (`renv/library`, ignored by Git); in a fresh R session at the repository root, run

``` r
source("code/setup_environment.R")
restore_environment()
```

and restart R afterwards. The data are linked with `resrepo` as in `butterfly_ant_interactions`: `data/raw` and `data/intermediate` point to the versions `starting` and `initial` in the project OneDrive folder. Then run

``` bash
Rscript code/run_all.R
```

which knits the notebooks in order, each in a fresh R session (`Rscript code/run_all.R s02` resumes from `s02`). Rendered notebooks are saved in `results/<notebook>/`.

## Repository contents

-   `code/`: notebooks, the script that reruns them, the environment setup and shared R functions (`code/R/`)
-   `data/`: data README, data-source inventory, version metadata and links to raw and generated data
-   `results/`: rendered notebooks
-   `writing/`: study plan and literature review
