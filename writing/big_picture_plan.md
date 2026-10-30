# Big picture: what the paper says, whether it is enough, and what to do next

Written 29 October 2026, after the third review round and the rewrite of `paper_draft.Rmd`.

## 1. What the paper currently says

In one sentence: **the global geography of lycaenid–ant strategies follows the lineages each region holds more closely than its climate.** The evidence:

1. Knowing a species' genus predicts its strategy out of sample; its climate barely does.
2. Climate models fitted elsewhere fail for whole realms (they forecast obligate species in the Neotropics, where there are none, within the climates of the training data).
3. In climate strata that the Cape shares with the Mediterranean Basin, 60% vs 4% of species are obligate; the Cape's obligate species belong to genera absent from the Basin.
4. Within regions, climate gradients in composition are mostly turnover of genera (Europe as the example).
5. The one signal that crosses lineages is a **southern concentration of obligacy**: latitude × hemisphere predicts obligacy in held-out subfamilies; glacial stability, soils, fire and ant richness add little.
6. Among close relatives, obligate mutualists live where dry seasons are longer (provisional).

## 2. Is this interesting enough? An honest assessment

**What works.** A large, carefully cleaned dataset (1,177 classified species, 3.1 M records); out-of-sample tests at four levels; a natural experiment (overlapping Mediterranean climates); thorough robustness. It is publishable in a regional/macroecology journal as it stands.

**Why a demanding reviewer or editor may still say "so what?":**

1. **The headline is expected.** Strategies are strongly conserved within genera, so "lineage predicts better than climate" is close to a restatement of phylogenetic niche conservatism, and Pierce et al. (2002) already suggested the lineage explanation. Lineage composition *is* biogeography; saying that biogeography follows lineage composition risks circularity.
2. **The explanation is negative.** We show what does *not* account for the southern concentration (climate, glacial stability, soils, fire, ant richness, partner presence) but not what does. "History" is the residual, not a tested mechanism.
3. **The most interesting result is buried.** Obligacy is concentrated at southern mid-latitudes *across unrelated lineages* (Aphnaeinae and *Lepidochrysops* in southern Africa; Luciini, *Ogyris*, *Jalmenus*, *Hypochrysops* in Australia) and predicts held-out subfamilies. That is **convergence**, which contradicts a purely contingent, lineage-only story. It is currently one paragraph in Results.
4. **The flagship comparison is small.** The Cape–Basin contrast rests on 5 shared strata, 85 Cape pixels and 8% of the Basin's area. One pair of regions is an anecdote, however carefully standardised.
5. **Knowledge bias is a live alternative.** Classification is 97% in Australia and 80% in southern Africa but 15% in the Neotropics. Obligate associations are found by people who rear larvae; the best-studied faunas may look the most obligate.

**Diagnosis.** The data hold a more interesting story than the one told: *two levels of explanation that fit together*.

- **Why does obligacy arise where it does?** Repeatedly and independently in the southern continents (convergence), not where the climate is similar (Mediterranean Basin, California, the Americas). Something about the southern continents, not their climate.
- **Why does it stay there?** Obligate lineages rarely spread (they depend on particular ants; obligate species have smaller ranges in the parent study), so lineage composition preserves the southern signal. This turns "history" from a residual into a testable mechanism: **dependence limits dispersal**.

This also connects to a broad, long-standing question with appeal beyond lycaenids: **why are ant mutualisms more intense in the southern continents?** Seed dispersal by ants (Lengyel et al. 2010), dominance of large-colony dolichoderines and formicines, and sclerophyll vegetation on old, infertile soils (Orians & Milewski 2007; Hopper 2009) all show the same Cape–Australia convergence.

**Proposed headline (to test, not to assume):** *Obligate butterfly–ant mutualism evolved repeatedly in the southern continents, independently of climate, and stays there because dependent lineages rarely spread.*

If the convergence and dispersal tests fail, the current framing stands, and the paper is a solid GEB/Ecography paper. If they succeed, the paper becomes a general statement about the geography of mutualism intensity (Ecology Letters / Nature Ecology & Evolution level ambition).

## 3. Analyses that would change the story (in priority order)

### A. Convergence: are origins of obligacy concentrated in the south, per unit of lineage history? (core, 2–3 days)

