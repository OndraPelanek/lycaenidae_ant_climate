# Data

Data are managed with `resrepo`, as in `butterfly_ant_interactions`. Git records the selected version metadata; `data/raw` and `data/intermediate` are local links to the versions `starting` and `initial` in the project OneDrive folder (`lycaenidae_ant_climate/external_data/versions`). The [data-source inventory](metadata/data_source_list.csv) documents the sources of raw data and the notebooks that generate intermediate data.

## Raw data

Each folder of `data/raw` has a `README.md` that describes its files and the notebooks that read them.

- `butterfly_ant_interactions/`: frozen outputs of the parent study (species table, cleaned occurrence records, cell table, trees), with checksums
- `pastclim/`: palaeoclimate reconstructions of Krapp et al. (2021) and Beyer et al. (2020) in `pastclim` format, and the 5-Myr PALEO-PGEM series of annual temperature and precipitation (Barreto et al. 2023; `PALEO-PGEM-Series_bio1_mean.nc`, `PALEO-PGEM-Series_bio12_mean.nc`, downloaded manually from figshare), read by s08 at 10-kyr steps
- `worldclim_2.1/`: present climate of WorldClim 2.1 at 10 arc-minutes (bioclimatic variables, elevation and monthly temperatures and precipitation; the monthly layers are read by s19)
- `resolve_2017/`: RESOLVE Ecoregions 2017, for realms and biomes
- `soilgrids_2.0/`: SoilGrids 2.0 soil properties at 5 km (pH, cation exchange capacity, nitrogen, organic carbon)
- `soil_phosphorus_he2021_stp.0-10cm.tif`: soil total phosphorus at 0-10 cm and 0.5° (He et al. 2021; downloaded manually from figshare), read by s08
- `gfed5/`: GFED5 monthly burned area, 1997-2020
- `ants_kass2022/`: the main analysis data of Kass et al. (2022, Dryad), downloaded manually; s21 reads the estimated ant species and genus richness rasters and the filtered species- and genus-level GABI records directly from `main_analysis_data.zip`
- `ants_bellroberts2024/`: the supplementary tables of Bell-Roberts et al. (2024, Nature Ecology & Evolution), downloaded from the GitHub repository of the paper; colony size, queen number and worker castes of ant species (Supplementary Table 20) and supercolonial and parasitic species (Table 21)
- `butterflies_kawahara2023/`: two members of the Figshare archive of Kawahara et al. (2023): the treePL-dated trees (`Data.S22.treePL.zip`) and the tip-label table (`Data.S9.tips_fullname_mod_prob.csv`), extracted from the 1.4-GB `Data_S1-S28.zip` with HTTP range requests
- `landcover_earthenv2014/`: classes 1-7 of the global 1-km consensus land cover of Tuanmu & Jetz (2014, EarthEnv, reduced version), percentage cover of four tree classes, shrubs, herbaceous and cultivated vegetation; aggregated to 10 arc-minutes by s31
- `butterflies_gbif_density/`: records of all butterflies (Hesperiidae, Lycaenidae, Nymphalidae, Papilionidae, Pieridae, Riodinidae) per 10-arc-minute pixel of the Old World, counted from GBIF's public occurrence-density map tiles (zoom 4, EPSG:4326; georeferenced records without geospatial issues; the bases of record and years of the cleaned lycaenid records), and the records of each focal species of s36 within its extent; and of every facultative species and obligate mutualist of the subfamilies with obligate mutualists (`species_counts_10m.csv.gz`, s37); fetched on first run (`fetch_log.csv` gives the query and date)
- `etopo1/`: ETOPO1 global relief (NOAA National Geophysical Data Center 2009) subsampled to 10 arc-minutes from the NOAA ERDDAP server (`etopo180`), for the landmasses of the glacial shelf (s35)
- `natural_history/`: data-entry templates (empty) for the larval natural history of the dry-niche contrast species and the traits of their partner ants, written by s39, to be filled from the original literature with sources
- `literature/pdfs/`: open-access PDFs of the papers of the literature review (see `writing/literature_review.md`); for reading only

## Generated data

### Files of `s01_prepare_climate/`

