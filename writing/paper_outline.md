# Paper outline: Global Ecology and Biogeography

Drafted 29 October 2026 from the working manuscript (`climate_manuscript.Rmd`). Numbers are from the run of that date; in the paper they will be inline R, as in the working manuscript.

## Focus, and why

The paper should centre on one question: **how much of the geography of ant-interaction strategies is associated with climate, and how much with the lineages that carry them?** Its central test is the comparison of regions within shared climates. Three reasons:

1. **It is the most direct and the most robust test.** Same climates, different strategies holds within shared climate strata, under any assignment of the unclassified species, with genera resampled, and in the same climates outside the Mediterranean-climate regions. No other analysis is this hard to explain away.
2. **It answers the external review's main concern.** That review noted that the southern concentration of obligate lineages was already recognised (Pierce et al. 2002; Fiedler 2021). The contribution has to be a quantified separation of climate from lineage, which the out-of-sample, shared-climate and permutation tests provide.
3. **The other findings then fall into place.** The European gradient shows the same thing within a region. Obligacy is the one exception, and the phylogeny explains where that exception comes from.

The six findings of the working manuscript are therefore kept, but weighted: findings 2–4 are the core, finding 5 is the exception, and finding 6 explains the exception. The cell-level partition, the Pagel test and the phylogenetic coefficients go to the Supporting Information.

## Title (options)

1. Climate sorts lineages, history sets the pool: the global geography of butterfly–ant interactions
2. Same climates, different strategies: lineage history and the geography of butterfly–ant interactions
3. Climate, lineage history and the global geography of ant associations in lycaenid butterflies

## Structured abstract (draft, about 290 words)

**Aim:** Larvae of lycaenid butterflies interact with ants in four ways, from no association to obligate mutualism and obligate parasitism, and these strategies are strongly structured in space. We asked how much of this geography is associated with present and past climate, and how much with the history of the lineages that carry the strategies.

**Location:** Global.

**Time period:** Present; climate change since the Last Glacial Maximum.

**Major taxa studied:** Lycaenidae (Lepidoptera).

**Methods:** For 1,177 classified species with cleaned occurrence records, we related the strategies to present climate, climate change since the Last Glacial Maximum, soils and fire. We judged climate and lineage by how well they predicted species and lineages left out of the fit, compared regions within the climates they share, and separated lineage turnover from change within lineages with permutations. We also counted the origins of obligacy on published phylogenies.

**Results:** Knowing a species' genus predicted its strategy for held-out species (44–77% of the deviance); climate explained at most 18% and added nothing to lineage. Within climates shared by the Cape and the Mediterranean Basin, 67% and 6% of species were obligate associates. No southern obligate species belonged to a genus shared with the Basin or California. Within regions, climate gradients in composition were mostly lineage turnover: in Europe, non-associated species became a larger share northwards because facultative blues dropped out. Obligacy was the one strategy whose geography crossed lineages. Latitude and hemisphere predicted it in unseen subfamilies, whereas glacial climate change, soils and fire added little; seasonal rainfall was associated with obligate mutualism among close relatives. The obligate-rich southern faunas grew from few deep origins in old lineages that did not diversify faster.

**Main conclusions:** Lineage history sets which ant-interaction strategies a region holds, and climate mainly sorts lineages within regional pools. The southern concentration of obligate associates is consistent with the long persistence of old obligate lineages, rather than with repeated responses to present or glacial climate.

**Keywords (6–10, alphabetical):** ant–butterfly interactions, biogeography, climate, Last Glacial Maximum, lineage history, Lycaenidae, mutualism, myrmecophily, parasitism, phylogenetic niche conservatism.

## Main text (about 5,000 words)

### Introduction (about 800 words)

1. **The pattern.** The four strategies and their geography (parent study): obligate associates in southern Africa and Australia, none in the Americas.
2. **Explanations at three timescales.** Present filtering (cold limit on ant activity, Pellissier et al. 2012; nest refuges in seasonally dry biomes, Espeland et al. 2023); Late Quaternary stability (Dynesius & Jansson 2000; Sandel et al. 2011); deep contingency (Pierce et al. 2002; Vila et al. 2011).
3. **The difficulty.** Strategies are concentrated in few lineages, so climate and lineage are confounded. Cell-level analyses cannot separate them, because a spatial smooth absorbs climate (working manuscript, cell-level section).
4. **Our approach and predictions.** If climate shapes the strategies, it should predict them in lineages not used to fit the model, regions with the same climate should hold the same strategies, and gradients within regions should arise within lineages. If lineage history sets them, the reverse.

### Methods (about 1,400 words)