- **Question.** Is the rate at which lineages become obligate higher while they live in southern Africa or Australia than elsewhere, accounting for how much lineage history (branch length) each region holds?
- **Approach.**
  1. Map region onto the tree (tips by region; internal branches by stochastic mapping of a region character, or a simple biogeographic reconstruction).
  2. Count origins of obligacy on branches in each region, per million years of branch length in that region, over stochastic character maps.
  3. As a complementary model, fit a joint model of obligacy and "southern" region (corHMM / Pagel-type dependent model) on a tree with good genus coverage.
- **Better tree.** Kawahara et al. (2023) global butterfly phylogeny (~2,300 species, 92% of genera, dated). The Yumnam tree gave inconclusive results with heavy grafting; a genus-complete tree is the right resolution for origins between genera. *Needs a manual download if Dryad blocks scripts.*
- **Go / no-go.**
  - **Supports the reframing:** origin rates in the south are several times those elsewhere, robust across trees and mapping uncertainty.
  - **Otherwise:** origins are few and simply where the lineages are, and the current framing stays.

### B. Dependence limits dispersal (core, 1–2 days)

- **Question.** Do obligate lineages spread less than facultative lineages of the same age?
- **Pilot (done now, unadjusted).** Among genera with at least 3 classified species, 68% of obligate genera are confined to one region, against 46% of other genera; mean regions per genus 1.4 against 1.9.
- **Tests.**
  1. Number of regions (and range extent) per genus against stem age, by strategy (phylogenetic regression on the genus tree).
  2. Within mixed genera, are obligate species more narrowly distributed than their facultative congeners?
  3. Link to species range sizes from the parent study (obligate species have smaller ranges).
  4. The few obligate lineages that did spread (e.g. *Phengaris*, *Cigaritis*) as informative exceptions.
- **Why it matters.** It gives the "lineage composition" result a mechanism and explains why the Basin and the Americas lack obligates despite suitable climates and partner genera.

### C. Generalise the natural experiment from one pair to all shared climates (core, 1–2 days)

- **Question.** In *every* climate that a southern region shares with a northern one, is the southern fauna more obligate?
- **Approach.**
  1. Extend the s13/s18 machinery from Mediterranean-climate pixels to all land pixels.
  2. For each climate stratum occupied by at least two regions, compute standardised obligate shares.
  3. Estimate the south–north difference within strata as a meta-analysis (genus bootstrap), and report how many strata and how much area it covers.
  4. Include Köppen classes as an interpretable layer (savannas: Cerrado vs Africa vs northern Australia; temperate grasslands: Pampas vs Highveld vs steppe).
- **Outcome.** It replaces "Cape vs Basin" with a global, quantitative design; the Mediterranean regions become the illustrative case.

### D. Ant community structure: the reviewers' "colony ecology" (important, 2–3 days; feasibility to confirm)

- **Question.** Is obligacy associated with the dominance of large-colony, trophobiont-tending ants in local communities, rather than with ant richness or the mere presence of partner genera?
- **Data.**
  - The Global Ant Database (GLAD) locality and observation tables are already on disk in the Kass archive (`glad_data/`). They describe sampled local communities (pitfall, bait and other methods), with total abundance and richness per locality. The observation table lists every species at every locality, with its genus, an abundance or occurrence value and the measurement type (e.g. frequency in pitfall traps), so the dominance of partner genera in local communities can be computed. Reading the tables needs the `readxl` package added to the project library.
  - GlobalAnts traits (Parr et al. 2017) for colony size and dominance, if obtainable.
  - Andersen's ant functional groups as a coarse classification of genera (dominant Dolichoderinae, subordinate Camponotini, etc.).
- **Measures.** Per hexagon or region: share of local assemblages, or of records, belonging to dominant, trophobiont-tending genera; and the partner genera's share of local communities.
- **Prediction.** Southern Africa and Australia have higher dominance by such ants (Australian *Iridomyrmex*, African *Anoplolepis* and *Crematogaster*). The Basin has the partner genera, but not dominating.
- **Risk.** GLAD coverage is patchy; if abundance is missing, fall back on functional-group composition of species lists.

### E. Knowledge bias: make it a result, not a caveat (1 day)

- **Question.** Could the southern excess reflect where larvae are reared?
- **Tests.**
  - Obligate share against life-history effort (sources per species, or share of species with direct evidence) within regions.
  - Rarefy southern faunas down to the classification completeness of the Neotropics and tropical Africa.
  - Show that obligacy in well-classified northern regions (Europe, Nearctic: 50%+ classified) is still near zero.