| File | Contents | Read by |
|---|---|---|
| `climate_present_10m.tif` | WorldClim bio01, bio04, bio05, bio06, bio12, bio14, bio15, Hargreaves PET, aridity index and elevation at 10 arc-minutes | s01, s02 |
| `climate_past_10m.tif` | Present NPP, LGM anomalies of temperature and log precipitation, and log10 velocities since the LGM, at 10 arc-minutes | s01, s02 |
| `climate_variability_30m.tif` | Standard deviations of temperature and log precipitation over 800 and 21 kyr (pixels never under ice only) and the share of the 800 kyr under ice, at 0.5 degrees | s01, s02 |
| `realm_biome_10m.tif`, `realm_biome_codes.csv` | RESOLVE realm and biome of each 10-arc-minute pixel, and their codes | s01 |
| `cell_climate_250km.csv`, `cell_climate_500km.csv`, `cell_climate_1000km.csv` | One row per land cell: centre, land area, area-weighted climate means, median velocities, elevation SD, majority realm and biome | s02 |
| `plot_cell_climate_500km.png` | Maps of the cell climate (check) | none |

### Files of `s02_build_assemblages/`

| File | Contents | Read by |
|---|---|---|
| `species_records.rds` | Unique stringently cleaned coordinates of each unit | s02 |
| `presence_*km.csv` | Unit by cell presence | none yet |
| `cell_assemblages_*km.csv` | Per cell: recorded and classified units, counts of each interaction type and classification coverage | s02 |
| `species_climate.csv` | Per unit: taxonomy, interaction type and breadth, number of occupied 10-arc-minute pixels and the median climate of these pixels | s03 |
| `cell_data_*km.csv` | Cell assemblage counts joined to the cell climate | s03 |

### Files of `s03_explore_climate/`

Exploratory tables (`predictor_correlations_500km.csv`, `single_predictors_500km.csv`, `partition_500km.csv`, `realm_transfer_500km.csv`, `realm_transfer_checks_500km.csv`, `species_models.csv`) and their figures (`plot_*.png`).

### Files of `s04_fit_phylogenetic_models/`

| File | Contents | Read by |
|---|---|---|
| `grafted_trees.rds`, `tree_coverage.csv` | The Yumnam and Schär trees grafted for the classified species with a climate, and the species of each strategy on them | s04 |
| `predictor_correlations_species.csv` | Correlations among the six predictors over the species of the Yumnam tree | none |
| `phylo_coefficients.csv`, `phylo_metadata.csv` | Coefficients of the phylogenetic and ordinary logistic regressions, and samples, alpha and convergence | s04 |
| `partition_species.csv`, `lineage_cv_species.csv`, `lineage_cv_importance.csv` | Deviance explained by climate, lineage and both; the cross-validated deviance explained by climate for held-out genera and subfamilies; and the contribution of each predictor to the transfer to held-out subfamilies | s04, manuscript |
| `species_predictions.csv`, `cell_predictions_500km.csv`, `map_fit_500km.csv` | Predicted strategy probabilities of each species under the lineage, climate and combined models, their cell means, and the fit to the observed cell proportions | s04 |
| `plot_phylo_climate.png`, `plot_map_fit_500km.png`, `plot_climate_gain_map_500km.png` | Figures | none |

The GBIF records in `butterfly_ant_interactions/records_final.rds` are licensed CC BY-NC 4.0 and include recorder names; check this and the licences of the climate data before any public data release.

### Files of `s05_compare_regions/`

| File | Contents | Read by |
|---|---|---|
| `species_regions.csv` | Species climates (from s02) with the majority region of each species and its share of the species' pixels | s05 |
| `region_lineages.csv` | Species, genera and subfamilies of each strategy in each region | s05, manuscript |
| `region_slopes_species.csv`, `region_heterogeneity_species.csv` | Species-level slopes of the three contrasts within each region, and tests of whether the slopes differ between regions | s05, manuscript |
| `cell_data_hex6.csv`, `cell_data_hex5.csv`, `cell_data_hex4.csv`, `presence_hex*.csv`, `hex_polygons.rds` | Assemblages, climate and region of the ISEA hexagons (dggridR resolutions 6, 5, 4), species by hexagon, and hexagon polygons | s05 |
| `region_gradient_slopes_hex5.csv` | Slopes of the observed and lineage-expected strategy shares along each predictor within regions | manuscript |
| `region_slopes_cells.csv`, `region_slope_consistency.csv` | Within-region cell slopes for every grid, weighting and minimum species, and the consistency of their signs | manuscript |
| `plot_*.png` | Figures | manuscript |

