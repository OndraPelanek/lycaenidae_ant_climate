# Research assessment and roadmap

Written 30 October 2026 in response to the sixth external review (ChatGPT, "Comprehensive scientific feedback and next research priorities"). The overarching question is: **why are the different forms of butterfly–ant interaction so unevenly distributed across the world, even where climates are comparable?** The study stays within Lycaenidae (the all-butterfly GBIF background of `s35`–`s37` uses Riodinidae records only as a measure of recording effort; no riodinid is analysed).

Every claim below is placed on one of four levels: **pattern** (what is observed) → **association** (a statistical relationship that survives the controls we can apply) → **proposed process** (a mechanism consistent with the association) → **supported mechanism** (a process for which the data provide direct evidence). No result of this study has yet reached the fourth level.

## 1. Critical assessment

### What is established (pattern and robust association)

1. **Similar climates hold different interactions.** Within the climate strata the Cape shares with the Mediterranean Basin, about 60% of the Cape's classified species and 4% of the Basin's are obligate associates (`s18`); the contrast survives every weighting, grain, occupancy, evidence and genus-weighting variant. It is conditional on the shared climates, which cover only a small part of the Basin's Mediterranean-climate area (8% of its pixels, 38% of its species): it compares the Cape with the Basin's warm, dry, frost-free margin. Southern Australia differs from the Basin by a similar amount, but less certainly. Compared within shared climates, southern Africa and Australia hold more obligate species than nearly every other region (`s24`).
2. **The strategies are concentrated in lineages, and lineage predicts them while the genus is known.** Lineage explains about three quarters of the held-out deviance in obligacy for held-out species and about half for held-out realms, but its advantage comes from genera shared between realms; for genera found only in the held-out realm it does worse than latitude and hemisphere (`s20`). Climate models, linear or flexible, explain at most about a fifth of the held-out deviance, and fail in realms whose climates lie within the training range (`s20`, `s28`).
3. **Knowledge does not produce the ordering** (`s26`).
4. **Several simple explanations are not supported by the proxies used:** the LGM temperature anomaly (weakly tested: wide interval), present soils, phosphorus, fire, 5-Myr precipitation, ant species richness, and the prevalence of the main partner genera in local ant communities.

### What is novel relative to the literature

Pierce et al. (2002) already proposed that lineage composition contributes to the southern prevalence of obligate myrmecophily. The study's contribution cannot be "climate predicts less than taxonomy". What is new is:

- **a quantitative, climate-standardised demonstration** that regions differ within the climates they share, with the effective comparison population disclosed;
- **a decomposition of prediction by what is unseen**: lineage carries strategies where lineages are shared; something geographic, not captured by the measured climate, soils, fire or ant richness, marks where new obligate lineages appear (latitude and hemisphere predict unseen genera and subfamilies better than climate);
- **the confinement of obligate genera** (an association, robust across definitions, grains and sampling; unclear among sister clades);
- **a set of informative negative results** that constrain the candidate explanations.

### What is suggestive or inconclusive

- **Dry seasons among close relatives.** Within genera, mutualists sit in the drier parts of their surroundings (`s29`, `s34`); against an all-butterfly background, the contrast with facultative congeners is positive in direction but not established (`s36`: 0.80, interval −0.11 to 1.71; `s37`: 0.66, bootstrap −0.05 to 1.83, 5 of 9 origins), shrinks with temperature in the model, and weakened when GBIF records were added. Whether drought can be separated from warmth at all with these data is unknown.
- **Partner colony size** (positive for lycaenid species, contrary in southern Africa; coverage poor).
- **Higher rates of origin of obligacy in the south** (2.5–3.9 times, within chance).

### Analyses that could change the interpretation