### F. Keep, but demote

- **Dry seasons among close relatives.** Keep as a secondary result (SI or one paragraph); it fits "southern environments", but rests on a few genera.
- **Europe latitudinal gradient.** Keep in SI.
- **LGM stability, soils, fire.** Keep as tested and rejected alternatives.

### G. Drop or defer

Diversification rates (dropped), BiSSE-type models, independent palaeoclimate, Pinkert range-map validation (unless reviewers insist), connectivity analyses. Connectivity becomes relevant only if test B succeeds (isolation of the Americas from the sources of obligate lineages).

## 4. How the paper would be restructured if A–C succeed

- **Title (working):** *Obligate butterfly–ant mutualism evolved repeatedly in the southern continents and rarely spread*.
- **Fig. 1.** Global maps (as now).
- **Fig. 2.** Convergence: the tree with independent origins coloured by region; origin rate per Myr of lineage history by region.
- **Fig. 3.** Same climates, different interactions, globally: south–north contrast within every shared climate stratum (meta-analysis), with the Mediterranean regions highlighted.
- **Fig. 4.** Dependence limits spread: regions per genus against genus age by strategy; held-out realm prediction (lineage works, climate fails).
- **Fig. 5 (optional).** Ant community dominance and obligacy.
- **Discussion.** Southern continents and mutualism intensity (myrmecochory, ant dominance, nutrient-poor landscapes); why lineage composition preserves the pattern; what this means for predicting interactions under climate change (climate niches of interactions do not transfer).

## 5. Results of tests B and C (29 October 2026)

### B. Dependence and spread (`s23_test_dispersal`): supported at the level of lineages

Data: 156 genera on the tree of genera (stem age ≥ 0.5 Myr, at least two recorded species).

- **Places occupied.** At a given stem age and number of species, obligate genera occupy fewer hexagons: log coefficient −0.96, about 2.6 times fewer, p < 0.001. The result holds:
  - within the same main region (−1.00);
  - in a phylogenetic regression on the tree of genera (−0.83, p < 0.001).
- **Regions occupied.** Obligate genera also occupy fewer regions (Poisson −0.72, p = 0.015; with main region −0.78, p = 0.03).
- **Confined to one region.** The effect has the expected sign but is not significant (p = 0.18).
- **Age.** Obligate genera are older (median stem age 24 Myr, against 10 Myr for facultative genera), so their restriction is not because they are young.
- **Species ranges.** Among associated species, obligate species have ranges about 3.5 times smaller given region and lineage (−0.55 log10 km², p < 0.001).
- **Within genera.** In the 12 mixed genera, obligate congeners are *not* smaller (+0.23, permutation p = 0.23). The restriction is a property of obligate lineages, not of each obligate species relative to its facultative relatives.
- **The obligate genera that spread.** Ten obligate genera on the tree occur in more than one region (*Niphanda*, also in two, has no stem age):
  - Aphnaeinae: *Cigaritis* (Africa, Palaearctic, Indomalaya), *Aphnaeus*, *Erikssonia*;
  - *Lepidochrysops* (southern and tropical Africa);
  - *Hypochrysops*, *Liphyra* and *Lucia* (Australia and New Guinea);
  - *Phengaris* (Palaearctic and Indomalaya);
  - Indomalayan *Logania* and *Drupadia*.

  None reached the Americas.

### C. Every pair of regions within shared climates (`s24_compare_all_climates`): supported, with a refinement

Design: standardised obligate share within shared climate strata; 95% genus-bootstrap intervals.

- **Southern Africa vs others.** More obligate than:
  - the Nearctic (+27 points);
  - the Palaearctic (+35);
  - the Neotropics (+9);
  - tropical Africa (+7).

  All four intervals lie above zero. It is not more obligate than Indomalaya (−3) or New Guinea (2 strata only).
- **Australia vs others.** More obligate than the Nearctic (+25), Palaearctic (+29), Neotropics (+21), tropical Africa (+11) and New Guinea (+28), all with intervals above zero; Indomalaya (+12) has an interval just including zero.
- **Southern Africa vs Australia:** alike (+3).
- **Control pairs (14).** No excess above zero; the largest is 9 points. The only clear differences are the Neotropics against the Old World tropics (−8 to −13): the Americas lack obligate species even in climates they share with tropical Africa, Indomalaya and New Guinea.