### Files of `s06_test_stability/`

| File | Contents | Read by |
|---|---|---|
| `species_stability.csv` | Associated species with obligacy, region, hemisphere, signed latitude, the LGM anomaly of both reconstructions and standardised predictors | s06 |
| `stability_cv.csv` | Cross-validated deviance explained of the predictor sets for held-out subfamilies and genera | manuscript |
| `stability_effects.csv` | Effect of the LGM anomaly on obligacy given region and lineage, across subsets and checks | manuscript |
| `plot_stability_tests.png` | Figure | manuscript |

### Files of `s07_compare_mediterranean/`

| File | Contents | Read by |
|---|---|---|
| `mediterranean_10m.tif`, `mediterranean_pixels.csv` | Köppen–Geiger Cs pixels of the five regions, with their climate | s07 |
| `mediterranean_pool_species.csv`, `mediterranean_pools.csv` | Species recorded in each region's Cs pixels, and their strategies and genera | manuscript |
| `mediterranean_hexagons.csv`, `mediterranean_matches.csv` | Mediterranean hexagons (resolution 6) with their climate and strategies, and the climate-matched comparison | manuscript |
| `plot_mediterranean.png` | Figure | manuscript |

### Files of `s08_test_southern_drivers/`

| File | Contents | Read by |
|---|---|---|
| `drivers_10m.tif` | Soil (0-30 cm pH, cation exchange capacity, nitrogen, organic carbon) and fire (mean annual burned fraction) layers at 10 arc-minutes, with soil phosphorus and 5-Myr aridity when available | s08 |
| `species_drivers.csv` | The obligacy contrast species with the median drivers over their pixels | s08 |
| `drivers_cv.csv`, `drivers_effects.csv` | Cross-validated prediction of held-out lineages, and effects given lineage with and without region | manuscript |
| `plot_southern_drivers.png` | Figure | manuscript |

### Files of `s09_test_history/`

| File | Contents | Read by |
|---|---|---|
| `history_species.csv` | Classified species on the grafted trees with obligacy, hemisphere and region | s09 |
| `pagel_tests.csv`, `pagel_rates.csv` | Tests of correlated evolution of obligacy and hemisphere, and the rates of the dependent model, on both trees | manuscript |
| `origins_by_map.csv`, `origins_summary.csv` | Origins of obligacy in each stochastic map with their region and descendant obligate species, and their summary by region | manuscript |
| `plot_history_tree.png`, `plot_history_origins.png` | Figures | manuscript |

### Files of `s10_test_diversification/`

| File | Contents | Read by |
|---|---|---|
| `origins_resolutions.csv` | Origins of obligacy per region in stochastic maps over 20 random resolutions of the grafted polytomies | manuscript |
| `genus_table.csv`, `genus_tree.rds` | Genera with richness (species units), classified species, strategy, region, stem age on the Yumnam tree and net diversification rates; the tree of genera | s10, manuscript |
| `origins_genus_tree.csv` | Origins of obligacy per region on the tree of genera | manuscript |
| `diversification_summary.csv`, `diversification_models.csv` | Diversification rates by strategy and region, and phylogenetic and ordinary regressions | manuscript |
| `plot_diversification.png` | Figure | manuscript |

### Files of `s11_test_seasonality/`

| File | Contents | Read by |
|---|---|---|
| `seasonality_effects.csv` | Effect of precipitation seasonality on three contrasts given region and lineage, with added climate, species-specific evidence only, within genera, without large genera and within regions | manuscript |
| `seasonality_phylo.csv` | The same effects from phylogenetic logistic regression on both grafted trees | manuscript |
| `subfamily_transfer.csv` | Deviance explained and predicted obligate share in each held-out subfamily, for four predictor sets | manuscript |
| `mixed_genera.csv` | Genera with both obligate and facultative species: strategies, regions, evidence, tree coverage and the seasonality of each group | manuscript |
| `plot_seasonality.png` | Figure | manuscript |

### Files of `s12_audit_evidence/`