1. **Identifiability of drought versus warmth** (diagnostic). If dryness and temperature are collinear within the contrasts, the drought hypothesis cannot be resolved with these data, whatever model is fitted.
2. **Occurrence-data reliability** (diagnostic). If the GBIF additions that weakened the estimate are records the parent cleaning deliberately removed, they should not be used.
3. **The real number of independent origins** (diagnostic). Replication may be smaller (or larger) than nine.
4. **Confinement across phylogenetically validated contrasts with several response variables.** Consistent replication would move confinement from a genus-level correlation to a replicated comparative pattern; it would still not establish that dependence limits spread.
5. **Natural history and partner traits** (larval phenology, nest use, host plants; colony persistence of partner ants). These are the only route to a supported mechanism, and need literature compilation, not more models.

## 2. Conceptual model

Three processes, not mutually exclusive, linked in both directions:

- **A. Assembly of regional species pools** — historical diversification, dispersal and geographical restriction determine which lineages a region holds.
- **B. Contemporary environmental filtering** — climate, vegetation, host plants and ant communities determine where species of those lineages occur.
- **C. Interaction strategy** — ant dependence may modify climatic niche occupancy (C → B), geographical expansion (C → A) and ecological opportunity.

Arrows and what can be tested here:

| Pathway | Prediction | Testable with our data? | Status |
|---|---|---|---|
| A → regional strategy mix | Shared-climate differences lie in lineages | Yes | Pattern established (`s13`, `s18`, `s24`) |
| B → strategy within regions | Strategies follow climate within regions and genera | Yes | Mostly lineage turnover (`s05`, `s14`, `s15`) |
| Environment → evolution of obligacy | Obligacy arises more often in some environments | Weakly (few origins, tree-dependent) | Suggestive (`s25`) |
| C → B (niche) | Mutualists occupy drier niches than congeners | Yes, if dryness is identifiable | Inconclusive (`s36`, `s37`); identifiability `s38` |
| C → A (spread) | Obligate lineages expand less after becoming obligate | Partly (range comparisons); order of events needs dated range reconstructions | Association (`s23`, `s33`); replicated contrasts `s44` |
| Partner availability → C | Obligacy where compatible, persistent colonies exist | Only with partner trait data | Unresolved; data compilation needed |

## 3. Primary variables, fixed now

To avoid choosing among many related indices, three variables represent the three dryness hypotheses in all new analyses (`s38`, `s41`, `s42`):

- **H1 warmth:** annual mean temperature (WorldClim bio01).
- **H2 dry-season duration, independent of temperature:** the longest run of consecutive months (circular year) with less than 50 mm of rain.
- **H3 water stress:** the annual climatic water deficit, the sum of monthly Hargreaves potential evapotranspiration in excess of precipitation.

Larval-period conditions would be more meaningful than annual ones, but need larval phenology, which we do not have for most species (§5, package C).

## 4. Roadmap, ranked

Ranking: contribution if successful × feasibility × probability of an interpretable result.