### What this means for the story

1. **The Cape–Basin result generalises.** In nearly every climate the two southern regions share with another region, they are more obligate. The one exception is southern Africa against Indomalaya, whose shared climates are subtropical and where Indomalaya has its own obligate genera (*Arhopala*, *Logania*).
2. **The geography has three tiers, not two.**
   - Southern Africa and Australia are obligate-rich.
   - The Old World tropics (tropical Africa, Indomalaya, New Guinea) are intermediate.
   - The Holarctic and the Americas are obligate-poor; the Americas hold none at all, even in climates they share with the Old World tropics.

   "Southern" alone is too simple. The pattern is better described as **obligate-rich southern continents within an Old World that holds all obligate lineages**.
3. **Test B supplies the mechanism that links these tiers to lineage history.** Obligate lineages occupy fewer places and fewer regions than others of the same age and size. Those that spread did so between neighbouring Old World regions, and none crossed to the Americas.
4. **Working headline:** *Obligate butterfly–ant mutualism is concentrated in the southern Old World in every climate it shares with other regions, and obligate lineages spread less than their relatives.* Whether obligacy also *arose* more often in the south (convergence, test A) decides whether the paper can claim more than restricted spread.

## 6. Order of work and decision points

1. **Test B pilot with age control (½ day).**
   - Cheap and informative, using the existing genus table and stem ages.
   - Decision: if obligate genera are not less widespread at a given age, drop the dispersal mechanism.
2. **Test C (1–2 days).** Uses existing pipeline; strengthens the paper whatever the outcome.
3. **Test A (2–3 days).**
   - Needs the Kawahara tree (owner to download if scripted access fails); start with the existing Yumnam genus tree.
   - Decision: the convergence reframing goes ahead only if southern origin rates are clearly elevated.
4. **Test E (1 day).** Needed for any version.
5. **Test D (2–3 days).** GLAD holds locality-level community samples with abundances; first check its coverage of the Cape, southern Australia, the Basin and California.
6. **Rewrite** around whichever results hold; keep everything inline and verified as now.

**Needs from the owner:**

- Download of the Kawahara et al. (2023) tree files if Dryad blocks scripted access.
- A view on whether the convergence/dispersal framing is the paper you want.
- Whether the target journal changes if it works.

## 7. Results of tests A, D and E, the fourth review and the audit (29 October 2026)

**A. Convergence (`s25_test_convergence`): suggestive only.**
- Obligacy arose about 2.8 times (pruned Yumnam tree) to 3.9 times (tree of genera) as often per Myr of non-obligate lineage history in southern Africa and Australia as elsewhere; the range over maps stays above 1.
- With so few origins, gains placed at random along the non-obligate history give ratios this high with one-sided p = 0.047 and 0.11. The first null (permuting tip regions) was infeasible: scrambled regions make each region map take more than ten minutes.
- Southern origins are older (median about 21 Myr on the tree of genera, against about 7 Myr in the Holarctic and the Americas).
- Decision: the convergence reframing does **not** go ahead; the paper reports it as exploratory, and restricted spread (test B) stays the lineage-level result.

**D. Local ant communities (`s27_test_ant_communities`): partner genera not more prevalent in the south.**
- *Crematogaster* and *Camponotus* make up about 10% of local ant species in southern Africa, Australia, the Palaearctic and the Nearctic, and more in the Mediterranean Basin than in the Cape.
- Dominance is higher in southern Africa and Australia, but nearly as high in Indomalaya and New Guinea; after adjusting for sampling, only Australia differs from the Palaearctic. Within regions, more dominated communities go with fewer obligate lycaenids.

**E. Knowledge (`s26_test_knowledge`): no bias detected.** The regional ordering survives species-specific evidence, well-classified hexagons and imputation; obligate species have fewer GBIF records than facultative relatives, not more.