| File | Contents | Read by |
|---|---|---|
| `coverage_regions.csv`, `coverage_lineages.csv` | Recorded species of each region by strategy and evidence basis (and by subfamily), with the classified share | manuscript |
| `lineage_out_of_sample.csv` | Deviance explained by lineage, climate and both, in sample and for held-out species and held-out genera, with all species and species-specific evidence only | manuscript |
| `stability_evidence_cv.csv`, `stability_evidence_effects.csv` | The tests of s06 with both evidence sets | manuscript |
| `plot_evidence.png` | Figure | manuscript |

### Files of `s13_compare_matched_climates/`

| File | Contents | Read by |
|---|---|---|
| `pixel_strata.rds`, `record_pixels.rds`, `taxa.csv` | Land pixels with climate stratum (standard and coarse), region and Mediterranean region; the species recorded in each pixel; the species with strategy and taxonomy | s13 |
| `pair_comparisons.csv` | Obligate shares of pairs of Mediterranean-climate regions in their shared climate strata, with completeness bounds, imputation and genus-bootstrap intervals | manuscript |
| `beyond_mediterranean.csv` | The same for each biogeographic region in the climates of the Cape and southern Australia, and of the Mediterranean Basin, outside the five regions | manuscript |
| `species_region_effects.csv`, `shared_genera.csv` | Region effects among the species of the Cs pools with and without species climate; the genera shared by pairs of pools and their obligate species | manuscript |
| `plot_matched_climates.png` | Figure | manuscript |

### Files of `s14_test_null_models/`

| File | Contents | Read by |
|---|---|---|
| `seasonality_null.csv` | Within-genus effect of seasonality on obligacy in the data and in permutations within genera | manuscript |
| `gradient_null.csv`, `gradient_null_summary.csv`, `gradient_null_total.csv` | Observed and lineage-expected slopes of s05 in the data and in permutations of strategies within genera; per-slope and overall summaries (z-scores) | manuscript |
| `origins_matched.csv` | Origins of obligacy per region on the matched-only Yumnam and Schär trees | manuscript |
| `plot_null_models.png` | Figure | manuscript |

### Files of `s15_test_association/`

| File | Contents | Read by |
|---|---|---|
| `holarctic_presence_hex7.csv`, `holarctic_cells_hex7.csv`, `holarctic_hex7.rds` | Species by hexagon (resolution 7, about 23,000 km²) in Europe, the eastern Palaearctic and the Nearctic; hexagon counts, lineage expectation and climate; polygons | s15 |
| `latitude_profiles.csv`, `richness_slopes.csv` | Richness and share of each strategy in latitude bands; change in richness with latitude by strategy | manuscript |
| `share_models.csv`, `share_null.csv` | Deviance in the non-associated share explained by latitude and temperature; observed and expected slopes with the within-genus null | manuscript |
| `europe_genera.csv` | Species per hexagon of each genus in southern and northern Europe | manuscript |
| `association_effects.csv` | Effect of temperature on ant association given lineage and within genera, by region | manuscript |
| `plot_europe_association.png`, `plot_association_regions.png` | Figures | manuscript |

### Files of `s16_make_maps/`

| File | Contents | Read by |
|---|---|---|
| `plot_world_strategies.png`, `plot_obligate_genera.png` | World maps of the share of each strategy, classified species and classification completeness (comparable to Fig. 1 of the parent study); obligate species of each region by genus | manuscript |
| `shared_climate_pools.csv`, `plot_shared_climates.png`, `plot_shared_climates_panel.png` | Obligate share of each region's species in the climates of the Mediterranean-climate Cape and southern Australia, and their map (the panel version is Fig. 2a of the paper) | manuscript, s22 |

### Files of `s17_make_figures/`

| File | Contents | Read by |
|---|---|---|
| `figure_lineages.png`, `figure_shared_climates.png`, `figure_obligacy_predictors.png`, `figure_history.png` | Main figures of the working manuscript, combining the outputs of s05–s14 | manuscript |

### Files of `s18_audit_shared_climates/`