| Rank | Analysis (notebook) | Hypothesis | Contribution | Feasibility | Data needed | Identification challenge | Probability interpretable | Decision rule |
|---|---|---|---|---|---|---|---|---|
| 1 | Climatic identifiability and common support per contrast (`s38`) | Can H1–H3 be separated? | Decides whether the drought question is answerable | High | Existing | None: descriptive | High | If fewer than three contrasts retain substantial dryness variation within shared temperature ranges, stop modelling drought with these data and say so |
| 2 | Occurrence audit of the GBIF supplementation (`s39`) | Data reliability | Decides which occurrences to trust | High | Existing + GBIF facets | Provenance of density-map records is indirect | High | Records in pixels the parent cleaning removed are excluded from any further use |
| 3 | Independent origins on published trees (`s39`) | Replication | Defines the units of replication | Medium | Yumnam species tree (matched tips), Kawahara genus tree | Sparse species sampling in trees | Medium | Count each within-genus obligate clade on the species tree as one origin; report the count |
| 4 | Power simulation (`s40`) | Which data would help? | Guides data collection | High | Existing estimates | Assumes the fitted heterogeneity | High | If no realistic addition gives 80% power for a difference of 0.5 per SD, the drought hypothesis needs field or natural-history data, not more occurrences |
| 5 | Matched case–case test within temperature strata (`s41`) | H1, H2, H3 | Transparent test within common support | High, if `s38` passes | Existing | Observation process of strategies may differ; few contrasts | Medium | Report per origin and pooled; interpret only contrasts flagged identifiable |
| 6 | Four strategies, one framework (`s42`) | Do association, obligacy and parasitism respond differently? | Completes the global picture | High | Existing | Lineage confounding | High | Report the three conditional contrasts side by side |
| 7 | Decomposition of the southern faunas with a lineage null (`s43`) | What makes the Cape and Australia obligate-rich? | Precise answer to the descriptive question | High | Existing | Null model choice | High | Regional excess beyond the subfamily-conserving null is reported as a pattern needing a lineage-history explanation |
| 8 | Confinement across sister contrasts with several responses (`s44`) | C → A | Could make confinement a replicated pattern | Medium | Existing + both genus trees | Order of events unknown | Medium | Consistent sign in at least two thirds of contrasts on both trees justifies dated range reconstruction on well-resolved clades (package C) |
| 9 | Natural history of the best contrasts | Mechanism of H2/H3 | Only route to a supported mechanism | Low now (literature) | Larval phenology, nest use, host plants, ant partners | Uneven literature | Medium | Start with the contrasts `s38` flags as identifiable |
| 10 | Partner-ant traits for southern partners | Partner compatibility | Links ants to obligacy | Low now (literature) | Colony size, persistence, nesting, dominance | Trait data biased to the Holarctic | Medium | If fewer than half of the partners of southern obligate species can be scored, treat as a separate study |
| 11 | Joint range–trait reconstruction on well-resolved clades | C → A, origin of southern concentration | High originality | Low (needs clade trees) | Dated clade phylogenies | Tree uncertainty | Low–medium | Only after rank 8 replicates |

Deprioritised: further palaeoclimate modelling (the LGM result stays as a negative result); new global predictor screens; Riodinidae (out of scope).

## 5. Research packages

- **A. Publishable paper.** Reproduce and audit the central results; redesign the figures around the discoveries; disclose effective comparison populations and inference levels; rewrite the abstract and discussion around defensible conclusions. Independent of whether any mechanism emerges.
- **B. Decisive comparative ecological analysis.** Ranks 1–5 and 9.
- **C. Evolutionary and biotic-interaction investigation.** Ranks 8, 10 and 11; may become separate studies.

## 6. Decision points

- **Drought (package B):** if `s38` finds the contrasts unidentifiable, or `s40` finds no realistic data addition that gives adequate power, the drought hypothesis is reported as unresolvable with occurrence data and moved to the SI; investment goes to natural history. If several contrasts are identifiable and `s41` gives consistent signs among them, the natural-history comparison of those contrasts becomes the priority.
- **Confinement (package C):** if `s44` replicates on both trees across most responses, invest in dated range reconstructions; otherwise publish confinement as an association.
- **Paper (package A):** proceed regardless; the descriptive and comparative contribution stands on its own.

Analyses chosen after inspecting earlier results are labelled sequential or exploratory in the notebooks and the manuscript.

## 7. Results of the diagnostics and analyses, and the decisions they trigger (30 October 2026)

**Rank 1, identifiability (`s38`).** With temperature-independent measures, drought *can* be told apart from warmth: within the ten contrasts, the run of months below 50 mm correlates weakly with temperature (|r| < 0.35 in nine of ten), and both it and the water deficit keep 67–100% of their variation within 1 °C temperature bins. Every contrast is identifiable. The earlier confounding came from the Gaussen definition of dry months (precipitation below twice the temperature), not from the data. *Decision: proceed to the matched comparison.*

