# Study plan: climate, history and the global geography of butterfly–ant interactions

Status, 28 October 2026: data assembled; first exploration (`s01`–`s03`), species-level phylogenetic models (`s04`) and regional analyses (`s05`) done; an external review (ChatGPT) of the first run considered. The current findings are shown, with figures, in the working manuscript `climate_manuscript.Rmd`. Nothing here is a confirmatory result.

## Question and framing

Why do different forms of butterfly–ant interaction dominate different parts of the world? Specifically, how much of the geographic variation in the four larval strategies of lycaenids (non-associated, facultative, obligate mutualist, obligate parasite) is associated with present climate and with Late Quaternary climatic history, and how much reflects the evolutionary geography of lineages? The hypotheses, their predictions and their sources are in [`literature_review.md`](literature_review.md).

The explanations operate at three timescales and should be kept apart:
1. **Contemporary environmental filtering:** present climate, together with vegetation, soils and ants.
2. **Late Quaternary climatic legacies:** the anomaly and velocity of change since the Last Glacial Maximum, and glaciation.
3. **Deeper evolutionary and biogeographic contingency:** which lineages evolved which strategies, and where they could spread.

Climate and history are not opposites: historical climate is part of climate, and lineages carry the imprint of past environments. The framing is therefore *environmental filtering and evolutionary contingency*, with climatic history tested explicitly. Neutral working title: *Climate, history and the global geography of butterfly–ant interactions*.

## Is this a good study?

Yes. The first results make it more interesting, not less.

**Why it is worth doing.**
- To our knowledge, no study has related the global frequencies of a set of interaction strategies in an animal clade to present and past climate while accounting for lineages.
- The closest precedents concern plants: three ant–plant mutualism types (Luo et al. 2023, *Ecography*), mycorrhizal types (Steidinger et al. 2019) and cooperative breeding in birds (Jetz & Rubenstein 2011).
- The four-way classification separates dependence (facultative against obligate) from exploitation (mutualist against parasite). A binary "myrmecophilous or not" trait would hide this.

**What the data can and cannot distinguish so far.**
- **Lineage composition dominates the maps.** The strategies of lineages describe most of the mapped variation.
- **Climate has a signal that transfers to new lineages, for obligacy only.** A climate-only model predicts whether a species is obligate or facultative even for whole subfamilies it was not fitted to. It does not do so for ant association as such, or for parasitism against mutualism.
- **The Americas are the main anomaly.** They have climates in which obligate associates are predicted, but none are recorded.

These are three distinct, testable findings rather than a single "climate explains X%".

**Main risks.**
1. Obligate strategies are concentrated in a few radiations. Only 14 genera contain both obligate and facultative species, and 7 contain both parasites and mutualists.
2. Classification coverage is uneven.
3. Present and past climate are collinear, and with the available reconstructions several "stability" measures are the same quantity (see below).
4. Soils, fire and ants are not climate and need their own layers.

## Data assembled

- **Assemblages.** The 500-km cells were rebuilt from the stringently cleaned records of `butterfly_ant_interactions` and match its Fig. 1 table exactly: 768 cells, 492 with at least ten classified species. Grids of 250 and 1,000 km were built for scale checks.
- **Species.** 1,159 classified species have complete climate values: 267 n, 582 f, 159 m and 151 p, in 261 genera. On the trees after grafting there are 951 (Yumnam) and 990 (Schär).
- **Present climate.** WorldClim 2.1 at 10′: temperature (mean, extremes, seasonality), precipitation (annual, driest month, seasonality), a Hargreaves aridity index, and elevation and its variation.
- **Past climate.** From Krapp et al. (2021) via `pastclim`:
  - LGM anomalies of temperature and log precipitation, from the same reconstruction at both times;
  - velocity since the LGM, as Sandel et al. (2011): anomaly divided by the present WorldClim gradient, gradient floored, log10;
  - NPP;
  - standard deviations over 800 and 22 millennial slices;
  - the share of the 800 kyr under ice.

### Audit of the past-climate layers (after the external review)