| File | Contents | Read by |
|---|---|---|
| `standardised_contrasts.csv`, `standardised_shares.csv` | Obligate share and the share of each strategy of the regions of each pair within their shared climate strata, standardised over common stratum weights (area or equal), with each species in all its strata or only its main one; genus-bootstrap intervals | paper, s22 |
| `balance.csv`, `balance_pixels.csv`, `retained.csv` | Standardised mean differences of the climate variables before and after matching; the pixels behind them; share of each region's Cs pixels and classified species in the shared strata | paper |
| `sensitivity.csv` | The standardised obligate contrast for stratum widths of 0.5–2 times the main strata and minimum occupancies of 1, 5 and 10 pixels | paper, s22 |
| `genus_weighted.csv`, `decomposition.csv` | Species- and genus-weighted composition of the Mediterranean-climate pools and biogeographic regions; decomposition of regional contrasts into genus share and richness term | paper |
| `plot_shared_climate_audit.png` | Figure | paper |

### Files of `s19_test_mixed_genera/`

| File | Contents | Read by |
|---|---|---|
| `drought_10m.tif`, `species_drought.csv` | Dry months, longest run of dry months and driest-month precipitation at 10 arc-minutes; the median of each species, with its evidence basis and larval carnivory | s19 |
| `drought_effects.csv`, `holm_obligacy.csv` | Effects of seasonality and drought on three contrasts given region and lineage; all properties tested for obligacy with Holm-adjusted p-values | paper, s22 |
| `within_genus_tests.csv` | Within-genus slopes (genus fixed effects) against 9,999 permutations within genera | paper |
| `mixed_genera_full.csv`, `mixed_genera_species.csv` | Every genus with obligate and facultative species, with the seasonality and dry-month differences and their intervals; their species | paper, s22 |
| `carnivory.csv`, `plot_mixed_genera.png` | Recorded larval carnivory by strategy; figure | paper |

### Files of `s20_predict_held_out/`

| File | Contents | Read by |
|---|---|---|
| `held_out_predictions.csv` | Prediction of every classified species by five models when its realm or its subfamily is held out, with its climatic novelty | s20 |
| `held_out_metrics.csv`, `held_out_pooled.csv`, `calibration_bins.csv` | Predicted and observed share, AUC, deviance explained and calibration slope per held-out unit and pooled, with genus-bootstrap intervals; calibration bins | paper, s22 |
| `plot_held_out.png` | Figure | paper |

### Files of `s21_test_ant_partners/`

| File | Contents | Read by |
|---|---|---|
| `species_ants.csv`, `ant_richness_effects.csv` | Estimated ant species and genus richness of each species' records; their effects on three contrasts given lineage and given region and lineage | paper |
| `partner_records.csv`, `partner_genera.csv` | Recorded ant partners of each species unit; lycaenid species per ant genus, strategy and region | paper |
| `ant_genus_regions.csv`, `partner_availability.csv` | Ant species and records of each genus per region in the GABI data; availability and use of the partner genera of obligate species | paper, s22 |
| `plot_ants.png` | Figure | paper |

### Files of `s22_make_paper_figures/`

| File | Contents | Read by |
|---|---|---|
| `figure_2_shared_climates.png`, `figure_3_lineage_climate.png`, `figure_4_remaining_signal.png` | Main figures 2–4 of the paper (Fig. 1 is `s16/plot_world_strategies.png`) | paper |

### Files of `s23_test_dispersal/`

| File | Contents | Read by |
|---|---|---|
| `genus_spread.csv`, `spread_models.csv` | Regions and hexagons occupied by every genus, with strategy, stem age and species; effects of obligacy on spread across models | big-picture plan |
| `range_models.csv`, `range_mixed_genera.csv` | Effect of obligacy on species range area given region and lineage, and within mixed genera; median ranges of obligate and facultative congeners | big-picture plan |
| `obligate_genera_regions.csv`, `plot_dispersal.png` | Obligate genera found in more than one region, with their species per region; figure | big-picture plan |

### Files of `s24_compare_all_climates/`

| File | Contents | Read by |
|---|---|---|
| `all_pairs.csv`, `all_pairs_shares.csv` | Standardised obligate share and its difference for every pair of regions within their shared climate strata, with genus-bootstrap intervals and the area and species retained; the share of each strategy | big-picture plan |
| `all_pairs_summary.csv`, `plot_all_climates.png` | Summary by group of pairs; figure | big-picture plan |

