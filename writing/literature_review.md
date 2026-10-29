# Climate and the geography of lycaenid ant-interaction strategies: hypotheses from the literature

This document collects the hypotheses that could explain why the four ant-interaction strategies of lycaenid larvae (non-associated, facultative, obligate mutualist, obligate parasite) vary in frequency across the globe, and what each predicts for present and past climate. It synthesises three annotated bibliographies in [`literature/`](literature/), which give the full references with DOIs, what each paper found and which open-access PDFs are in `data/raw/literature/pdfs/`:

- [`bibliography_lycaenid_ant_biogeography.md`](literature/bibliography_lycaenid_ant_biogeography.md): lycaenid and riodinid myrmecophily, the ants involved, ant social parasites and other myrmecophiles (about 105 references)
- [`bibliography_interactions_climate_theory.md`](literature/bibliography_interactions_climate_theory.md): general theory on climate, palaeoclimate and the frequency, specialisation and type of biotic interactions (about 85 references)
- [`bibliography_methods_data.md`](literature/bibliography_methods_data.md): methods, pitfalls and data sources for assemblage- and species-level trait–climate analyses (about 75 references)

The bibliographies were compiled on 28 October 2026 with AI assistance (Claude). Every DOI was matched to its Crossref record and most findings were taken from the abstract or full text, but entries marked "UNVERIFIED", "abstract not read" or "content to verify" must be checked before they are cited. The main ones are Fiedler (1998b, *Zoology* 100: 336–347; the only source is a citation in Pierce & Dankowicz 2022), the content of Buschinger (2009) and Pierce (1987), which was read only through later reviews.

Notation: n = non-associated, f = facultative, m = obligate mutualist, p = obligate parasite; ↑ / ↓ = the proportion of a strategy among classified species rises or falls along the gradient; ∩ = peaks at intermediate values; 0 = no clear prediction.

## The pattern to explain

In the 500-km cells of `butterfly_ant_interactions` (Fig. 1 there), obligate mutualists and parasites are concentrated in southern Africa (the Cape above all) and Australia. They are present at lower frequencies across tropical Africa, the Indo-Malayan region and the Palaearctic, where the parasites are mostly *Phengaris* and its relatives. They are absent from the Americas, where facultative and non-associated species make up the whole recorded fauna. Non-associated species are most frequent in North America and parts of the Palaearctic.

Two framings in the literature compete to explain this. Pierce et al. (2002) and Pierce & Dankowicz (2022) list climate, nutrient-poor soils, aridification and glaciation as possible drivers. Pierce et al. (2002) also note that the southern excess of obligate species partly reflects which lineages live there. To our knowledge, no study has separated these explanations at the global scale, for lycaenids or for any other animal clade with a set of interaction strategies. The closest models are:
- the global analysis of three ant–plant mutualisms (domatia, extrafloral nectaries and elaiosomes; Luo et al. 2023). Their distributions differed among the three types, present temperature and precipitation were the strongest predictors, and the role of ant diversity depended on the type;
- the global analyses of mycorrhizal types (Steidinger et al. 2019) and of cooperative breeding in birds (Jetz & Rubenstein 2011).

For butterflies in general:
- modern climatic seasonality predicts the boundaries of phylogenetic bioregions, whereas climate change since the Last Glacial Maximum marks the deeper boundaries between realms (Gross et al. 2025);
- in *Melitaea*, present and past climate differ in importance between the global and the bioregional scale (Ghasemi et al. 2026).

## Hypotheses

### H1. Cold filter on ant activity (present temperature)

Low temperatures and short seasons reduce ant foraging and the reliability of attendance and lengthen larval development, so myrmecophily should weaken in cold climates. In the western Swiss Alps, myrmecophilous Polyommatinae were more frequent at warm sites and species of the coldest sites had little or no ant association (Pellissier et al. 2012). Ant recruitment and activity rise with temperature (Kaspari et al. 2000; Warchola et al. 2015), and ant richness and abundance peak in warm climates (Dunn et al. 2009; Economo et al. 2018; Schultheiss et al. 2022).

- **Predictions** along increasing temperature (bio01, bio06, growing season): n ↓, f ↑, m ↑. For p, the prediction is weaker: larvae inside ant nests are buffered from the surface climate (Fiedler 2006), so parasites may persist in cool climates, as *Phengaris* does.
- **Complication:** colonies are larger and nests denser in seasonal, cold-winter sites (Kaspari & Vargo 1995), so the cold filter may act on larval development rather than on ant availability.