- **The standard deviations were biased by ice.** `pastclim` leaves ice-covered times empty. In 24% of present land pixels some slices are missing (as many as 796 of 800), so the standard deviations described only ice-free times. They are now computed only for complete series, and the share of time under ice is a separate variable.
- **Glaciated cells were missing from every past-climate analysis (fixed).** The reconstruction has no climate under the LGM ice sheets; the netCDF files themselves are empty there. 39 of the 492 analysed cells, in Canada, Scandinavia and Scotland, therefore had no LGM anomaly or velocity and were dropped from the first cell-level models as incomplete cases. These are the regions of largest change, central to H6, and their absence biased the first past-climate results. The fix:
  - the anomaly under the ice is filled from the nearest ice-free pixels, a lower bound;
  - velocity there is the distance to the nearest ice-free LGM land divided by 21,000 years, the slowest possible recolonisation rate;
  - the LGM ice share of each cell and species is a new variable, so results can be checked without the filled values.

  A further bug dropped glaciated pixels from the variability summaries; it is also fixed.
- **"Stability" measures from this reconstruction are one quantity.** Each pixel's 800-kyr series correlates with the global mean series (median r = 0.93), because the reconstruction is a statistical emulation driven by a few global modes. Consequently, the LGM temperature anomaly correlates with the 800-kyr standard deviation at 0.99 and with the standard deviation since the LGM at 0.996 among pixels.
- **Which history measures are distinct.** Temporal variability, maximum change between slices and the LGM anomaly are not independent measures with Krapp2021 or Beyer2020; both are HadCM3 emulations from the same group. The distinct measures are:
  - velocity, which depends on the spatial gradient;
  - glacial ice cover;
  - persistence of biomes or climatic analogues (Beyer2020 includes biomes);
  - an independent reconstruction (CHELSA-TraCE21k, CCSM3) for the anomaly itself.
- **Velocity checks.** It is highest in flat lowlands, as its definition implies; only 0.5% of pixels reached the gradient floor. Sensitivity to the floor, to the resolution and to an analogue-based velocity is still to be tested.

## Results so far

### Cell level (s03; descriptive)

Binomial GAMs of each strategy in the 500-km cells (climate, space, realm). Cell-level deviance explained is inflated by species shared among cells and by spatial autocorrelation, and a flexible spatial smooth absorbs any broad-scale climate pattern (spatial confounding; Hodges & Reich 2010). The small "climate unique of space" fractions therefore do **not** show that climate is unimportant. Likewise, "realm" is a proxy for climate, history and data coverage together, not for history alone.

After the ice correction (all 492 cells now included), the obligate share of associated species has these deviance-explained values:

| Model | Deviance explained |
|---|---|
| Climate | 48% |
| Space alone | 88% |
| Realm | 59% |
| Climate beyond space | 0.2% |

The current numbers for every response are in `s03/partition_500km.csv` and in the working manuscript.

### Within regions (s05)

- **Ant association.** Species-level relationships of ant association with temperature, aridity, LGM anomaly and latitude differ between regions (p < 0.001 to 0.03). For obligacy, regional slopes are too imprecise to differ.
- **Cell composition within regions** shows clear gradients that match the owner's expectations:
  - **Palaearctic and Nearctic:** more non-associated species in cold and wet climates.
  - **Australia:** more facultative and fewer obligate mutualists in warm climates.
  - **Southern Africa:** more obligate mutualists in dry climates.