### Files of `s25_test_convergence/`

| File | Contents | Read by |
|---|---|---|
| `convergence_trees.rds` | Tree of genera and matched-only Yumnam tree with obligacy and region group of each tip | s25 |
| `gain_rates.csv`, `rate_summary.csv`, `ratio_null.csv` | Origins of obligacy, non-obligate lineage time and rates per region group and pair of maps; summaries with the southern rate ratio and its permutation null | paper |
| `gain_ages.csv`, `plot_convergence.png` | Age of every origin by region group; figure | paper |

### Files of `s26_test_knowledge/`

| File | Contents | Read by |
|---|---|---|
| `knowledge_regions.csv`, `sampling_effects.csv`, `plot_knowledge.png` | Obligate share of each region under four knowledge filters with completeness and upper bound; GBIF records of obligate against facultative species; figure | paper |

### Files of `s27_test_ant_communities/`

| File | Contents | Read by |
|---|---|---|
| `glad_localities.csv` | Every GLAD locality with at least three species: partner-genus species and abundance shares, dominance, region and hexagon | s27 |
| `region_communities.csv`, `hex_communities.csv`, `hex_models.csv`, `plot_ant_communities.png` | Medians by region and Mediterranean-climate region; hexagon table and models against the obligate share of lycaenids; figure | paper |

### Files of `s28_test_robustness/`

| File | Contents | Read by |
|---|---|---|
| `flexible_climate.csv` | Held-out deviance explained and AUC of linear and flexible climate models and lineage, for held-out realms and subfamilies, with all and species-specific evidence | paper, s22 |
| `shared_climates_specific.csv` | Standardised obligate contrasts within shared climates with all and species-specific evidence | paper |
| `species_drought_balance.csv`, `drought_robustness.csv`, `drought_logo.csv`, `drought_genera.csv`, `drought_genus_balanced.csv` | Water-deficit months of each species; effects of dry and water-deficit months given region and lineage and in phylogenetic regressions; leave-one-genus-out estimates; genus-balanced differences | paper, s22 |
| `plot_robustness.png` | Figure | paper |

### Files of `s35_prepare_dry_niche/`

| File | Contents | Read by |
|---|---|---|
| `focal_species.csv` | Facultative species and obligate mutualists of the genera with both, with evidence basis and the extent of their records | s35, s36 |
| `accessible_areas.csv` | Accessible area of every land pixel of the eight regions: realms on glacial-shelf landmasses (primary), on present-day landmasses, and the study's regions | s35 |
| `dry_niche_pixels.rds` | Every land pixel of the eight regions: accessible areas, dry months, climatic water deficit, water-deficit months, months below 50 mm, seasonality, driest-month precipitation, temperature, pixel area and butterfly records | s36 |
| `coverage.csv`, `plot_coverage.png` | Share of land pixels with butterfly records by accessible area and dry months; figure | s36, manuscript |

### Files of `s36_test_dry_niche/`

| File | Contents | Read by |
|---|---|---|
| `eligibility.csv`, `eligible_units.csv` | Every species of the mixed genera with its occupied pixels per accessible area and eligibility at 10, 20 and 30 pixels; the eligible species-area units under each area definition | s36, paper |
| `pilot_estimates.csv` | Pilot fits for *Arhopala*, *Hypochrysops* and *Ogyris* with a raw check | s36 |
| `species_estimates.csv` | Presence-background (point-process) coefficients of every unit, model, background, area definition and resolution, signed so that positive means drier | s36, paper |
| `response_curves.csv` | Penalised response shapes along dry months (primary settings) | s36 |
| `comparison_summary.csv`, `comparison_genera.csv`, `comparison_units.csv` | Mutualists minus facultative congeners: pooled over genera, per genus and per genus-area unit, for every setting (measures, backgrounds, thresholds, areas, resolution, evidence, overlap, leave one genus out); hierarchical and phylogenetic meta-analyses | paper, s22 |
| `direct_comparison.csv`, `direct_units.csv` | Comparison without a background: which strategy an occupied pixel belongs to | paper |
| `blocked_cv.csv` | Spatially blocked cross-validation: AUC with temperature alone and with dry months | paper |
| `outcome.csv` | Outcome under the pre-specified rules | paper |
| `plot_dry_niche_genera.png`, `plot_dry_niche_robustness.png`, `plot_dry_niche_species.png` | Figures | paper, s22 |