### H2. Harsh surface: aridity, seasonal drought and fire (present climate; refuge hypothesis)

In seasonally dry, fire-prone biomes, larvae that shelter in ant nests or feed underground escape fire, desiccation and food shortage. This would favour nest-dwelling and parasitic life histories. The idea goes back to Cottrell (1984) and Fiedler, and is invoked by Espeland et al. (2023) for the radiation of *Lepidochrysops* during the aridification of Africa. It is related to the stress-gradient hypothesis, under which positive interactions increase with abiotic stress (Bertness & Callaway 1994; He et al. 2013). The stress-gradient evidence comes almost entirely from plants, and cold cannot strengthen ant mutualisms in the way it strengthens plant facilitation, so the relevant stress axis for ants is drought rather than cold. The fire-refuge idea has not been tested directly. The only field study found that prescribed fire killed larvae in the short term, while ant tending and larval survival increased afterwards (Warchola et al. 2015).

- **Predictions** along increasing aridity (low P/PET), precipitation seasonality and fire frequency: p ↑↑, m ↑ (especially nest-associated mutualists), f ↓, n ↓. A hump (∩) is possible for m, as in semi-arid peaks of facilitation.

### H3. Nutrient-poor soils and carbohydrate-based ant dominance (soils, correlated with climate)

On old, phosphorus-poor soils, plants produce excess carbohydrates (extrafloral nectar and sap feeding honeydew producers). This supports abundant, dominant sugar-feeding ants and makes lycaenid secretions profitable and ant partners predictable. The hypothesis combines Pierce (1987) as summarised by Pierce & Dankowicz (2022), Orians & Milewski (2007), Davidson et al. (2003) and Hopper (2009, old climatically buffered infertile landscapes). The same two hot spots, south-western Australia and the Cape, dominate seed dispersal by ants (Lengyel et al. 2009/2010), a striking convergence with the obligate lycaenids. Sodium and phosphorus limitation of ants (Kaspari et al. 2008) gives a related prediction: where these nutrients are scarce, ants value nutrient-rich partners more.

- **Predictions** along soil infertility: m ↑, p ↑ (parasitism arises from dense mutualisms; Fiedler 2012), f ↓, n ↓.
- **Test:** this is not a climate hypothesis, but it is the main rival explanation of the Cape–Australia pattern and is correlated with aridity and fire. It needs a soil layer (SoilGrids or a global soil phosphorus map).
- **Caveat:** myrmecochory is also frequent in Holarctic deciduous forests (Lengyel et al. 2009), so it is not a clean proxy for infertility.

### H4. Hot, open habitats with dominant ants

Obligate associations need large, long-lived, predictable colonies of dominant ants (*Iridomyrmex*, *Anonychomyrma*, *Crematogaster*, *Oecophylla*, *Anoplolepis*, *Camponotus*). These peak in hot, open, seasonally dry savanna, woodland and shrubland (Andersen 1995; Eastwood & Fraser 1999; Fiedler 2001, 2021).

- **Predictions** along temperature, insolation and openness (low tree cover): m ↑, p ↑, f flat or ↓, n ↓.
- **Complication:** Australian facultative species associate with dominant ants less often than expected (Eastwood & Fraser 1999), so dominance may matter only for obligate species.

### H5. Productivity and the mutualism–parasitism continuum

The benefits of mutualism tend to fall as environmental quality rises (Thrall et al. 2007; Chamberlain et al. 2014). Obligate mutualism should then be favoured in poor environments, and interactions in rich ones should drift towards facultative use or exploitation.

- **Predictions** along NPP: m ↓, f ↑, and p rises relative to m.
- **Observed:** the first exploration found the opposite for the parasite share of obligate species, which fell with NPP and precipitation. This mostly reflects the dry Cape.

### H6. Quaternary climate stability and partner tracking (past climate)

Large glacial–interglacial range shifts favour generalists with good dispersal and select against specialisation; specialists persist in stable regions (orbitally forced range dynamics; Dynesius & Jansson 2000; Jansson 2003). Climate-change velocity since the Last Glacial Maximum predicts endemism (Sandel et al. 2011) and the specialisation of hummingbird–plant networks (Dalsgaard et al. 2011) and related patterns (Sonne et al. 2016; Ordonez & Svenning 2017).

For obligate lycaenids, the problem may be sharper: a population can persist only where its host plant and a compatible ant colony both track the climate. Obligate species are also genetically structured and weak dispersers (Schär et al. 2018). Partner dependence is known to constrain ranges (Stephan et al. 2021; Fowler et al. 2023), and in `butterfly_ant_interactions` parasites had the smallest ranges.