**Fourth review (`s28_test_robustness`) and the audit.**
- Flexible climate models (smooths and a temperature–aridity interaction) predict held-out realms and subfamilies no better than linear ones; species-specific evidence changes nothing.
- The Cape–Basin contrast holds with species-specific evidence; southern Australia stays suggestive (lower bounds near zero).
- With each genus weighted once per region and stratum (`s18`), the Cape–Basin contrast falls from 56 to 24 points and the Cape and southern Australia no longer differ: half of the Cape's excess is the species richness of its obligate genera.
- The dry-month association is fragile: not significant for water-deficit months, 8 of 11 genera when each genus counts equally (sign test p = 0.23), and p = 0.09 without *Arhopala*. It is now framed as a hypothesis for close relatives.
- Audit fix: `predict()` gave unseen genera and subfamilies a random effect of zero; `code/R/lineage_prediction.R` now averages over the random-effect distribution. Lineage still wins for held-out realms (deviance explained 52%), but it also overpredicts the Neotropics; its advantage is ranking species within realms, and it depends on knowing the genus (75% for held-out species, 18% for held-out genera).

**Where the paper stands.** Title and direction kept. Figures 2–4 rebuilt (four-strategy comparison with every variant and every region pair; obligacy prediction with spread of genera; environment separated from ants). The text uses "the climate models tested perform poorly", Cape strong and southern Australia suggestive, ants tested at the level of genera and communities, not partner species.

## 8. Follow-ups 7–9 (29 October 2026, evening)

**Dry months used and available (`s29_test_dry_availability`).** Each species' dry months were split into those available (mean over all land in the hexagons of about 210,000 km² holding its records) and its use beyond them. The association with obligate mutualism lies in the use beyond availability (0.93 log odds per SD given region and lineage, p = 0.002; within genera 1.21, p < 0.001; 10 of 11 mixed genera, sign test p = 0.012), not in the dry months available (0.40, p = 0.17). Obligate mutualists occur in the drier parts of the areas they inhabit; only *Hypochrysops* goes the other way. With hexagons three times larger, availability contributes too. The dry-season hypothesis is now more consistent among close relatives, though still a pattern of few genera.

**Colony traits of the partner ants (`s30_test_ant_traits`).** Colony size from Bell-Roberts et al. (2024) covers 91 of the 464 partner species (17 recorded with obligate lycaenids). Within ant genera, obligate partners have colonies about 2.8 times larger (p = 0.10); no difference in polygyny or supercoloniality; genus colony size is unrelated to the obligate share of a genus's partners. Lycaenids whose partners have larger colonies are more often obligate mutualists given region and lineage (p = 0.002), but this rests mostly on genus medians, and the partners of southern Africa's obligate species (*Crematogaster*, median about 700 workers in the database) have smaller typical colonies than those of its facultative species. The ant explanation stays open; it needs colony data for southern partner species.

**Convergence on the Kawahara tree (`s25`).** On a tree of genera from Kawahara et al. (2023) (218 genera matched; 25 of 35 obligate genera), the southern rate of origin is 5.5 times that elsewhere (range over maps 1.2–10.5; p = 0.064), and 4.8 times with secondary calibrations only (p = 0.084). Across all four trees the excess is 2.8–5.5 times with p = 0.05–0.11: consistent in direction and size, still suggestive.

**What the drier places are (`s31_test_dry_habitat`).** Use beyond availability computed for ten properties (dry months, temperature, annual and driest-month precipitation, elevation, NPP, and tree, shrub, herbaceous and cultivated cover from the 1-km consensus land cover of Tuanmu & Jetz 2014). Within genera, obligate mutualists' places have more dry months (1.21 log odds per SD) and less rain in the driest month (−0.79) than their surroundings, but not less annual rain, a different elevation or a different tree cover; the dry-month effect persists with temperature and annual precipitation (1.17) and with tree cover and elevation (1.25) in the model. Mutualists sit where the dry season is longest and harshest within their surroundings, not in warmer, lower, less rainy or more open places. Shrub cover is lower at their places within genera (−0.98, p = 0.007), a side observation.

**Adult flight and the dry season (`s32_test_flight_timing`).** Monthly record counts for every associated species from the GBIF occurrence API (main hemisphere; cached), against the dry months of its record pixels. Across 590 species with at least 20 dated records, the share of records in dry months, or one or two months after them, is unrelated to obligate mutualism given region and lineage (all p ≥ 0.53) or within genera (all p ≥ 0.46). Adult flight is only an indirect guide to larval timing, so this does not test larval protection through the dry season directly.

**Other housekeeping (29 October 2026).** `writing/climate_manuscript.Rmd` was frozen on this date; on 30 October it became the comprehensive working document (Section 10). Table 4 of Pierce et al. (2002) could not be checked (paywalled; the Pierce lab site refuses scripted access); the introduction says obligate associates are "rare or absent" in the Americas until it is checked.