### Files of `s37_test_dry_niche_v2/`

| File | Contents | Read by |
|---|---|---|
| `candidate_species.csv` | Facultative species and obligate mutualists of the subfamilies with obligate mutualists, with the extent of their records | s37 |
| `presences.csv` | Occupied pixels of every candidate species: cleaned records and GBIF records within 100 km of them in the same accessible area | s37 |
| `contrasts.csv` | Species-area units of every contrast, with cleaned or supplemented occurrences, within genera or one per origin | s37, paper |
| `species_estimates.csv`, `two_stage_summary.csv`, `two_stage_origins.csv` | Point-process coefficients of every unit; two-stage comparison pooled over origins and per origin, for each step, background and model | paper, s22 |
| `joint_estimates.csv`, `joint_leave_one_out.csv`, `bootstrap.csv`, `joint_data_primary.rds` | Joint-model estimates of the mutualist-minus-facultative difference for each step, background and model; leaving out each origin; cluster bootstrap over origins; the data of the primary model | paper |
| `outcome.csv` | Outcome under the rules declared before analysis | paper |
| `plot_dry_niche_origins.png`, `plot_dry_niche_steps.png` | Figures | paper, s22 |

### Files of `s38_diagnose_identifiability/`

| File | Contents | Read by |
|---|---|---|
| `mechanism_pixels.rds` | Land pixels with temperature, the longest run of months below 50 mm, the climatic water deficit, dry months and months below 50 mm | s39, s41, s42, s44 |
| `contrast_pixels.rds`, `identifiability.csv` | Occupied pixels of every contrast; identifiability diagnostics per contrast and variable | s41, paper |
| `plot_environment_space_run.png`, `plot_environment_space_cwd.png` | Figures | paper |

### Files of `s39_audit_occurrences_origins/`

| File | Contents | Read by |
|---|---|---|
| `supplement_pixels.csv`, `supplement_species.csv` | Every GBIF pixel added in s37 with what the parent cleaning did there; per species summaries | s41, paper |
| `supplement_decomposition.csv`, `supplement_influence.csv` | Pooled estimate with cleaned records, re-estimated species and newly eligible species; influence of each unit | paper |
| `gbif_added_facets.csv`, `provenance_summary.csv` | GBIF providers, bases of record, years and issues of the added records of the most influential species (cached) | s39 |
| `origins.csv` | Balance and separate mutualist clades of every contrast | paper |
| `plot_supplement_audit.png` | Figure | paper |

### Files of `s40_simulate_power/`

| File | Contents | Read by |
|---|---|---|
| `power_parameters.csv`, `power_species.rds`, `power.csv`, `plot_power.png` | Estimated variance structure; power and interval width per scenario; figure | paper |

### Files of `s41_test_matched_case_case/`

| File | Contents | Read by |
|---|---|---|
| `case_pixels.rds`, `variable_sds.rds` | Occupied pixels of every setting with climate and biome | s41 |
| `species_scores.csv`, `case_summary.csv`, `case_origins.csv` | Species scores; pooled and per-origin differences for every setting and hypothesis | paper, s22 |
| `plot_case_origins.png`, `plot_case_sensitivity.png` | Figures | paper |

### Files of `s42_test_four_strategies/`

| File | Contents | Read by |
|---|---|---|
| `species_mechanisms.csv`, `strategy_effects.csv`, `plot_four_strategies.png` | Species medians of the three variables; effects on the four nested contrasts; figure | paper |

### Files of `s43_decompose_southern_faunas/`

| File | Contents | Read by |
|---|---|---|
| `species_sets.csv`, `decomposition.csv`, `null_shares.csv`, `plot_southern_decomposition.png` | Species sets; decomposition of every fauna; lineage-conserving null; figure | paper |

### Files of `s44_test_confinement_contrasts/`

| File | Contents | Read by |
|---|---|---|
| `genus_responses.csv`, `sister_clades.csv`, `contrast_values.csv`, `contrast_tests.csv`, `plot_confinement_contrasts.png` | Responses per genus; sister clades on both trees; contrasts and tests; figure | paper |