- **Predictions** along LGM anomaly, velocity and 800-kyr variability: n ↑, f ↑, m ↓, p ↓↓.
- **Counter-evidence:**
  - Mutualist network specialisation was better explained by present climate than by past stability in a larger global dataset (Schleuning et al. 2012).
  - In the Southern Hemisphere, glacial *aridity* fragmented ranges and may have promoted speciation of ants (Andersen 2016) and of *Chrysoritis* (Talavera et al. 2020). The temperature and precipitation anomalies should therefore be tested separately, and their effect may differ between realms.
  - Palaearctic *Phengaris* lives in a high-velocity, once-glaciated region.

### H7. Deep-time aridification and the Neogene legacy

Obligate associations radiated as Australia and Africa aridified in the Miocene and Pliocene, for example *Lepidochrysops* from about 6.5 million years ago (Espeland et al. 2023). Cenozoic cooling caused extinctions in the north (Dunn et al. 2009).

- **Predictions:** m ↑ and p ↑ where open arid or sclerophyll biomes are old (Southern Hemisphere, the Cape). Once realm and the age of the biome are included, present climate should explain little.
- **Testability:** global deep-time climate layers are coarse. `pastclim` offers the 5-Myr PALEO-PGEM emulator (Barreto et al. 2023), which this study has not downloaded yet. In practice the hypothesis is tested through realm and lineage terms and through dated phylogenies.

### H8. Lineage history, dispersal barriers and niche conservatism (the null)

Obligate-rich clades (Aphnaeinae, Miletinae, *Lepidochrysops*, Australian Theclinae and Polyommatini) are confined to the Old World and the southern continents. Only facultative or non-associated lineages, such as Lycaeninae, Theclini, Eumaeini and some Polyommatini, crossed Beringia or the Atlantic into the Holarctic and the New World (Vila et al. 2011; Kawahara et al. 2023). In the Neotropics, myrmecophily is carried largely by Riodinidae, which this dataset does not include (DeVries 1991; Campbell & Pierce 2003; Kaminski et al. 2010). Under tropical niche conservatism (Wiens & Donoghue 2004), clades keep their climates, so climate and lineage are collinear.

- **Predictions:** strategy proportions follow realm and clade composition, and climate effects within lineages (or after phylogenetic correction) are close to zero.
- **Role in the analysis:** this is the essential null, and the main competitor of every climate hypothesis.

### H9. The partner-ant pool (climate acting through ants)

Climate may act through the richness, abundance, dominance and composition of ants rather than directly (Fiedler 2001, 2012, 2021).

- **Predictions:**
  - f ↑ with the abundance of ants that tend honeydew producers.
  - m ↑ with dominant partner genera.
  - p ↑ with *Camponotus*, *Crematogaster* and *Myrmica*, and with the local share of mutualists (parasites arise in ant genera that already host many mutualists).
  - In the Neotropics, the dominance of leaf-cutter and army ants, which never tend honeydew producers, should lower m and p (Fiedler 2021).
- **Test:** a mediation analysis with ant richness from the stacked known ranges of Kass et al. (2022; Dryad, CC0), and genus-level richness built from their per-species ranges.
- **Pitfall:** their random-forest "undiscovered" richness surface is predicted from climate and would be circular.
- **Puzzle:** ant richness is high in the Neotropics, where obligate lycaenids are absent, so ant composition must matter more than richness.

### H10. Nitrogen-rich host plants

Protein-rich food (legumes and other nitrogen fixers) lets larvae produce nutritious secretions, and myrmecophily is associated with legume feeding (Pierce 1985; Fiedler 1995, 1996). Comparative evidence is weaker than this suggests. Lycaenids used nitrogen-rich host plants consistently with an exaptation for myrmecophily, but non-myrmecophilous Pieridae preferred them too, and parasites that feed on ant brood colonised nitrogen-poor host plants (Pellissier et al. 2012b, *J. Evol. Biol.*).

- **Predictions** along the share of legumes or nitrogen fixers: f ↑, m ↑, n ↓; p is neutral.
- **Caveats:** host-plant data are needed, and legume dominance is confounded with aridity and lineage.

### H11. Analogues from other parasites and cooperators