## 9. Independent audit of s23–s32 and the paper (29 October 2026, night)

An independent review (read-only) checked every inline number against the CSVs and found no join, sign or scoping bug. It found:

- **Claims contradicted by our own outputs, now corrected.** The mutualists' drier places are also warmer (as expected, since dry months are defined by temperature) and have less shrub cover within genera. Water-deficit months go with obligate mutualism in phylogenetic regressions, though not given region and lineage. The used-versus-available split depends on hexagon size (at about 630,000 km² both parts contribute). The flight-timing test cannot exclude an effect as large as that of dry months.
- **Kawahara check.** It had dropped 70 genera (7 of them obligate) by keeping only genera on the Yumnam tree; with all 238 genera the southern rate is 2.5 times that elsewhere (95% range over maps 0.7–5.3; p = 0.19). Convergence is now weaker evidence; the text says "not clearly beyond chance".
- **s32.** The dry calendar now uses only record pixels of the species' main hemisphere, matching the GBIF month counts; results unchanged (null).
- **s27.** Dominance and partner abundance share now use only GLAD localities that counted individuals ("Abundance"), not "Abundance/Occurrence" localities, which may count samples. The Cape drops out of the dominance comparison (no such localities); the conclusions hold (Australia more dominated, p = 0.004; within regions, more dominated communities go with fewer obligate lycaenids, p = 0.001).
- **s28.** The lineage model of each held-out realm now estimates its variances in each fold (REML), as in s20; this affects only the lineage points of Fig. S5.7a.
- **Wording.** Table 1 says "consistent (an association, not a test of cause)" for the spread of genera; the conclusions no longer say "because they hold different genera"; captions of Tables S5.9 and S5.10 and Fig. S6.2c corrected (regions are the regions to which a genus's species are assigned).

## 10. Fifth review: confinement, accessible areas, figures and the two documents (30 October 2026)

**Confinement of obligate genera (`s33_test_confinement`).** The confinement holds at 2.0–3.2 times fewer hexagons (all p ≤ 0.021) under other definitions of an obligate genus (any obligate species, three quarters, all, a continuous share), for well-classified genera only, at grains three times finer and coarser, given the occurrence records of each genus, and given subfamily or the spread of the rest of the subfamily. It weakens within Theclinae (1.7 times, p = 0.089), is not detectable within Aphnaeinae (10 genera), and becomes uncertain when each genus's obligate share is redrawn for incomplete classification (2.2 times, p = 0.13, Rubin's rules). Among sister clades on the tree of genera it is not clear (6 of 9 contrasts negative, p = 0.51), and within mixed genera obligate species do not have smaller ranges (s23). The paper calls it "an association, not a test of cause".

**Water availability used and accessible (`s34_test_niche_availability`).** With accessible areas drawn independently (all land within 250 or 500 km of the records) and a sampled background (only pixels with lycaenid records), within the mixed genera: within 500 km of all land, the mutualists' places have more dry months (0.88, p = 0.013), less driest-month rain (0.67, p = 0.012) and more seasonal rainfall (0.90, p = 0.002) than accessible, but not more water-deficit months (p = 0.88) or a more arid climate (p = 0.64). Against the sampled background the dry-month effect is smaller (0.55, p = 0.041), and within 250 km nothing is detectable. The signal is one of seasonal drought rather than aridity.

**Figures (`s22`).** Fig. 2b now states 60% against 4% in its facet labels and the Basin's retention in its subtitle; Fig. 3b shows hexagons adjusted to the mean stem age and recorded species with the model's predictions; Fig. 3c splits held-out realms into species of known and new genera (`s20`: lineage 74% of the deviance for known genera, 34% for new ones, where latitude and hemisphere give 48%); Fig. 4 drops the ant panel (now Appendix S5) and adds the genus contrasts of available and used dry months (c) and the accessible-area tests (d).

**The two documents.** The paper draft is kept focused for GEB. `writing/climate_manuscript.Rmd` is now the comprehensive working document: it runs the paper's setup chunk (so the numbers agree), reports every analysis with the details the paper has cut, and discusses what the results mean: the four explanations for confinement, why colony size and community dominance point in opposite directions, seasonal drought rather than aridity, what makes the south different, and projects beyond the paper (a natural-history review of partner ants with a priority list, trait-dependent range evolution, Riodinidae, larval phenology), the conservative and ambitious framings, and a table of the fifth review's requests and what was done.