1. **Data:** species, strategies and evidence basis; cleaned records; grids (500-km squares, ISEA hexagons); climate (WorldClim 2.1, Krapp et al. 2021, velocity), soils (SoilGrids), fire (GFED5); classification completeness.
2. **Climate and lineage among species:** three nested contrasts; taxonomic models; cross-validation by species, genus and subfamily; species-specific evidence.
3. **Shared climates:** Köppen–Geiger Cs regions; climate strata (coarsened exact matching); completeness bounds; genus bootstrap; the same climates elsewhere.
4. **Within regions:** lineage expectation from congeners; within-genus permutations; the European hexagons (resolution 7); richness by strategy along latitude.
5. **Obligacy:** held-out subfamilies with geography, climate, soils and fire; effects given region and lineage; the seasonality checks.
6. **Phylogeny:** genus-grafted and matched-only trees, the tree of genera, stochastic maps, diversification rates.

### Results (about 1,600 words), one paragraph block per figure

1. Geography and lineages (Figs 1, 2a).
2. Lineage predicts, climate does not (Fig. 2b).
3. Same climates, different strategies (Figs 3, 4).
4. Within regions: Europe (Fig. 5).
5. Obligacy: southern geography and seasonal rainfall (Fig. 6).
6. Origins and diversification (Fig. 7).

### Discussion (about 1,200 words)

1. **History sets the regional pool.** The Americas and the Mediterranean-climate regions; the lineages that never reached them (Vila et al. 2011). The convergence of the Cape and Australia in other ant-related traits.
2. **Climate sorts lineages within pools.** The European example; cold, ants and host plants as candidate mechanisms (Pellissier et al. 2012); strategies are conserved within genera.
3. **The southern exception.** Few deep origins and slow diversification point to persistence. Old nutrient-poor landscapes (H3) and aridification (H7) remain candidates; stability (H6) is not supported. Seasonal rainfall goes with recent origins within genera (Espeland et al. 2023 for the nest-refuge idea). Parasitism is a separate story (*Phengaris* against *Lepidochrysops*).
4. **Conclusion:** positive, with caveats as subordinate clauses (supervisor's rule).

## Display items (7 of 6–8)

| No. | Content | Source | Change needed |
|---|---|---|---|
| 1 | World maps of the four strategies, classified species, completeness | s16 `plot_world_strategies.png` | panel letters lower-case (a)–(f) |
| 2 | Regional composition by genus; lineage against climate out of sample | s17 `figure_lineages.png` | lower-case letters |
| 3 | Mediterranean pools; shared-strata pairs; same climates elsewhere | s17 `figure_shared_climates.png` | lower-case letters |
| 4 | Map of the climates of the Cape and southern Australia | s16 `plot_shared_climates.png` | could become panel (d) of Fig. 3 if the display limit is tight |
| 5 | Europe: map, richness by strategy, observed against lineage-expected share, genera | s15 `plot_europe_association.png` | lower-case letters |
| 6 | Predictors of obligacy in held-out subfamilies; effects given region and lineage | s17 `figure_obligacy_predictors.png` | add panel (c): seasonality within mixed genera (from s11) |
| 7 | Tree with strategies; origins on four trees; diversification | s09 tree + s17 `figure_history.png` | combine the tree and the two panels into one figure |

## Supporting Information

- **Appendix S1, data:** evidence basis and completeness (s12); the Americas transfer table (s03); data sources.
- **Appendix S2, species models:** partition and coefficients on both trees (s04); map fit (s04).
- **Appendix S3, regions:** all regional gradients (s05); robustness to grid and grain; association elsewhere (s15).
- **Appendix S4, shared climates:** all pairs, coarse strata, species-climate models (s13); nearest-neighbour matching (s07).
- **Appendix S5, obligacy:** stability tests (s06); soils and fire (s08); seasonality checks and nulls (s11, s14).
- **Appendix S6, phylogeny:** Pagel tests (s09); polytomy resolutions (s10); matched-only trees (s14).

## Before submission, in order of value

1. **Ant data (Kass et al. 2022).** Ant richness and partner genera would test the most obvious mechanism behind the European gradient and the American absence. It is the one addition that could change the story.
2. **Soil phosphorus** (He et al. 2021). This is the nutrient most often linked to the Cape and Australian ant-dominated ecosystems.
3. **Clade phylogenies** (*Lepidochrysops*; Australian Luciini), to confirm the deep-origin counts.
4. **References:** every reference in the draft is verified (bibliographies in `writing/literature/`, the parent study's `.bib`, or Crossref on 29 October 2026); keep to verified references only.