- **These gradients are mostly lineage turnover.** The composition expected from the lineages present (each species given its congeners' strategies) reproduces a median of about 60% of each observed slope, with the same sign in about 90%.
- **Robustness.** About 70% of the regional relationships keep their sign in at least 90% of the alternative grids (squares and ISEA hexagons), grains, weightings and minimum numbers of species.

### Species level (s04)

**Partition** (deviance explained, taxonomic binomial models; in-sample):

| Contrast | Species | Genera with both outcomes | Lineage | Climate | Climate alone | Climate on held-out genera | Climate on held-out subfamilies |
|---|---|---|---|---|---|---|---|
| Associated vs non-associated | 1,159 | 40 | 67% | 7% | ≈0 | 3% (2–4%) | −6% |
| Obligate vs facultative | 892 | 14 | 86% | 19% | 2% | **12% (9–15%)** | **18%** |
| Parasite vs mutualist | 310 | 7 | 85% | 4% | 2% | −27% | −50% |

- Lineage (subfamily and genus) describes most of the variation in every contrast.
- Most of the climate signal is shared with lineage.
- Only for obligacy does a climate-only model predict species of genera, and of whole subfamilies, that it was not fitted to.
- An exploratory drop-one check shows that this transferable signal comes mainly from the **LGM temperature anomaly**: alone it gives a held-out-subfamily D² of 0.11, and dropping it loses 0.12. **Aridity** adds a further 0.06. Obligate associates are concentrated, across subfamilies, where glacial cooling was small and the climate is drier (H6 and H2). Mean temperature alone does not transfer.
- **Caveat:** low LGM anomaly also marks the southern continents. The signal could reflect a southern history shared by several lineages rather than stability itself. Within-realm tests are the next step.

**Phylogenetic logistic regression** (`phyloglm`, both trees):
- The coefficients depend on the tree.
  - **Schär tree** (Grafen branch lengths): obligacy was associated with lower aridity index (drier), more seasonal precipitation, smaller LGM temperature anomaly, lower mean temperature and higher velocity. The parasite–mutualist contrast was associated with less seasonal precipitation and larger LGM anomaly.
  - **Yumnam tree** (dated, very strong phylogenetic signal): most coefficients shrank to near zero with narrow intervals. This is more plausibly shrinkage under near-complete phylogenetic determination than evidence of no association.
- Climate inference that controls for phylogeny is therefore fragile. It should rest on transfer between lineages and on within-clade contrasts rather than on single phylogenetic coefficients.
- Likelihood-based R² (Ives 2019, `rr2`) were tried with `phyloglm` and `phyr::pglmm_compare`. The likelihoods behaved inconsistently for nested models (reduced models sometimes fitted better), so they were not used for partitioning.

**From species to maps** (Jetz & Rubenstein 2011):
- Averaging species-level predictions over each cell's species, the lineage-only model reproduces the cell proportions with D² = 0.84 (all strategies together), and lineage plus climate with 0.85.
- Climate alone gives −0.04 overall: 0.24 for non-associated, 0.35 for mutualists, and negative for facultative and parasites.
- All three are in-sample, so the lineage model is optimistic.
- The map of the gain from adding climate to lineage shows improvement in Australia and Namibia and loss in the northern Palaearctic.

### Figures drafted

- `s04/plot_phylo_climate.png`: three panels with separate axes.
  - A: the parts of deviance explained (climate alone, shared, lineage alone).
  - B: transfer of climate-only models to held-out genera and subfamilies.
  - C: climate coefficients on both trees and without phylogeny (filled where p < 0.05).
- `s04/plot_map_fit_500km.png`: observed against predicted cell proportions. Rows are the four strategies and columns are lineage, climate and both, with equal axes per strategy and American cells emphasised. The climate column shows the Americas predicted to hold obligate associates they do not have.
- `s04/plot_climate_gain_map_500km.png`: where adding climate to lineage improves (blue) or worsens (red) the cell predictions.
- `s01/plot_cell_climate_500km.png` and the s03 figures are working maps and diagnostics.

## Response to the external review

| Point | Assessment | Action |
|---|---|---|
| A small climate fraction unique of space does not mean climate is unimportant (spatial confounding) | Agree | Wording changed; the cell-level partition is descriptive only; inference moved to the species level and to transfer tests |
| Realm explaining 57% is not "history explains 57%" | Agree | Wording changed |
| "History dominates" is not yet shown | Agree; the s04 transfer test now shows a climate signal for obligacy that generalises across subfamilies | Framing changed to environmental filtering and evolutionary contingency |
| American prediction: check coverage, extrapolation and uncertainty | Agree | Coverage and training-range checks added to s03 (realm_transfer_checks) |
| Riodinidae carry much Neotropical myrmecophily | Agree | Decided (owner, 28 October 2026): Riodinidae are excluded from this study; their Neotropical myrmecophily is discussed as context only |
| Mediterranean regions: matched comparisons, not five replicates | Agree | Planned as climate-matched cell comparisons within and beyond the five regions |
| Audit the 0.97 correlation | Done: real but a property of the emulated reconstruction; ice masking was a genuine bias | Fixed in s01; SDs dropped from s03 in favour of ice share |
| Use Beyer2020 rather than Krapp2021 | Partly: the same model family. It matters little for the anomaly, but Beyer's biomes allow a persistence measure | Beyer2020 is in raw data; biome persistence planned; CHELSA-TraCE21k (independent GCM) planned for the anomaly |
| Six history metrics (SD, maximum change, analogue and biome persistence, ...) | Only some are identifiable with these data (see audit) | Use anomaly, velocity, ice share and biome or analogue persistence; drop the SD metrics |
| Joint compositional model | Agree for the cell level | Multinomial (or Dirichlet-multinomial) cell model planned; nested contrasts kept for the species level, which handles unequal strategy sizes |
| Species occur in many cells (pseudo-replication) | Agree | Species-level inference plus nulls that keep ranges and lineage structure |
| Nulls must keep lineage structure | Agree | Within-genus or within-tribe label shuffles, plus spatially constrained climate shuffles |
| Repeat without *Lepidochrysops* and *Thestor*, and within southern Africa | Agree | Planned |
| 250-km grain as primary | Open: 1,117 cells with ≥ 10 classified species at 250 km | Compare after the coverage diagnostics |
| Daru (2025) modelled ranges for assemblages | Caution: these ranges are modelled partly from climate and would inflate climate associations | Use only as a sensitivity check, and say so |
| renv.lock not updated | Agree | The owner should run `renv::snapshot()` in RStudio; it hangs when run by Claude |
| PDF licences | The PDFs are in `data/raw` (not in Git) and marked as not for redistribution | No change |
| References cited in the review | Verified: Luo et al. 2023; Pellissier et al. 2012 (*J. Evol. Biol.*); Gross et al. 2025; Ghasemi et al. 2026. Not found: "ant bioregions 2024" and the *Plebejus argyrognomon* rainfall study | Verified ones added to the bibliography and the review |

### Mediterranean regions (s07) and southern drivers (s08)

- **Mediterranean-climate regions** (Köppen Cs). Obligate associates make up:

  | Region | Obligate share | Classified species |
  |---|---|---|
  | Cape | 69% | 98 |
  | Southern Australia | 45% | 33 |
  | Mediterranean Basin | 6% | 142 |
  | California | 0% | 68 |
  | Central Chile | 0% | 5 |

  Climate-matched hexagons keep the contrast. Cape and Australian cells hold 12–68% obligate species, while their closest climatic matches hold 0–6% in the Mediterranean Basin and none in California. This is an illustration with five regions, not a test.
- **Soils (SoilGrids), fire (GFED5) and present aridity.** None improves the prediction of obligacy in held-out subfamilies or genera beyond latitude and hemisphere (largest gain about 1 percentage point). Given lineage, obligate species live:
  - in more seasonal rainfall (+0.59, p = 0.003);
  - on soils with less organic carbon (−0.43, p = 0.046) and nitrogen (−0.48, p = 0.06);
  - where fire is more frequent (+0.41, p = 0.07).

  Given region too, only precipitation seasonality remains clear (+0.48, p = 0.025).
- **Not yet tested.** The figshare downloads were blocked (bot check), so soil total phosphorus (He et al. 2021; figshare 10.6084/m9.figshare.14583375) and the 5-Myr PALEO-PGEM aridity (Barreto et al. 2023) are missing. `s08` uses them automatically once the files are placed in `data/raw/soil_phosphorus_he2021/stp.0-10cm.tif` and `data/raw/pastclim/PALEO-PGEM-Series_bio1_mean.nc` and `_bio12_mean.nc`.

### History of obligacy (s09)

- **Correlated evolution.** Obligacy evolves dependently on hemisphere on the Schär tree (p < 10⁻⁸): southern lineages gain it about 3 times faster and lose it about 57 times more slowly. It does not on the dated Yumnam tree (p = 0.54). This is tree-dependent, like the phylogenetic coefficients of s04.
- **Origins by region.** Stochastic character maps on the Yumnam tree give about 30 origins of obligacy:

  | Region | Origins | Obligate species |
  |---|---|---|
  | Southern Africa | 3 | 173 |
  | Australia | 10 | 56 |
  | Indomalayan | 13 | 20 |
  | Palaearctic | 2 | 13 |

  The Indomalayan count is likely inflated by random resolution of grafted polytomies in mixed genera.
- **Reading (superseded by s10).** The two obligate-rich southern faunas arose differently: southern Africa by a few origins with large radiations, Australia by repeated origins.

### Robustness of origins and diversification (s10)

- **Origins.** The species-tree counts are stable over 20 random resolutions of the grafted polytomies. On a tree of genera built from matched species only, the deep origins are few everywhere: southern Africa 3 (11 obligate genera), Australia 4 (8), Indomalayan 3. The higher species-tree counts for Australia and the Indomalayan region are shallow origins within facultative genera.
- **Diversification.** Obligate genera do not have higher net diversification rates (Magallón & Sanderson stem-age estimator; phylogenetic regression on the genus tree). Southern African and Australian genera have lower rates whatever their strategy.
- **Reading (withdrawn after the third review).** Persistence and accumulation of old obligate lineages, not frequent origins or fast radiation. State-dependent diversification models (BiSSE and relatives) are not used: the grafted, incomplete sampling makes them unreliable. Diversification rates from extant genera are not interpreted (Rabosky & Benson 2021).

### Precipitation seasonality under strong controls (s11)

Asked by the second external review (28 October 2026) as its first priority.

- **Robust given region and lineage.** Obligate vs facultative: +0.48 log odds per SD (p = 0.025). Also with temperature and aridity (+0.45), with species-specific evidence only (655 of 901 species; +0.52, p = 0.017), without *Lepidochrysops*, *Thestor* and *Chrysoritis* (+0.47), within genera (+0.58, p = 0.012), and in phyloglm with region (Schär p = 0.024; Yumnam p = 0.06).
- **Dependence, not exploitation.** Obligate mutualist vs facultative +0.51 (p = 0.021); parasite vs mutualist −0.43 (p = 0.31; −0.25, p = 0.55, with directly recorded subtypes only).
- **Not consistent across regions.** Within regions: Australia +1.71 (p = 0.06), Indomalayan +0.35 (p = 0.20), Palaearctic ≈ 0, southern Africa −0.33 and tropical Africa −1.16 (both n.s.).
- **Mixed genera** (14 with obligate and facultative species): in 6 of the 7 with several obligate species, the obligate species live in more seasonal climates (*Cigaritis*, *Hypochrysops*, *Arhopala*, *Ogyris*, *Anthene*, *Hypolycaena*); in 6 of the 7 with one obligate species, the reverse. Overall 7 of 14. Post hoc split; descriptive only.
- **No transfer.** Seasonality adds at most 4 percentage points to latitude × hemisphere for held-out subfamilies, and alone predicts nothing.
- **Reading.** Seasonal rainfall goes with obligate mutualism where obligacy arose recently within facultative genera (Australia, Indomalaya), not with the old obligate fauna of southern Africa, and not with parasitism. The deep and the shallow origins may have different correlates.

### Strategies in shared climates (s13)

- **Shared climate strata** (2 °C mean temperature, 3 °C minimum temperature, 0.15 log10 aridity, 15% seasonality; at least 5 pixels per region): Cape 67% obligate (84 classified, 26 genera) vs Mediterranean Basin 6% in 6 shared strata (difference 61 points, genus-bootstrap 95% interval 24–80); southern Australia 42% vs Basin 4% in 26 strata (10–64). Same with strata twice as wide.
- **California shares no stratum with the Cape or southern Australia** (5 coarse strata with southern Australia). The nearest-neighbour matches of s07 paired distinct climates; California is not a climatic replicate. Basin vs California: 5% vs 0%.
- **Completeness:** Basin upper bound (all unclassified obligate) 6% vs Cape lower bound 61%.
- **The same climates outside the five regions:** in Cape/S Australia climates, southern Africa 43%, Australia 46%, tropical Africa 7%, Palaearctic 5%, Nearctic and Neotropic 0%; in Basin climates, southern Africa 48%, Australia 35%, tropical Africa 19%, Palaearctic 6%, Americas 0%.
- **Lineages:** none of the obligate species of the Cape or southern Australian pools belongs to a genus shared with the Basin or California pools; shared genera (*Leptotes*, *Lampides*, *Zizeeria*, *Lycaena*, ...) are non-obligate in all pools. Given species' own climates, Cape and S Australian species remain far more often obligate (log odds +7.5, +7.0).

### Evidence and lineage out of sample (s12)

- **Evidence:** presumed from relatives for 57% of parasites (67% in southern Africa), 24% of facultative, 23% of non-associated and 11% of mutualists. Completeness: Australia 97%, southern Africa 80%, Palaearctic 53%, Nearctic 51%, Indomalaya 34%, tropical Africa 23%, New Guinea 16%, Neotropics 15%.
- **Lineage out of sample** (deviance explained, all / species-specific evidence): association 0.66 in sample, 0.44 / 0.39 for held-out species, 0.21 / 0.19 for held-out genera; obligacy 0.86, 0.77 / 0.69, but −0.29 / 0.04 for held-out genera (subfamily mispredicts; climate 0.12 / 0.13 does better); parasitism 0.85, 0.75 / 0.59, 0.19 / 0.13. Climate adds nothing to lineage for held-out species.
- **s06 with species-specific evidence:** latitude × hemisphere still predicts held-out subfamilies (0.26); anomaly given region and lineage ≈ 0.

### Null models and matched-only trees (s14)

- **Seasonality within genera** beats permutations of seasonality within genera (p ≈ 0.007 obligacy, 0.01 mutualism).
- **Lineage turnover (s05 gradients):** relative to permutations of strategies within genera, the part not reproduced by lineages is slightly larger than chance on average (z-score summary), but beyond the null for only 3 of 53 slopes.
- **Matched-only trees:** Australia 7 origins (both trees), southern Africa 3 (Yumnam) / 5 (Schär; only 47 of its 186 obligate species on these trees), Indomalaya 5, Palaearctic 2 / 5.

### Ant association along latitude (s15; owner's question about Europe)

- **Europe (hexagons ~23,000 km²):** the non-associated share rises from ~16% at 35°N to ~40% at 70°N (latitude 63% of deviance, temperature 56%; r = −0.91, not separable).
- **Cause:** facultative richness per hexagon falls 31% per 10° latitude; non-associated richness is flat. Southern facultative genera drop out (*Lysandra*, *Leptotes*, *Lampides*, *Tomares*, *Kretania*, *Iolana*; *Polyommatus* 6.6 → 1.9 species per hexagon); *Lycaena* and *Callophrys* persist, *Agriades* increases.
- **Lineages:** the genus-expected share rises almost as steeply (0.31 vs 0.35 log odds per SD); the remainder is within the within-genus null.
- **Not Holarctic:** no trend in the Nearctic; the reverse in the eastern Palaearctic.
- **Species level:** temperature does not predict association given lineage in any well-sampled region (only Indomalaya +1.05, p = 0.035, not within genera).

### Manuscript restructure (29 October 2026)

The working manuscript now tells one story in six findings: (1) strategies are structured in space and rest on few genera; (2) lineage, not climate, predicts a species' strategy (in and out of sample, species-specific evidence); (3) the same climates hold different strategies (Americas, Mediterranean regions, shared climate strata, same climates elsewhere); (4) within regions, gradients are lineage turnover (Europe as the example); (5) obligacy is a southern geography, with seasonal rainfall among close relatives; (6) few deep origins in old lineages. Nine main figures (s16 maps, s17 composites, s15 Europe, s11 seasonality, s09 tree); the detailed figures of each notebook are in a supplementary section.

### Figures (s16)

- World maps of each strategy's share (hexagons ~210,000 km², Equal Earth, one-hue ramps ending in the strategy colour), classification completeness, and obligate species by genus per region; map of the climates shared with the Cape and southern Australia, coloured by each region's obligate share there.

## Response to the second external review (28 October 2026)

| Point | Response |
|---|---|
| Evidence-basis sensitivity (many types, especially of parasites, assigned from relatives) | Done (s11, s12): coverage table by region, strategy and lineage; s04 and s06 results and the seasonality test hold with species-specific evidence only. |
| In-sample lineage shares are not evidence of mechanism | Done (s12): lineage evaluated for held-out species and held-out genera; s14: within-genus permutation nulls for the lineage-turnover agreement. |
| Rigorous species-level test of seasonality, with regional controls and split contrasts | Done (s11). Robust pooled, within genera and on the Schär tree; carried by Australia and the Indomalayan region; obligate mutualism, not parasitism; does not transfer to held-out subfamilies. |
| Per-subfamily cross-validation, not pooled scores | Done for obligacy (s11): latitude × hemisphere predicts every held-out subfamily (D² 0.18–0.45); region fails for Theclinae. |
| The mixed genera | Tabulated (s11, `mixed_genera.csv`); 14 genera, tree coverage 0–100%. |
| "3 vs 10 origins" contrast between southern Africa and Australia | Already superseded by s10: few deep origins in both (3 and 4); Australia adds shallow within-genus origins. |
| BiSSE / state-dependent diversification | Not used; agreed. |
| Strengthen the Mediterranean comparison | Done (s13): coarsened exact matching on climate strata, completeness bounds, imputation from congeners, genus bootstrap, the same climates outside the five regions, species-climate models and shared genera. See the s13 results below. |
| Ant availability before deep-time climate | Agreed; Kass et al. 2022 needs a manual download (Dryad blocks scripted access). |
| Postpone connectivity and deep-time downloads | Agreed; PALEO-PGEM and soil P stay optional in s08. |

## Response to the third external review (29 October 2026)

Two ChatGPT reviews of the paper draft. Their main points, and what was done:

| Point | Response |
|---|---|
| Diversification, "persistence" and "no rapid radiation" claims are not supported (rates from extant genera; *Lepidochrysops* radiated, Espeland et al. 2023) | Removed from the paper, the working manuscript and the s17 history figure. Rates from stem ages and richness cannot separate speciation from extinction (Rabosky & Benson 2021, *Nat. Commun.* 12, 2945, verified). Origins of obligacy kept as exploratory (Appendix S6). The circular tree is no longer a main figure. |
| Shared-climate comparison: standardise over common strata, multi-stratum species, balance, retention, sensitivity, genus bootstrap separate from classification bounds | Done (s18). Cape vs Basin standardised obligate share 60% vs 4%, difference 56 points (20–77); 49–61 points for every stratum width (×0.5–2) and minimum occupancy (1–10 pixels), lower bounds ≥ 16. Main-stratum version 69 (33–83). S Australia vs Basin 29 (0.3–65), weaker. Balance after weighting, for the pairs with the Basin: |SMD| ≤ 0.22 except minimum temperature (0.26–0.31; Cape–S Australia: mean temperature 0.30). Retention: shared strata hold 39% of the Cape's Cs pixels and 86% of its classified species, but 8% and 38% of the Basin's. |
| Separate obligate mutualists from parasites | Done (s18): in Cape–Basin strata, mutualists 31% vs 2%, parasites 29% vs 1%; S Australia's excess is mutualists (29% vs 1%). |
| Species- vs genus-weighted composition | Done (s18): Cape − Basin 63 points species-weighted, 19 genus-weighted (the rest: species-rich obligate genera; top three hold 76% of the Cape's obligate species); S Australia − Basin 39 vs 34 (many obligate genera). |
| Held-out realms and subfamilies with calibration, uncertainty, baselines, novelty | Done (s20). Obligacy, held-out realms: lineage D² 0.47 (0.17–0.71), AUC 0.89; latitude × hemisphere 0.32; climate 0.09, AUC 0.54. Climate predicts 37% obligate in the Neotropics (0 observed), 36% in the Palaearctic (8%), 29% in southern Africa (70%); at most 24% of a realm's species are climatically novel (Nearctic), 0% in the Neotropics. Lineage fails for Australia (endemic obligate genera; 9% vs 56%). Held-out subfamilies: climate 0.17, latitude × hemisphere 0.26. |
| Ants: richness as baseline; partner genera; presence is not compatibility; Riodinidae | Done (s21; Kass et al. 2022 data downloaded manually). Ant richness has no effect on obligacy given region and lineage (−0.28, p = 0.18) and a weak positive one on association (+0.25 given lineage, p = 0.04). *Crematogaster* and *Camponotus* carry most obligate partner records and are species-rich in the Mediterranean Basin (40 and 90 species in its Cs area, against 16 and 29 in the Cape), where 36 and 45 facultative lycaenids are recorded with them. Colony ecology is named as the next test. Riodinidae discussed with the Neotropical result (Espeland et al. 2015; Pierce & Dankowicz 2022; Fiedler 2021). |
| Seasonality: all 14 mixed genera, more permutations, multiple-testing correction, drought vs seasonality, nest-dwelling | Done (s19). Given region and lineage, dry months +0.84 (p = 0.003, Holm 0.048 over 14 properties), longest dry spell +0.82 (Holm 0.052; r = 1.00 with dry months), driest-month precipitation −0.49, seasonality +0.48 (Holm 0.28). Mutualists only; parasites none. Within the 14 mixed genera (145 species), all four properties beyond 9,999 permutations (p ≤ 0.004); every genus tabulated (Table S5.6). Carnivory: 149 of 150 parasites vs 3 of 137 mutualists, so the association concerns ant-tended larvae; nest use of mutualists is not recorded. Treated as provisional. |
| Figures: four main figures; Europe to SI; no lines between CV schemes; larger fonts; no truncated intervals | Done (s22): Fig. 1 world maps (s16); Fig. 2 shared climates (map panel, standardised four strategies, sensitivity, same climates elsewhere); Fig. 3 lineage vs climate (composition, held-out realms, out-of-sample D² without joining lines, held-out units); Fig. 4 what remains (held-out subfamilies, Holm-adjusted effects, all 14 mixed genera, partner genera). Europe is Appendix S3. |
| Wording: new title; no "climate sorts lineages" / "history sets the pool" as mechanisms; observation vs explanation; "overlapping measured climatic conditions"; what is new vs Pierce et al. 2002 | Done in the paper (title "Similar climates, different interactions: lineage composition shapes the global geography of butterfly–ant associations"). |
| Provenance s01–s17+ | Updated (s01–s22 in `run_all.R` and the READMEs). |
| Soil phosphorus and 5-Myr aridity | Added (s08 rerun with He et al. 2021 and PALEO-PGEM at 10-kyr steps): neither adds to latitude × hemisphere for held-out subfamilies (largest gain +3.9 points, PALEO-PGEM dry share); low soil P goes with obligacy given lineage (−0.67, p = 0.01) but not given region (p = 0.17). |
| Range-map validation (Pinkert), palaeoclimate, connectivity, BiSSE | Deferred. |

## Next steps, in order

1. ~~Stability against southern history~~ **(done, s06):** given region and lineage, the LGM anomaly has no detectable effect on obligacy (0.05 log odds per SD, p = 0.92), in each hemisphere, without southern Africa, without *Lepidochrysops*, *Thestor* or *Chrysoritis*, and within genera. Latitude and hemisphere predict held-out subfamilies better than the anomaly (cross-validated D² 0.27 against 0.11), and the anomaly adds nothing to them. The obligacy signal is a southern mid-latitude concentration shared by several subfamilies; glacial stability (H6) cannot be separated from it. **New first priority:** what the southern continents share, namely soil nutrients (H3), fire and seasonal drought (H2), and the age of arid and sclerophyll biomes (H7), each tested by prediction of held-out lineages beyond latitude and hemisphere.
2. **Coverage diagnostics:** classification completeness by realm and grid size; results restricted to well-classified cells and species-level evidence only.
3. **Cell-level compositional model** (multinomial) with a small predictor set, spatially blocked and leave-one-realm-out prediction, and nulls that keep lineage structure.
4. **Climate-matched comparisons** among cells of the five Mediterranean-climate regions and other climatically similar regions.
5. **Independent palaeoclimate:** CHELSA-TraCE21k anomaly and velocity; velocity sensitivity (gradient floor, resolution, analogue velocity); biome persistence from Beyer2020.
6. **Ant availability** (Kass et al. 2022 stacked known ranges; partner genera) and, as competing explanations, soils and fire. **Now first priority** (second review), once the Dryad files are downloaded.
7. ~~Evidence-basis sensitivity of s04 and s06~~ **(done, s12).**

## Open decisions for the authors

- ~~Whether Riodinidae belong in this paper~~: decided 28 October 2026, they are excluded (lycaenids only); Neotropical riodinid myrmecophily is mentioned only as context for the American result.
- **First full draft written 29 October 2026:** `writing/paper_draft.Rmd` (GEB structure; abstract about 300 words including headings, main text about 3,700 words, seven figures; all numbers inline; references verified against the literature bibliographies, the parent study's `.bib` or Crossref). Rendered with `Rscript code/render_manuscript.R`. The Supporting Information (Appendices S1–S6: 13 figures, 14 tables, numbered S1.1 etc.) is in the same document, after the references, at the owner's request (one document). **Rewritten after the third review (29 October 2026):** new title, four main figures (s16, s22), new results from s18–s21, Appendices S1–S6 rebuilt (Europe in S3; diversification removed).
- ~~Focus of the paper~~: decided 29 October 2026 (owner left it to Claude). The paper centres on climate against lineage, with the shared-climate comparison as the central test; obligacy and the phylogeny explain the one exception. See `writing/paper_outline.md`: GEB structure, draft abstract and seven display items.
- Whether soils, fire and ants belong in this paper or in a follow-up (the outline keeps soils and fire in Fig. 6 and ranks the ant data as the most valuable addition before submission).
- Primary grain (250 or 500 km) after the coverage diagnostics.