**Rank 2, occurrence audit (`s39`).** Of the 3,653 pixels added from GBIF in `s37`, 955 hold records that the parent cleaning had removed (mostly by its basic coordinate, basis and duplicate filters). The supplementation weakened the dry-month estimate (0.95 to 0.60) almost entirely through six species that became eligible only with GBIF records (re-estimating the existing species gave 0.89). The added records are ordinary (iNaturalist research grade, national schemes, museums). *Decision: cleaned records are primary; supplemented records without cleaning-removed pixels are a sensitivity analysis. The estimate depends on which species are included.*

**Rank 3, independent origins (`s39`).** Ten contrasts in nine origins; only four have at least two species of each strategy; the largest is 33 mutualists against 2 facultative species. Mutualists form several clades within *Hypochrysops*, *Ogyris*, *Cigaritis* and the South African Aphnaeinae on the matched species tree, but these share the same few facultative relatives. Real replication is about nine weakly balanced contrasts.

**Rank 4, power (`s40`).** Variation among species within an origin is large (variance about 1 per SD²) and the difference hardly varies among origins. More records per species do not raise power (27–29% for a difference of 0.5 per SD); three more species of each strategy per origin, or ten more origins, would raise it to about 56–57% (93–94% for 0.8). *Decision: more occurrences will not resolve the question; more species per contrast and more independent origins would, and realistic additions still leave modest effects undetectable.*

**Rank 5, matched case–case comparison (`s41`).** At matched temperature, mutualists' places did not have detectably longer dry seasons than their facultative relatives' (0.21, −0.07 to 0.48 SD; 6 of 9 origins), greater water deficit (0.14, −0.08 to 0.35) or, at matched dry-season length, higher temperature (0.04, −0.08 to 0.17). Unmatched, the dry-season difference was 0.33 (0.02 to 0.64); within temperature bins and biomes it was 0.05 (−0.08 to 0.19). Outcome under the pre-set rules: not detected for all three hypotheses. *Decision: the dry-season association is a difference in the habitats (biomes) the strategies occupy, not a detected response to drought; the niche modelling moves to the SI and Fig. 4 shows the matched result. The drought hypothesis cannot be resolved further with occurrence data; natural history (larval timing, nest use, host plants) of the best contrasts is the next step (templates in `data/raw/natural_history/`).*

**Rank 6, four strategies (`s42`).** Any association and parasitism are unrelated to warmth, dry-season length and water stress, given region and lineage and within genera; within genera of the Palaearctic and Nearctic, association is unrelated to temperature (the European northward pattern is turnover between genera). Obligacy and mutualism go with each variable alone; together, only warmth keeps an effect within genera.

**Rank 7, decomposition (`s43`).** The Cape is obligate-rich through few (23%), entirely obligate, species-rich and narrowly distributed genera, with many parasites; southern Australia through many (43%) partly obligate genera of mutualists, more widespread. Southern Africa, Australia, the Cape, southern Australia, tropical Africa and New Guinea exceed a subfamily-conserving null; the Mediterranean Basin, Palaearctic, Indomalaya and the Americas do not. *A new descriptive result: the southern excess lies in which genera of their subfamilies reached and persisted in the south, not in which subfamilies are present.*

**Rank 8, confinement contrasts (`s44`).** Eleven independent obligate clades on each tree of genera: the obligate clade is less widespread (hexagons, regions, range patches) than its sister clade in 7–8 of 11 contrasts and has a narrower temperature range in 8–9, none significant; shelf landmasses and dry-season breadth show nothing. *Decision: confinement remains a genus-level association; dated range reconstructions are not yet justified.*

**Package A (paper).** Revised: Table 1 gains a level-of-inference column; the Introduction states the three-process framework and the four levels; Results add the decomposition, the matched comparison, the four strategies and the sister-clade replication; Fig. 4 is redesigned (geography of unseen lineages; dry seasons origin by origin at three levels of matching; the three hypotheses); the Discussion and Abstract are rewritten around defensible conclusions.

**Remaining open:** ranks 9–11 (natural history, partner-ant traits, joint range–trait reconstructions) need literature compilation or clade phylogenies, not further models.