- **Ant social parasites** show an inverse latitudinal gradient, with most species in the cool-temperate Northern Hemisphere (Buschinger 2009; Gray & Rabeling 2023). This fits Palaearctic *Phengaris* but not the warm, arid southern African centre of lycaenid parasitism.
- **Parasitism of other kinds** increases towards the poles in a meta-analysis (Zvereva & Kozlov 2021).
- **Unpredictable climates** are associated with cooperative breeding (Jetz & Rubenstein 2011) and with brood parasitism (Antonson et al. 2020). In cooperative breeders, the strategy evolved in benign climates and then let lineages colonise harsh ones (Cornwallis et al. 2017). A strategy–climate correlation can therefore arise because the strategy enables colonisation, not because the climate selects for it.
- **Predictions** (weak): p ↑ towards cool, seasonal climates (H11a); m ↑ with interannual rainfall variability (H11b).
- **Value to this study:** these analogues mainly warn against causal readings and show the need for phylogenetic tests of the order of transitions.

### H12. Latitudinal gradient in biotic interactions

Interactions, including predation by ants, are thought to be stronger in the tropics (Dobzhansky 1950; Schemske et al. 2009). Predation on dummy caterpillars rises towards the equator (Roslin et al. 2017), so ant protection may matter more there. The generality of the idea is disputed (Moles & Ollerton 2016), and mutualist networks are, if anything, *less* specialised in the tropics (Schleuning et al. 2012).

- **Predictions** along latitude (lower), temperature and NPP: n ↓, f ↑; little effect on m and p.
- **Fit to the data:** this probably explains facultative against non-associated better than obligacy, which peaks at mid-latitudes in the south.

## Summary of predictions

| Hypothesis | Main variables | n | f | m | p |
|---|---|---|---|---|---|
| H1 Cold filter | bio01, bio06, growing season | ↓ warm | ↑ warm | ↑ warm | 0 / weak |
| H2 Harsh surface (aridity, drought, fire) | aridity index, bio15, fire | ↓ | ↓ | ↑ or ∩ | ↑↑ |
| H3 Nutrient-poor soils | soil P, Na | ↓ | ↓ | ↑ | ↑ |
| H4 Hot open habitats, dominant ants | bio05, radiation, tree cover | ↓ | 0 / ↓ | ↑ | ↑ |
| H5 Productivity–benefit | NPP | 0 | ↑ | ↓ | ↑ relative to m |
| H6 Quaternary stability | LGM anomaly, velocity, 800-kyr SD | ↑ unstable | ↑ unstable | ↓ unstable | ↓↓ unstable |
| H7 Deep-time aridification | realm, biome age | ↓ south | 0 | ↑ south | ↑ south |
| H8 Lineage history (null) | realm, phylogeny | lineage | lineage | lineage | lineage |
| H9 Partner-ant pool | ant richness, genus richness | ↓ | ↑ | ↑ | ↑ (*Myrmica*, *Camponotus*) |
| H10 Nitrogen-rich hosts | legume share | ↓ | ↑ | ↑ | 0 |
| H11 Parasite/cooperator analogues | latitude, rainfall variability | ↑ cool | ↓ cool | ↑ variable | ↑ cool |
| H12 Latitudinal interaction gradient | latitude, MAT, NPP | ↓ tropics | ↑ tropics | 0 | 0 |

## What the hypotheses imply for the design

1. **Climate and lineage are collinear by expectation** (H7, H8). The analysis must therefore estimate climate associations *within* lineages (phylogenetic models; within-genus contrasts) as well as among cells, and report the variation shared by climate and lineage or space as shared rather than assigning it to either (Desdevises et al. 2003; Jetz & Rubenstein 2011).
2. **Present and past climate are collinear.** LGM temperature anomaly and 800-kyr temperature variability correlate at 0.97 among cells, and both correlate with temperature seasonality. Past-climate hypotheses (H6) need contrasts in which these separate: southern against northern realms, temperature against precipitation anomalies, and within-realm analyses.
3. **The Americas are a natural test.** Climates similar to those of the obligate-rich Cape and south-western Australia exist in California, central Chile and south-eastern South America, yet no obligate lycaenids are recorded there. The five Mediterranean-climate regions offer a matched comparison of climate against history (H2, H3 and H6 against H8).
4. **Several hypotheses need non-climate layers:** soils (H3), fire and tree cover (H2, H4), ant richness and composition (H9) and host plants (H10). Climate-only models cannot separate them, and each should be framed as a covariate or mediator rather than as climate.
5. **Cell-level variance explained is inflated** by species shared among cells (Hawkins et al. 2017) and by spatial autocorrelation. It must be calibrated with label-shuffle and phylogenetically constrained nulls, and supported by spatially blocked prediction (Roberts et al. 2017) and species-level models.