## 11. The dry-niche proposal (30 October 2026)

The research proposal *Does obligate ant mutualism favour occupation of seasonally dry environments?* was implemented in `s35_prepare_dry_niche` and `s36_test_dry_niche`.

**Design (fixed before any model was fitted).** Obligate mutualists and facultative species of the mixed genera with at least 20 occupied 10-arc-minute pixels in an accessible area (each realm on each landmass of the glacial shelf, land above -120 m in ETOPO1; Australia and New Guinea apart). Presence-background point-process models (infinitely weighted logistic regression) of dry months given temperature against three backgrounds: GBIF records of all six butterfly families with the focal species' records removed and capped at the 95th percentile (primary), recorded pixels weighted equally, and all land. One estimate per genus (mutualists minus facultative), pooled by random-effects meta-analysis (metafor), with hierarchical and phylogenetic versions, a comparison without background, leave-one-genus-out, other measures, thresholds, areas, 30 arc-minutes, species-specific evidence, overlapping species, and blocked cross-validation. Outcome rules written into s36 in advance. Departures from the proposal: 10-arc-minute pixels rather than 10 km; no GBIF supplementation of the cleaned records; no niche-overlap metrics.

**Result.** 8 genera (9 genus-area contrasts; 47 species-area units). Mutualists exceeded facultative congeners in 5 of 8 genera; pooled 0.80 log relative intensity per SD (95% interval -0.11 to 1.71) against all butterflies, 0.77 and 0.66 under the other backgrounds, 0.65-0.96 leaving out each genus; no genus clear on its own. Pre-specified outcome: **no convincing support** (consistent direction, interval includes zero). Without a background, 0.63 log odds per SD (p = 0.034). Dry months alone 0.95 (0.19-1.71), but given temperature weaker, months below 50 mm (temperature-independent) 0.46 (p = 0.15), temperature alone 1.30 (p = 0.07): the dry-season signal cannot be separated from warmth, and the climatic water deficit gave a difference as large as dry months, so "seasonal drought rather than aridity" is no longer claimed. Blocked CV: dry months improved held-out prediction for 17 of 22 mutualists and 13 of 22 facultative species.

**Paper.** Methods and Results paragraphs added, s34 detail moved to Appendix S5, Fig. 4d now the one-estimate-per-genus figure (s22), Table 1 row and Discussion revised, Tables S5.16-S5.18 and Figures S5.14-S5.16 added, eight verified references added. Main text is now about 7,000 words after version 2 (Introduction to Discussion, without captions and Table 1), above the GEB limit; cutting is left for after co-author comments.

## 12. Dry-niche test, version 2 (30 October 2026)

Version 1 could detect only differences of about 1.3 per SD (80% power). The owner asked for a better-powered design and for dry months alone as the primary measure. Version 2 was declared in `writing/dry_niche_v2_plan.md` before fitting (`s37`): dry months alone primary (post hoc, disclosed), GBIF supplementation of occurrences (own records within 100 km of cleaned ones), one contrast per origin of obligate mutualism (nearest facultative clade on the tree of genera, within a subfamily), and a joint point-process model (`mgcv::bam`) with random slopes of species and origins plus a cluster bootstrap over origins.

**Result.** 89 species-area units, 9 origins (one new: 34 South African Aphnaeinae mutualists of 8 genera against 2 *Axiocerses*). Joint estimate 0.66 per SD (model-based 0.01 to 1.31, p = 0.046; bootstrap over origins -0.05 to 1.83, 97% of resamples positive); 0.57 and 0.48 under the other backgrounds; 0.38-1.48 leaving out each origin; two-stage 0.49 (-0.14 to 1.13), positive in 5 of 9 origins. Declared outcome: **no convincing support**. Supplementation weakened the estimate (joint 1.02 on version 1 data to 0.73), the new origin contrast was 0.00, and given temperature the estimate is 0.45 (p = 0.24). The direction is consistent everywhere; its size is not established and it cannot be separated from warmth.

**Paper.** At the owner's choice, the main text reports version 1 only (Fig. 4d is the per-genus figure of version 1; the pre-specified measure, given temperature, and dry months alone are both reported) and points to Appendix S5 for version 2, which is reported in full there (Table S5.19, Figure S5.17, with the post hoc change of primary measure disclosed).
