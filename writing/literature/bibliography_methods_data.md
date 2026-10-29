# Literature survey: methods, pitfalls and data for "present vs past climate vs space vs lineage" in lycaenid ant-interaction strategy proportions

Compiled 2026-10-28. Theme: statistical methods, pitfalls and data sources.

**How references were checked**
- **VERIFIED** means the DOI, authors, year, journal, volume and pages were matched against the Crossref API (or DataCite for the Myrmecological News DOI) in this session.
- Content notes come from the abstract (Semantic Scholar or OpenAlex), or from the full text where a PDF was downloaded and read. Entries marked *(abstract not read)* are summarised from prior knowledge and should be checked before citing.
- **PDF** gives the filename in `lycaenidae_ant_climate/data/raw/literature/pdfs/`. "paywalled" means no legal open-access copy was found. "OA, scripted download blocked" means a legal open-access copy exists but Cloudflare or Anubis blocked curl.
- Year = issue year. Online-first years differ for several papers and are noted.

**Corrections to the brief**
- Barreto et al. 2023 (PALEO-PGEM-Series) is in *Global Ecology and Biogeography*, not *Scientific Data*.
- Owens & Guralnick 2019 (climateStability) is in *Biodiversity Informatics* 14, not *Frontiers of Biogeography*.
- Freckleton & Jetz is *Proc. R. Soc. B* 276 (2009). It was published online in 2008.
- Kissling & Carl is *GEB* 17 (2008). It was published online in 2007.
- Miller, Damschen & Ives is *MEE* 10 (2019). It was published online in 2018.
- The CATS paper is Warton, Shipley & Hastie 2015, *MEE* 6.
- "Duarte et al. phylogenetic fuzzy weighting" = Pillar & Duarte 2010 (*Ecol. Lett.*) plus Duarte et al. 2016 (*MEE*).
- "Diniz-Filho et al. 2012 PSR" = Diniz-Filho, Rangel, Santos & Bini 2012, *Evolution* 66.
- VoCC is **not on CRAN**. It installs from GitHub (JorGarMol/VoCC, AGPL-3).
- antmaps.org now says (Dec 2023) to use Kass et al. 2022 (native ants) and Wong et al. 2023 (alien ants) instead of the antmaps.org data.
- Schultheiss et al. 2022 **removed sampling coordinates** from the public data.

---

## A. Pitfalls of assemblage-level (grid-cell) trait–environment analyses

**A1. Hawkins, B. A., Leroy, B., Rodríguez, M. Á., Singer, A., Vilela, B., Villalobos, F., Wang, X. & Zelený, D. (2017).** Structural bias in aggregated species-level variables driven by repeated species co-occurrences: a pervasive problem in community and assemblage data. *Journal of Biogeography* 44, 1199–1211. https://doi.org/10.1111/jbi.12953 — **VERIFIED**
- **What it shows:** The authors assigned random numbers to species ("random intrinsic variables") and averaged them within assemblages. These random averages explained moderate to large shares of variance in bird and tree richness. Regression trees, GWR and SAR were very sensitive; GAMs were moderately sensitive; OLS was less sensitive. The variance explained grew with species co-occurrence. Range cohesion, a richness gradient and spatial autocorrelation in predictors had little effect. The bias persisted when the response was also a random intrinsic variable.
- **Conclusion:** Models and maps built on aggregated species values should not be taken at face value.
- **Application:** Our cell proportions are aggregated species attributes, and the same species recur in many neighbouring 500-km cells. Any cell-level R² for climate is therefore inflated by shared composition. Build a "random-label" null for every cell-level R² by shuffling strategies among species while keeping ranges fixed (see Design).
- **PDF:** OA (HAL hal-03334333, submitted version); scripted download blocked by Anubis. An earlier mis-named download turned out to be a different preprint and was deleted.

**A2. Peres-Neto, P. R., Dray, S. & ter Braak, C. J. F. (2017).** Linking trait variation to the environment: critical issues with community-weighted mean correlation resolved by the fourth-corner approach. *Ecography* 40, 806–816. https://doi.org/10.1111/ecog.02302 — **VERIFIED**
- **What it shows:** CWM correlation and species-niche-centroid (SNC) correlation give inconsistent parameter estimates. They also give unacceptable significance rates when only environment, or only traits, structure distributions without being linked to each other.
- **Recommendation:** Replace both with the Chessel fourth-corner correlation (fourth-corner divided by its maximum attainable value), tested by the combined row/column ("max") permutation test. The paper also gives a framework that partitions trait variation among and within communities.
- **Application:** A cell proportion of a strategy is a CWM of a 0/1 trait. Report the fourth-corner or max test alongside any CWM-type regression. `ade4::fourthcorner` with `modeltype = 6` gives the max test.
- **PDF:** OA (WUR repository, accepted version); not downloaded (no direct PDF link).

**A3. Zelený, D. & Schaffers, A. P. (2012).** Too good to be true: pitfalls of using mean Ellenberg indicator values in vegetation analyses. *Journal of Vegetation Science* 23, 419–431. https://doi.org/10.1111/j.1654-1103.2011.01366.x — **VERIFIED**
- **What it shows:** Weighted means of species values inherit compositional similarity, so mean values correlate spuriously with anything else derived from composition.
- **Method introduced:** "Mean randomized" values: weighted means of species values that have been permuted among species. This leads to a modified permutation test.
- **Application:** This is the origin of the modified (column/species-permutation) test. Shuffle strategy labels among species while keeping ranges.
- **PDF:** OA at WUR; not downloaded.

**A4. Zelený, D. (2018).** Which results of the standard test for community-weighted mean approach are too optimistic? *Journal of Vegetation Science* 29, 953–966. https://doi.org/10.1111/jvs.12688 — **VERIFIED**
- **What it shows:** Hypotheses fall into three classes. For Category B (a link between composition and sample attributes) and Category C (no assumed link), the standard CWM test has inflated Type I error.
- **What drives the inflation:** It decreases as compositional β-diversity rises. It increases with the strength of the composition–environment relationship and with sample size.
- **Remedy:** Use the modified permutation test or the max test.
- **Application:** Our design has low β-diversity among neighbouring 500-km cells and strongly environment-structured composition, which is the worst case. Use the max test.
- **PDF:** `zeleny_2018_cwm_test.pdf` (bioRxiv preprint 10.1101/349589).

**A5. ter Braak, C. J. F., Peres-Neto, P. R. & Dray, S. (2018).** Simple parametric tests for trait–environment association. *Journal of Vegetation Science* 29, 801–811. https://doi.org/10.1111/jvs.12666 — **VERIFIED**
- **What it proposes:** A fast parametric alternative to the permutation tests. Run two regressions: the CWM regression (plot level), and the SNC regression of each species' environmental mean on its trait (species level). Take the maximum of the two p-values.
- **Application:** This is the cheapest valid test of "strategy ~ climate" in our data. Regress cell proportion on climate, and regress each species' range-mean climate on its strategy. Report max(p).
- **PDF:** OA at publisher (hybrid); scripted download blocked.

**A6. ter Braak, C. J. F. (2017).** Fourth-corner correlation is a score test statistic in a log-linear trait–environment model that is useful in permutation testing. *Environmental and Ecological Statistics* 24, 219–242. https://doi.org/10.1007/s10651-017-0368-0 — **VERIFIED**
- **What it shows:** The squared fourth-corner correlation times the total count is the score statistic for the trait × environment interaction in a Poisson log-linear model with species and site main effects.
- **What it recommends:** Under overdispersion, or with unobserved traits or environment, use row- and column-based permutation (sequential or max).
- **Application:** This links the fourth-corner test to the GLMM formulation in A9.
- **PDF:** paywalled.

**A7. ter Braak, C. J. F., Peres-Neto, P. R. & Dray, S. (2017).** A critical issue in model-based inference for studying trait-based community assembly and a solution. *PeerJ* 5, e2885. https://doi.org/10.7717/peerj.2885 — **VERIFIED** (Crossref) *(abstract not read)*
- **Content:** Model-based trait–environment GLMs without species random effects can have inflated Type I error. Adding random species effects for the environment slope, or using permutation, fixes this.
- **PDF:** OA (PeerJ); not downloaded.

**A8. Miller, J. E. D., Damschen, E. I. & Ives, A. R. (2019).** Functional traits and community composition: a comparison among community-weighted means, weighted correlations, and multilevel models. *Methods in Ecology and Evolution* 10, 415–425. https://doi.org/10.1111/2041-210x.13119 — **VERIFIED**
- **What it shows:** CWM regression gave inflated Type I errors in some simulations. Weighted correlations (fourth-corner family) with permutation had good Type I control but low power.
- **Best performer:** The Jamil et al. (2013) multilevel model, with a parametric-bootstrap LRT, or a conditional LRT when species abundances are correlated.
- **Conclusion:** No single method is best. Use weighted correlations for simple single-trait tests and multilevel models for multivariate fitting.
- **Application:** Supports the species × cell GLMM (presence of species *i* in cell *j*, strategy × climate interaction) or a species-level model as the main inference, with CWM regression kept for display only.
- **PDF:** `miller_2019_cwm_multilevel.pdf` (bioRxiv preprint 10.1101/183442, titled "...multilevel models outperform community-weighted means").

**A9. Jamil, T., Ozinga, W. A., Kleyer, M. & ter Braak, C. J. F. (2013).** Selecting traits that explain species–environment relationships: a generalized linear mixed model approach. *Journal of Vegetation Science* 24, 988–1000. https://doi.org/10.1111/j.1654-1103.2012.12036.x — **VERIFIED**
- **Method:** A GLMM on a sites × species table with sites and species as random factors. Trait × environment interactions are the fixed effects of interest. Works for presence–absence, count and multinomial data.
- **Application:** Fit the occupancy of 1,356 species × N cells with strategy × climate interactions. Its phylogenetic version is A12/A13.
- **PDF:** paywalled.

**A10. Warton, D. I., Shipley, B. & Hastie, T. (2015).** CATS regression – a model-based approach to studying trait-based community assembly. *Methods in Ecology and Evolution* 6, 389–398. https://doi.org/10.1111/2041-210x.12280 — **VERIFIED**
- **What it shows:** Maximum-entropy CATS is equivalent to a Poisson GLM of abundance with traits as predictors. Overdispersion must be checked (negative binomial). Design-based inference is needed for multisite data.
- **Application:** Background for treating cell counts per strategy with count GLMs.
- **PDF:** OA at publisher; scripted download blocked.

**A11. Warton, D. I., Blanchet, F. G., O'Hara, R. B., Ovaskainen, O., Taskinen, S., Walker, S. C. & Hui, F. K. C. (2015).** So many variables: joint modeling in community ecology. *Trends in Ecology & Evolution* 30, 766–779. https://doi.org/10.1016/j.tree.2015.09.007 — **VERIFIED** *(abstract not read)*
- **Content:** Review arguing for joint species distribution models (JSDMs) over separate or aggregated analyses, because they account for species correlation and allow trait and phylogeny hierarchies.
- **Related:** Ovaskainen et al. 2017 (HMSC; https://doi.org/10.1111/ele.12757, **VERIFIED**) implements a JSDM with traits, phylogeny and spatial latent factors. Hmsc 3.3-7 is on CRAN. HMSC variance partitioning splits explained variance among fixed-effect groups and random/spatial levels. That is an alternative way to split "present climate / past climate / space" at species level, with traits and phylogeny in the hierarchy.
- **Caveat:** With about 1,356 species × several hundred cells, HMSC is computationally heavy but feasible with GPU/HMSC-HPC.
- **PDF:** paywalled.

**A12. Olalla-Tárraga, M. Á., Bini, L. M., Diniz-Filho, J. A. F. & Rodríguez, M. Á. (2010).** Cross-species and assemblage-based approaches to Bergmann's rule and the biogeography of body size in *Plethodon* salamanders of eastern North America. *Ecography* 33, 362–368. https://doi.org/10.1111/j.1600-0587.2010.06244.x — **VERIFIED**
- **Content:** Contrasts the species-level (cross-species) and assemblage-level views of the same trait–climate relationship. They can disagree, so both should be reported.
- **Related:** Olalla-Tárraga et al. 2006, *J. Biogeogr.* 33, 781–793 (https://doi.org/10.1111/j.1365-2699.2006.01435.x, **VERIFIED**) is the assemblage-based body-size example.
- **Application:** Justifies running the analysis at both the species and the cell level.
- **PDF:** paywalled.

**A13. Gouveia, S. F., Hortal, J., Cassemiro, F. A. S., Rangel, T. F. & Diniz-Filho, J. A. F. (2013).** Nonstationary effects of productivity, seasonality, and historical climate changes on global amphibian diversity. *Ecography* 36, 104–113. https://doi.org/10.1111/j.1600-0587.2012.07553.x — **VERIFIED**
- **Content:** Compared OLS, spatial eigenvector mapping and partial GWR for global richness against productivity, seasonality and historical climate (LGM) predictors. Relationships were spatially nonstationary, and collinearity left large unexplained or shared fractions.
- **Application:** Collinearity between present and past climate will produce large shared fractions. Consider a realm-interaction or nonstationarity check, but avoid GWR as a main model (A1 shows GWR is very sensitive to structural bias).
- **PDF:** paywalled.

**A14. Hawkins, B. A. (2012).** Eight (and a half) deadly sins of spatial analysis. *Journal of Biogeography* 39, 1–9. https://doi.org/10.1111/j.1365-2699.2011.02637.x — **VERIFIED**
- **Content:** Critiques common assumptions in spatial-autocorrelation practice, for example that spatial models are always "better" or that coefficient shifts imply bias.
- **Counterpoint:** Kühn & Dormann 2012, *J. Biogeogr.* 39, 995–998 (https://doi.org/10.1111/j.1365-2699.2012.02707.x, **VERIFIED**).
- **Application:** Cite both when justifying the choice of spatial model, to pre-empt either side of the debate.
- **PDF:** paywalled.

---

## B. Species-level and phylogenetic model-based approaches

**B1. Ives, A. R. & Garland, T. Jr. (2010).** Phylogenetic logistic regression for binary dependent variables. *Systematic Biology* 59, 9–26. https://doi.org/10.1093/sysbio/syp074 — **VERIFIED**
- **Content:** A logistic regression in which a binary trait switches 0↔1 along the tree. It estimates phylogenetic signal (α). Standard logistic regression inflates Type I error when traits are phylogenetically correlated.
- **Application:** Fit three nested binary contrasts with `phylolm::phyloglm` (method "logistic_MPLE"; also "logistic_IG10"): ant-associated vs not; obligate vs facultative among ant-associated; parasite vs mutualist among obligates. Predictors are species' range-mean present climate, LGM anomaly and velocity.
- **PDF:** paywalled.

**B2. Ho, L. S. T. & Ané, C. (2014).** A linear-time algorithm for Gaussian and non-Gaussian trait evolution models. *Systematic Biology* 63, 397–408. https://doi.org/10.1093/sysbio/syu005 — **VERIFIED**
- **Content:** The phylolm algorithm. It gives linear-time likelihoods for PGLS (λ, κ, δ, OU), phylogenetic logistic and phylogenetic Poisson regression.
- **Application:** phylolm 2.6.5 is on CRAN (2024-09-30). It is fast enough to refit thousands of times for null models and for many posterior trees.
- **PDF:** paywalled.

**B3. Hadfield, J. D. (2010).** MCMC methods for multi-response generalized linear mixed models: the MCMCglmm R package. *Journal of Statistical Software* 33(2). https://doi.org/10.18637/jss.v033.i02 — **VERIFIED**
- **Content:** Supports `family = "categorical"` (multinomial logit with K−1 latent traits) and phylogenetic random effects through `ginverse`.
- **Application:** A single phylogenetic multinomial model of the four strategies. The latent-scale phylogenetic variance gives "heritability", which is the lineage share. MCMCglmm 2.36 is on CRAN.
- **Caveats:** The residual variance must be fixed for categorical models. Priors on the K−1 covariance matter.
- **PDF:** OA (JSS); not downloaded.

**B4. Bürkner, P.-C. (2017).** brms: An R package for Bayesian multilevel models using Stan. *Journal of Statistical Software* 80(1). https://doi.org/10.18637/jss.v080.i01 — **VERIFIED**
- **Families confirmed in the brms reference page:** `categorical`, `multinomial`, `dirichlet_multinomial`, `dirichlet` and `logistic_normal`.
- **Application, species level:** `categorical` with `(1 | gr(species, cov = A))` for phylogeny.
- **Application, cell level:** `multinomial` or `dirichlet_multinomial` on counts per strategy per cell, with spatial `gp()` or `car()` terms.
- brms 2.23.0 is on CRAN.
- **PDF:** OA (JSS); not downloaded.

**B5. Ives, A. R. & Helmus, M. R. (2011).** Generalized linear mixed models for phylogenetic analyses of community structure. *Ecological Monographs* 81, 511–525. https://doi.org/10.1890/10-1264.1 — **VERIFIED**
- **Content:** PGLMMs for presence/absence across communities. One model tests trait-based variation in species' sensitivities to environmental gradients. Another tests whether traits explain all phylogenetic variation in occurrence (no phylogenetic residual). Occurrence variation can be partitioned into phylogenetic and site components.
- **Application:** The species × cell occupancy model `occ ~ strategy × climate + (1|sp__) + (climate|sp__) + (1|cell)` tests whether strategy modifies the climate response, with phylogeny on species effects.
- **PDF:** paywalled.

**B6. Li, D., Dinnage, R., Nell, L. A., Helmus, M. R. & Ives, A. R. (2020).** phyr: An R package for phylogenetic species-distribution modelling in ecological communities. *Methods in Ecology and Evolution* 11, 1455–1463. https://doi.org/10.1111/2041-210x.13471 — **VERIFIED**
- **Content (read):** `pglmm()` fits Gaussian, binomial and Poisson PGLMMs.
  - It accepts phylogenetic and spatial covariance matrices through `cov_ranef = list(sp = phy, site = V.space)`.
  - The nested term `(1|sp__@site)` captures phylogenetic attraction or repulsion.
  - Bayesian fitting via INLA is recommended for large data. Frequentist fitting uses quasi-likelihood with Wald tests.
  - `pglmm_compare()` handles one-row-per-species comparative data.
- **Application:** Fit both the species-level binary contrasts and the species × cell model with a site covariance built from cell distances. phyr 1.1.3 is on CRAN.
- **PDF:** `li_2020_phyr.pdf` (bioRxiv preprint).

**B7. Ives, A. R. (2019).** R²s for correlated data: phylogenetic models, LMMs, and GLMMs. *Systematic Biology* 68, 234–251. https://doi.org/10.1093/sysbio/syy060 — **VERIFIED**
- **Content (read):** Three R²s for correlated data: R²_ls, R²_ce and R²_lr. They are partial R²s, so the contributions of fixed effects (climate) and covariance components (phylogeny) can be compared.
- **Implementation:** rr2 (Ives & Li 2018, *JOSS* 3, 1028, https://doi.org/10.21105/joss.01028, **VERIFIED**; CRAN 1.1.1) works with phylolm, phyloglm, pglmm, lme4 and glmmTMB.
- **Application:** The species-level answer to "how much is present climate vs past climate vs lineage". Use partial R²_lik(full | reduced) for each block, e.g. full vs drop-present-climate and full vs drop-phylogeny (α → ∞).
- **PDF:** `ives_2019_r2_correlated.pdf` (bioRxiv preprint).

**B8. Nakagawa, S. & Schielzeth, H. (2013).** A general and simple method for obtaining R² from generalized linear mixed-effects models. *Methods in Ecology and Evolution* 4, 133–142. https://doi.org/10.1111/j.2041-210x.2012.00261.x — **VERIFIED** *(abstract not read)*
- **Content:** Marginal and conditional R² for GLMMs.
- **Application:** Use for the brms or MCMCglmm models. The latent-scale variance decomposition gives the climate vs phylogenetic-random-effect share.
- **PDF:** OA; not downloaded.

**B9. Freckleton, R. P. & Jetz, W. (2009).** Space versus phylogeny: disentangling phylogenetic and spatial signals in comparative data. *Proceedings of the Royal Society B* 276, 21–30. https://doi.org/10.1098/rspb.2008.0905 — **VERIFIED**
- **Content (read):** Modifies independent-contrast variances to include both phylogenetic and spatial effects. A single parameter (φ) gives the relative weight of space versus phylogeny. Body mass was phylogenetic, environmental temperature was spatial, and range size was mixed.
- **Application:** The species-level analogue of "space vs lineage". It can be emulated by fitting a GLS or PGLMM with a phylogenetic covariance V_p and a spatial covariance V_s between species range centroids (or range-overlap matrices), then estimating their weights.
- **PDF:** `freckleton_2009_space_phylogeny.pdf` (PMC).

---

## C. Phylogenetic decomposition of trait–environment patterns

**C1. Diniz-Filho, J. A. F., de Sant'Ana, C. E. R. & Bini, L. M. (1998).** An eigenvector method for estimating phylogenetic inertia. *Evolution* 52, 1247–1262. https://doi.org/10.1111/j.1558-5646.1998.tb02006.x — **VERIFIED**
- **Content:** PVR: run a PCoA of phylogenetic distances and regress the trait on the selected eigenvectors. Fitted values are the "phylogenetic component" (P) and residuals the "specific component" (S).
- **PDF:** paywalled.

**C2. Diniz-Filho, J. A. F., Rangel, T. F., Santos, T. & Bini, L. M. (2012).** Exploring patterns of interspecific variation in quantitative traits using sequential phylogenetic eigenvector regressions. *Evolution* 66, 1079–1090. https://doi.org/10.1111/j.1558-5646.2011.01499.x — **VERIFIED**
- **Content:** The PSR curve plots PVR R² against accumulated eigenvalues. It is linear under Brownian motion, and the PSR area correlates with Blomberg's K.
- **Software:** PVR 0.3 on CRAN (2018, old).
- **PDF:** paywalled.

**C3. Diniz-Filho, J. A. F., Bini, L. M., Rangel, T. F., Morales-Castilla, I., Olalla-Tárraga, M. Á., Rodríguez, M. Á. & Hawkins, B. A. (2012).** On the selection of phylogenetic eigenvectors for ecological analyses. *Ecography* 35, 239–249. https://doi.org/10.1111/j.1600-0587.2011.06949.x — **VERIFIED**
- **Content:** Compares selection criteria for PVR eigenvectors (sequential, significant-correlation, stepwise, minimising residual phylogenetic autocorrelation). The criterion changes the mapped "specific component".
- **PDF:** OA at the UAH repository (ebuah.uah.es); not downloaded.

**C4. Diniz-Filho, J. A. F., Bini, L. M., Rodríguez, M. Á., Rangel, T. F. L. V. B. & Hawkins, B. A. (2007).** Seeing the forest for the trees: partitioning ecological and phylogenetic components of Bergmann's rule in European Carnivora. *Ecography* 30, 598–608. https://doi.org/10.1111/j.2007.0906-7590.04988.x — **VERIFIED**
- **Content:** A framework that partitions a species trait into phylogenetic and ecological components and maps each component's assemblage mean in geographic space.
- **Application:** The direct template for "lineage vs climate" at cell level. Decompose each species' strategy (or its latent liability from a phylogenetic logistic or threshold model) into a phylogenetically predicted part P and a residual S. Map cell means of P and S, then regress each on present and past climate.
  - If climate explains the cell means of S, climate is associated with strategy beyond lineage.
  - If climate explains only the cell means of P, the association reflects which clades live where (niche conservatism or history).
- **PDF:** paywalled.

**C5. Desdevises, Y., Legendre, P., Azouzi, L. & Morand, S. (2003).** Quantifying phylogenetically structured environmental variation. *Evolution* 57, 2647–2652. https://doi.org/10.1111/j.0014-3820.2003.tb01508.x — **VERIFIED**
- **Content:** Variation partitioning of a species trait among phylogeny (PVR eigenvectors) and environment. The shared fraction is "phylogenetically structured environmental variation" (niche conservatism).
- **Application:** At species level, partition strategy (or latent liability) into [environment only | shared | phylogeny only]. The shared fraction will probably be large for Lepidochrysops and Thestor (Cape clades in Cape climates). It should be reported as shared, not given to either climate or lineage.
- **PDF:** paywalled.

**C6. Pillar, V. D. & Duarte, L. d. S. (2010).** A framework for metacommunity analysis of phylogenetic structure. *Ecology Letters* 13, 587–596. https://doi.org/10.1111/j.1461-0248.2010.01456.x — **VERIFIED**
- **Content:** Phylogenetic fuzzy weighting (PFW): community composition weighted by phylogenetic relatedness, giving a sites × clades matrix. It tests the phylogenetic signal at the metacommunity level with specified null models.
- **Software:** SYNCSA 1.3.5 on CRAN.
- **PDF:** paywalled.

**C7. Duarte, L. d. S., Debastiani, V. J., Freitas, A. V. L. & Pillar, V. D. (2016).** Dissecting phylogenetic fuzzy weighting: theory and application in metacommunity phylogenetics. *Methods in Ecology and Evolution* 7, 937–946. https://doi.org/10.1111/2041-210x.12547 — **VERIFIED**
- **Content:** Properties of PFW and principal coordinates of phylogenetic structure (PCPS), evaluated for Type I error and power against COMDIST, Rao's H and UniFrac.
- **Software:** PCPS 1.0.9 on CRAN.
- **Application:** PCPS axes of the cell × species matrix (lycaenid phylogeny) are a compact "lineage composition" predictor set for cell-level variation partitioning ([present climate] [past climate] [space: MEMs] [lineage: PCPS axes]).
- **Caveat:** Using PCPS axes as predictors of a trait CWM is partly circular, because both are functions of composition. The constrained null in Design §3 is needed to calibrate them.
- **PDF:** OA (author version at the publisher); scripted download blocked.

**C8. Leibold, M. A., Economo, E. P. & Peres-Neto, P. (2010).** Metacommunity phylogenetics: separating the roles of environmental filters and historical biogeography. *Ecology Letters* 13, 1290–1299. https://doi.org/10.1111/j.1461-0248.2010.01523.x — **VERIFIED** *(abstract not read)*
- **Related:** Peres-Neto, Leibold & Dray 2012, *Ecology* 93 (https://doi.org/10.1890/11-0494.1, **VERIFIED**).
- **Content:** Variation partitioning of phylogenetically informed composition into environmental and spatial (historical) fractions.
- **Application:** The conceptual precedent for "environment vs space vs lineage" partitions with eigenvector predictors.
- **PDF:** paywalled.

**C9. Bauman, D., Drouet, T., Dray, S. & Vleminckx, J. (2018).** Disentangling good from bad practices in the selection of spatial or phylogenetic eigenvectors. *Ecography* 41, 1638–1649. https://doi.org/10.1111/ecog.03380 — **VERIFIED**
- **Content:** Selecting eigenvectors by AIC gave Type I error up to 100% and overestimated R², especially the pure spatial and shared fractions.
- **Recommendation:** Use forward selection with a double stopping criterion (FWD) to describe patterns, or minimisation of residual autocorrelation (MIR) to control for them.
- **Application:** **Never select MEMs or phylogenetic eigenvectors by AIC.** Use `adespatial::forward.sel` with the double stopping rule for the variation partitioning, or MIR when MEMs are only a nuisance control.
- **PDF:** paywalled.

---

## D. Variation partitioning and relative importance

**D1. Borcard, D., Legendre, P. & Drapeau, P. (1992).** Partialling out the spatial component of ecological variation. *Ecology* 73, 1045–1055. https://doi.org/10.2307/1940179 — **VERIFIED**
- **Content:** Partitions variation into pure environmental, spatially structured environmental, pure spatial and undetermined parts.
- **PDF:** paywalled.

**D2. Peres-Neto, P. R., Legendre, P., Dray, S. & Borcard, D. (2006).** Variation partitioning of species data matrices: estimation and comparison of fractions. *Ecology* 87, 2614–2625. https://doi.org/10.1890/0012-9658(2006)87[2614:VPOSDM]2.0.CO;2 — **VERIFIED**
- **Content:** Raw (unadjusted) R² fractions are biased; use adjusted R² fractions. The paper also gives a test comparing fractions.
- **Application:** Report adjusted fractions for the four blocks. For non-Gaussian responses, adjust with a deviance-based analogue or out-of-sample R² instead.
- **PDF:** paywalled.

**D3. Lai, J., Zou, Y., Zhang, J. & Peres-Neto, P. R. (2022).** Generalizing hierarchical and variation partitioning in multiple regression and canonical analyses using the rdacca.hp R package. *Methods in Ecology and Evolution* 13, 782–788. https://doi.org/10.1111/2041-210x.13800 — **VERIFIED**
- **Content (read):** Links commonality analysis, variation partitioning and hierarchical partitioning. Generalises all three to any number of predictor groups. rdacca.hp 1.1-4 is on CRAN.
- **Companions:** Chevan & Sutherland 1991, *Am. Stat.* 45, 90–96 (https://doi.org/10.1080/00031305.1991.10475776, **VERIFIED**). The same authors' `glmm.hp` package handles GLMMs (not checked this session).
- **Application:** Four groups (present climate, past climate, space, lineage) give 15 commonality fractions. Hierarchical partitioning then allocates the shared parts so the individual effects sum to total R². Report both: the commonality table shows the shared fractions honestly.
- **PDF:** `lai_2022_rdacca_hp.pdf` (bioRxiv preprint).

**D4. Grömping, U. (2006).** Relative importance for linear regression in R: the package relaimpo. *Journal of Statistical Software* 17(1). https://doi.org/10.18637/jss.v017.i01 — **VERIFIED** *(abstract not read)*
- **Content:** LMG / Shapley decomposition of R² among predictors.
- **PDF:** OA (JSS); not downloaded.

---

## E. Spatial autocorrelation, spatial models and spatial validation

**E1. Dormann, C. F., McPherson, J. M., Araújo, M. B., Bivand, R., Bolliger, J., Carl, G., ... & Wilson, R. (2007).** Methods to account for spatial autocorrelation in the analysis of species distributional data: a review. *Ecography* 30, 609–628. https://doi.org/10.1111/j.2007.0906-7590.05171.x — **VERIFIED**
- **Content:** Reviews six method families: autocovariate regression, spatial eigenvector mapping, GLS, CAR/SAR, GEE and (in the Gaussian case) others. Most methods controlled Type I error on simple simulations, but results were variable for binary data. Autocovariate methods consistently underestimated environmental effects.
- **Application:** Do not use autocovariate models. Prefer SAR-error, GLS, spatial random effects or MEMs.
- **PDF:** OA (Univ. Lausanne and Potsdam repositories, submitted version); scripted download blocked.

**E2. Kissling, W. D. & Carl, G. (2008).** Spatial autocorrelation and the selection of simultaneous autoregressive models. *Global Ecology and Biogeography* 17, 59–71. https://doi.org/10.1111/j.1466-8238.2007.00334.x — **VERIFIED**
- **Content:** SAR-error models were the most reliable across autocorrelation structures. SAR-lag, SAR-mix and OLS had weak Type I control or unpredictable bias. The neighbourhood definition and weight-coding style matter.
- **Application:** If a Gaussian cell-level model is used (e.g. logit-transformed proportions), use SAR-error (`spatialreg::errorsarlm`) with neighbourhood choice reported.
- **PDF:** paywalled.

**E3. Bini, L. M., Diniz-Filho, J. A. F., Rangel, T. F. L. V. B., Akre, T. S. B., Albaladejo, R. G., Albuquerque, F. S., ... & Hawkins, B. A. (2009).** Coefficient shifts in geographical ecology: an empirical evaluation of spatial and non-spatial regression. *Ecography* 32, 193–204. https://doi.org/10.1111/j.1600-0587.2009.05717.x — **VERIFIED**
- **Content:** Across 97 datasets, standardised coefficients changed between OLS and eight spatial methods. The shifts were usually small, idiosyncratic and not predictable from autocorrelation levels.
- **Conclusion:** Be explicit about model uncertainty.
- **Application:** Report climate-block importance under several spatial specifications (OLS/GLM, SAR-error, MEM, spatial smooth, spatial random effect). Treat the spread across them as part of the result.
- **PDF:** OA (bronze at publisher; UAH repository); scripted download blocked.

**E4. Diniz-Filho, J. A. F., Bini, L. M. & Hawkins, B. A. (2003).** Spatial autocorrelation and red herrings in geographical ecology. *Global Ecology and Biogeography* 12, 53–64. https://doi.org/10.1046/j.1466-822x.2003.00322.x — **VERIFIED** *(abstract not read)*
- **Related:** Hawkins et al. 2007, *Ecography* 30, 375–384 (https://doi.org/10.1111/j.0906-7590.2007.05117.x, **VERIFIED**).
- **Content:** Argue that spatial autocorrelation rarely changes the conclusions of broad-scale analyses.
- **PDF:** paywalled.

**E5. Dray, S., Legendre, P. & Peres-Neto, P. R. (2006).** Spatial modelling: a comprehensive framework for principal coordinate analysis of neighbour matrices (PCNM). *Ecological Modelling* 196, 483–493. https://doi.org/10.1016/j.ecolmodel.2006.02.015 — **VERIFIED** *(abstract not read)*
- **Content:** Moran's eigenvector maps (MEMs) as spatial predictors.
- **Related:**
  - Dray et al. 2012, *Ecol. Monogr.* 82, 257–275 (https://doi.org/10.1890/11-1183.1, **VERIFIED**).
  - Bauman et al. 2018, *Ecology* 99, 2159–2166 (https://doi.org/10.1002/ecy.2469, **VERIFIED**; read). Optimise the spatial weighting matrix among a small set of candidates, because distance-based weighting matrices underestimate spatial signal.
- **Software:** adespatial 0.3-30 on CRAN.
- **Application:** The "space" block = forward-selected MEMs from a neighbour graph of the 500-km Equal Earth cells.
- **PDF:** paywalled.

**E6. Rousset, F. & Ferdy, J.-B. (2014).** Testing environmental and genetic effects in the presence of spatial autocorrelation. *Ecography* 37, 781–790. https://doi.org/10.1111/ecog.00566 — **VERIFIED**
- **Content:** spaMM fits spatial GLMMs (Matérn) by Laplace approximation. LRTs with bootstrap correction perform well. glmmPQL is not appropriate.
- **Application:** spaMM 4.7.17 is on CRAN (2026-10-09). Fit binomial GLMMs of strategy counts per cell with a Matérn random effect on cell coordinates, using great-circle distances. Out-of-the-box multinomial is limited, so fit per-strategy binomial or baseline-category logits separately.
- **PDF:** OA (bronze; HAL); scripted download blocked.

**E7. Lindgren, F. & Rue, H. (2015).** Bayesian spatial modelling with R-INLA. *Journal of Statistical Software* 63(19). https://doi.org/10.18637/jss.v063.i19 — **VERIFIED** *(abstract not read)*
- **Related:** Bakka et al. 2018, *WIREs Comput. Stat.* 10, e1443 (https://doi.org/10.1002/wics.1443, **VERIFIED**).
- **Content:** SPDE/Matérn spatial fields, including on the sphere.
- **Application:** Alternative to spaMM or brms for spatial binomial or multinomial (via Poisson trick) models. INLA is not on CRAN (it installs from its own repository).
- **PDF:** OA (JSS); not downloaded.

**E8. Wood, S. N., Pya, N. & Säfken, B. (2016).** Smoothing parameter and model selection for general smooth models. *Journal of the American Statistical Association* 111, 1548–1563. https://doi.org/10.1080/01621459.2016.1180986 — **VERIFIED** *(abstract not read)*
- **Content:** The basis of mgcv's extended families, including `multinom()`.
- **mgcv `multinom` (help page read):** Expects one categorical response per row coded 0..K, fitted with K linear predictors. It is suited to few categories and is not invariant to relabelling. The help page does not document aggregated counts.
- **Application:**
  - **Species level:** `gam(list(strategy ~ s(clim) + s(lon, lat, bs = "sos"), ~ ..., ~ ...), family = multinom(K = 3))`.
  - **Cell level:** use binomial GAMs, `cbind(n_k, N − n_k) ~ s(clim) + s(lon, lat, bs = "sos")`, one per strategy, or brms multinomial.
- mgcv 1.9-4 on CRAN.
- **PDF:** paywalled.

**E9. Roberts, D. R., Bahn, V., Ciuti, S., Boyce, M. S., Elith, J., Guillera-Arroita, G., ... & Dormann, C. F. (2017).** Cross-validation strategies for data with temporal, spatial, hierarchical, or phylogenetic structure. *Ecography* 40, 913–929. https://doi.org/10.1111/ecog.02881 — **VERIFIED**
- **Content:** Random CV seriously underestimates predictive error with structured data. Structured data also invite overfitting with non-causal predictors, even when GLS or mixed models are used. Block CV (in space, by random effect, or by phylogenetic distance) is nearly always more appropriate. Blocking can force extrapolation, so blocks must be chosen carefully.
- **Application:**
  - Estimate climate's explanatory power as out-of-sample (spatially blocked) R² or deviance explained, e.g. leave-one-realm-out and ~1,500-km blocks (`blockCV::cv_spatial`, blockCV 4.0-1 on CRAN).
  - For species-level models, use phylogenetically blocked CV (leave-one-genus or leave-one-tribe out). This directly tests whether climate predicts strategy in lineages not used in fitting.
- **PDF:** paywalled (closed per Unpaywall).

**E10. Ploton, P., Mortier, F., Réjou-Méchain, M., Barbier, N., Picard, N., Rossi, V., ... & Pélissier, R. (2020).** Spatial validation reveals poor predictive performance of large-scale ecological mapping models. *Nature Communications* 11, 4540. https://doi.org/10.1038/s41467-020-18321-y — **VERIFIED**
- **Content:** Non-spatial CV suggested a random forest explained more than half of biomass variation. Spatial CV showed near-zero predictive power.
- **Application:** A cautionary example for any random forest or GAM cell-level model.
- **Counterpoint:** Wadoux et al. 2021, *Ecol. Model.* 457, 109692 (https://doi.org/10.1016/j.ecolmodel.2021.109692, **VERIFIED**; abstract not read) argue spatial CV is not the right way to assess *map accuracy*. Our goal is explanation and transferability, not map accuracy, so spatial-block CV is appropriate. Cite both.
- **PDF:** OA (Nature Comms); not downloaded.

---

## F. Null models and constrained randomisations

**F1. Wagner, H. H. & Dray, S. (2015).** Generating spatially constrained null models for irregularly spaced data using Moran spectral randomization methods. *Methods in Ecology and Evolution* 6, 1169–1178. https://doi.org/10.1111/2041-210x.12407 — **VERIFIED** *(read PDF)*
- **Content:** Moran spectral randomisation (MSR) creates surrogate variables that keep the spatial autocorrelation structure (Moran's I spectrum) of the original. Implemented as `adespatial::msr`.
- **Application:** "Spatially constrained" null for the climate–proportion association. Randomise the climate surfaces with MSR, keeping their autocorrelation, and refit. This tests whether the observed climate R² beats what any equally autocorrelated surface would give.
- **Related:** Crabot et al. 2019, *MEE* 10, 532–540 (https://doi.org/10.1111/2041-210x.13141, **VERIFIED**) applies MSR to Mantel tests.
- **PDF:** `wagner_2015_moran_spectral.pdf` (Univ. Toronto repository).

**F2. Gotelli, N. J. (2000).** Null model analysis of species co-occurrence patterns. *Ecology* 81, 2606–2621. https://doi.org/10.1890/0012-9658(2000)081[2606:NMAOSC]2.0.CO;2 — **VERIFIED** *(abstract not read)*
- **Content:** The fixed–fixed and related matrix randomisations.
- **Application:** Not needed for strategy labels, but cite it if presence matrices are randomised.

**Null-model scheme assembled from A1, A3, A4, A5, C4 and F1:**
- **(i) Random-label null (free):** Permute strategies among all classified species, keeping ranges. This is the Zelený–Schaffers / Hawkins random-intrinsic-variable null and gives the expected cell-level R² from co-occurrence structure alone.
- **(ii) Phylogenetically constrained null:** Simulate strategies on the tree under the fitted Mk model (`phytools::sim.history` or `castor`), or permute within genera or tribes. Keep the observed frequency of each strategy (rejection sampling or within-clade permutation). This null keeps lineage clustering but breaks any climate signal not mediated by where clades live. If the observed climate R² exceeds the 95th percentile of this null, climate explains variation beyond clade-structured geography.
- **(iii) Spatially constrained null:** MSR surrogates of the climate predictors (F1), or toroidal or rotation shifts of the predictor surfaces.

---

## G. Responses for proportions and compositions in cells

**G1. Douma, J. C. & Weedon, J. T. (2019).** Analysing continuous proportions in ecology and evolution: a practical introduction to beta and Dirichlet regression. *Methods in Ecology and Evolution* 10, 1412–1430. https://doi.org/10.1111/2041-210x.13234 — **VERIFIED**
- **Content:** Distinguish count-based from continuous proportions. Count-based proportions with 2 categories → logistic (binomial) regression. Continuous proportions → beta regression. More than 2 categories → **multinomial logistic** (counts) or **Dirichlet** (continuous). Transformations bias estimates.
- **Application:** Our cell proportions are **count-based** (k_j of N_j classified species), so use **multinomial (or Dirichlet-multinomial for overdispersion)**, not Dirichlet regression on proportions or arcsine/logit transforms. Use N_j as the trial size. This automatically gives cells with more classified species more weight, which is the natural sampling-coverage weight.
- **Software:**
  - brms `multinomial` / `dirichlet_multinomial`.
  - VGAM 1.1-14 (`multinomial`, `dirmultinomial`).
  - DirichletReg 0.7-4 (continuous only).
  - nnet::multinom (no random effects).
- **PDF:** OA (hybrid at publisher; VU/WUR repositories); scripted download blocked.

**G2. Practical note: overdispersion from repeated co-occurrence.**
- The same species appear in many cells, so cell counts are not independent multinomial draws.
- A Dirichlet-multinomial or observation-level random effect absorbs extra-multinomial variance. A spatial random effect absorbs the autocorrelated part.
- Neither removes the inflation in A1. That is why the label-shuffle nulls in §F remain necessary.

---

## H. Sampling coverage and classification bias

**H1. Meyer, C., Kreft, H., Guralnick, R. & Jetz, W. (2015).** Global priorities for an effective information basis of biodiversity distributions. *Nature Communications* 6, 8221. https://doi.org/10.1038/ncomms9221 — **VERIFIED**
- **Content (abstract read):** 157 million point records for 21,170 vertebrate species. Outside a few well-sampled regions, point records give very limited and spatially biased inventories. Completeness is limited mainly by distance to researchers, local research funding and participation in data-sharing networks.
- **Application:** Classification coverage (good in southern Africa, Europe and Australia; poor in tropical Americas and central Africa) is likely structured by the same socio-economic drivers. Those correlate with climate (temperate and Mediterranean vs tropical), so coverage can mimic a climate effect.
- **Mitigations:**
  - Add a **cell-level classification completeness** covariate: classified species ÷ all lycaenid species recorded in the cell (from the GBIF-derived ranges).
  - Model it as a nuisance term.
  - Show that the results hold when restricted to cells with completeness ≥ 0.5 (or similar).
  - Include completeness as its own block in the variation partitioning.
- **PDF:** `meyer_2015_information_gaps.pdf` (Nature Comms OA).

---

## I. Climate-change velocity and stability: concepts, algorithms and software

**I1. Loarie, S. R., Duffy, P. B., Hamilton, H., Asner, G. P., Field, C. B. & Ackerly, D. D. (2009).** The velocity of climate change. *Nature* 462, 1052–1055. https://doi.org/10.1038/nature08649 — **VERIFIED** *(abstract not available in OpenAlex)*
- **Content:** Defines velocity as the temporal gradient (°C per year) divided by the spatial gradient (°C per km), giving km per year.
- **Flat-terrain handling:** The gradient denominator → 0 in flat areas, so velocities blow up. Practice is to floor the spatial gradient or log-transform. Loarie's exact floor was **not verified** this session.
- **PDF:** paywalled.

**I2. Sandel, B., Arge, L., Dalsgaard, B., Davies, R. G., Gaston, K. J., Sutherland, W. J. & Svenning, J.-C. (2011).** The influence of Late Quaternary climate-change velocity on species endemism. *Science* 334, 660–664. https://doi.org/10.1126/science.1210173 — **VERIFIED**
- **Content (abstract read):** Velocity of mean annual temperature since the LGM, combining macroclimatic shifts with topoclimatic gradients. High velocity was associated with marked absences of small-ranged amphibians, mammals and birds; the effect was weakest in birds and strongest in amphibians.
- **Data:** Dryad doi:10.5061/dryad.b13j1 (12.7 MB, 2011; Dryad data are CC0 by repository policy). Its contents, resolution and GCMs were not inspected.
- **Application:**
  - Cite as the standard LGM-velocity precedent.
  - The Dryad layer could be used directly as one velocity variant, but check the README first.
  - Also compute our own velocity from CHELSA-TraCE21k LGM vs present for consistency with our present climate.
- **PDF:** paywalled.

**I3. Burrows, M. T., Schoeman, D. S., Buckley, L. B., Moore, P., Poloczanska, E. S., Brander, K. M., ... & Richardson, A. J. (2011).** The pace of shifting climate in marine and terrestrial ecosystems. *Science* 334, 652–655. https://doi.org/10.1126/science.1210288 — **VERIFIED**
- **Content:** Velocity (isotherm shift) and seasonal-shift indices from 50 years of temperature.
- **Algorithm:** The spatial gradient is a 3×3-neighbourhood weighted N–S and E–W difference. VoCC's `spatGrad` follows it, from knowledge; not re-read.
- **PDF:** paywalled.

**I4. Hamann, A., Roberts, D. R., Barber, Q. E., Carroll, C. & Nielsen, S. E. (2015).** Velocity of climate change algorithms for guiding conservation and management. *Global Change Biology* 21, 997–1004. https://doi.org/10.1111/gcb.12736 — **VERIFIED**
- **Content (abstract read):** An analogue-based (distance-to-nearest-climate-match) velocity. It matches the standard algorithm where analogues are nearby; otherwise it extends the search for refugia, including multivariate matches. Gives forward and backward velocities.
- **Application:**
  - Use **backward velocity** (present cell → nearest LGM analogue) as the palaeo-refugium metric.
  - It avoids the flat-terrain division by zero and handles multivariate climate (temperature + precipitation).
  - Compare it with gradient velocity as a sensitivity check.
- **PDF:** OA (hybrid); not downloaded.

**I5. Brito-Morales, I., García Molinos, J., Schoeman, D. S., Burrows, M. T., Poloczanska, E. S., Brown, C. J., ... & Richardson, A. J. (2018).** Climate velocity can inform conservation in a warming world. *Trends in Ecology & Evolution* 33, 441–457. https://doi.org/10.1016/j.tree.2018.03.009 — **VERIFIED** *(abstract not read)*
- **Content:** Review of gradient-based vs distance-based velocity, their assumptions (scale, resolution) and their uses.
- **PDF:** paywalled.

**I6. Garcia, R. A., Cabeza, M., Rahbek, C. & Araújo, M. B. (2014).** Multiple dimensions of climate change and their implications for biodiversity. *Science* 344, 1247579. https://doi.org/10.1126/science.1247579 — **VERIFIED**
- **Content (abstract read):** Six common metrics show contrasting global patterns: local anomalies, extremes, change in analogous-climate area, novel climates, distance to analogues and velocity.
- **Application:** Justifies using several past-climate metrics (LGM anomaly, velocity, stability) as one "past climate" block rather than a single metric. They are also expected to be weakly correlated with each other.
- **PDF:** paywalled.

**I7. García Molinos, J., Schoeman, D. S., Brown, C. J. & Burrows, M. T. (2019).** VoCC: an R package for calculating the velocity of climate change and related climatic metrics. *Methods in Ecology and Evolution* 10, 2195–2202. https://doi.org/10.1111/2041-210x.13295 — **VERIFIED**
- **Content:** Gradient-based and distance-based velocity, trajectories and related metrics.
- **Package status:** GitHub only (JorGarMol/VoCC, AGPL-3, v1.0.0, 2019). It is raster-based; check compatibility with current terra/sf.
- **Application:** `tempTrend` (or a two-slice difference ÷ 21,000 yr), then `spatGrad` and `gVoCC` on 30-arcsec or 2.5-arcmin LGM and present temperature. Aggregate to 500-km cells by the **median of log10 velocity**, after flooring the spatial gradient at a small value (e.g. 0.001 °C/km). Report sensitivity to the floor.
- **PDF:** OA (hybrid); scripted download blocked.

**I8. Taheri, S., Naimi, B. & Araújo, M. B. (2024).** climetrics: an R package to quantify multiple dimensions of climate change. *Ecography* 2024, e07176. https://doi.org/10.1111/ecog.07176 — **VERIFIED**
- **Content (abstract read):** Six metrics: standardised local anomalies, change in probability of extremes, change in analogous-climate area, novel climates, change in distance to analogues and velocity. Velocity comes as distance-based (`dVe`), threshold-based (`ve`) or gradient-based (`gVe`). Built on raster time series (`rts`).
- **Package status:** climetrics 1.0-15 on CRAN (2024-04).
- **Application:** One package that computes LGM→present anomaly, gradient velocity and distance (analogue) velocity on the same footing.
- **PDF:** not downloaded (check OA).

**I9. Owens, H. L. & Guralnick, R. (2019).** climateStability: an R package to estimate climate stability from time-slice climatologies. *Biodiversity Informatics* 14, 8–13. https://doi.org/10.17161/bi.v14i0.9786 — **VERIFIED** (note the journal correction above)
- **Content (abstract read):** Deviation = mean SD between time slices per elapsed time. Stability = 1/deviation. Overall climate stability = the product of per-variable stabilities.
- **Package status:** climateStability 0.1.4 on CRAN (2022).
- **Application:** Quaternary stability from CHELSA-TraCE21k 100-yr slices (21 ka–present), or from Beyer2020 / Krapp2021 1-kyr slices (120 kyr or 800 kyr), for temperature and precipitation separately.
- **PDF:** OA (journal); not downloaded.

**I10. Svenning, J.-C., Eiserhardt, W. L., Normand, S., Ordonez, A. & Sandel, B. (2015).** The influence of paleoclimate on present-day patterns in biodiversity and ecosystems. *Annual Review of Ecology, Evolution, and Systematics* 46, 551–572. https://doi.org/10.1146/annurev-ecolsys-112414-054314 — **VERIFIED**
- **Content (abstract read):** Ample evidence that glacial–interglacial change shapes species distributions and diversity. Emerging evidence that palaeoclimate also shapes phylogenetic and functional diversity.
- **Application:** The framing citation for "past climate legacies in trait composition".
- **PDF:** paywalled.

**I11. Further past-climate precedents (all VERIFIED):**
- Jansson 2003, *Proc. R. Soc. B* 270, 583–590 (https://doi.org/10.1098/rspb.2002.2283).
- Dynesius & Jansson 2000, *PNAS* 97, 9115–9120 (https://doi.org/10.1073/pnas.97.16.9115).
- Araújo et al. 2008, *Ecography* 31, 8–15 (https://doi.org/10.1111/j.2007.0906-7590.05318.x). Abstract read: LGM–present climate stability predicted European herp richness better than contemporary climate.
- Ordonez & Svenning 2017, *Sci. Rep.* 7, 42988 (https://doi.org/10.1038/srep42988). Quaternary climate change and plant functional diversity; PDF already in the folder from another agent: `ordonez_2017_quaternary_functional_diversity.pdf`.

---

## J. Climate and palaeoclimate data (do not download here; specifications only)

| Dataset | Reference (VERIFIED) | Resolution | Time span / steps | Licence | Size / access |
|---|---|---|---|---|---|
| **WorldClim 2.1** | Fick & Hijmans 2017, *Int. J. Climatol.* 37, 4302–4315, https://doi.org/10.1002/joc.5086 | 30 s, 2.5', 5', 10' | 1970–2000 normals; monthly Tmin/Tmean/Tmax, precipitation, solar radiation, wind, vapour pressure, 19 bioclim | Not stated on the download page (copyright notice and citation request only) | worldclim.org; also via pastclim `WorldClim_2.1_RESm` |
| **CHELSA V1.2 / V2.1** | Karger et al. 2017, *Sci. Data* 4, 170122, https://doi.org/10.1038/sdata.2017.122 | 30 arcsec | 1979–2013 (V1.2 paper); V2.1 1981–2010 | EnviDat entry "Climatologies at high resolution…" (doi:10.16904/envidat.228) is **CC0** | EnviDat / S3 |
| **CHELSA-TraCE21k v1.0** | Karger et al. 2023, *Clim. Past* 19, 439–456, https://doi.org/10.5194/cp-19-439-2023 | 30 arcsec (~1 km) | 21 ka–1950 in **100-yr steps** (plus 4 steps to 1990). TraCE-21k CCSM3 transient run downscaled with CHELSA; includes paleo-orography and glacier extent | EnviDat doi:10.16904/envidat.211, **CC BY-SA** | Very large; pastclim `CHELSA_trace21k_1.0_0.5m_vsi` streams a 0.5' version via VSI |
| **Beyer2020** | Beyer, Krapp & Manica 2020, *Sci. Data* 7, 236, https://doi.org/10.1038/s41597-020-0552-1 | 0.5° | 120 ka–present, 1–2 kyr steps. Monthly temperature, precipitation, cloud, relative humidity, wind; 17 bioclim; NPP, LAI, BIOME4 biomes | Figshare 10.6084/m9.figshare.12293345, **CC BY 4.0** | 1.33 GB netCDF; pastclim repackage 1.53 GB |
| **Krapp2021** | Krapp et al. 2021, *Sci. Data* 8, 228, https://doi.org/10.1038/s41597-021-01009-3 | 0.5° | 800 ka–present, 1-kyr steps (statistical emulation of HadCM3) | (OSF; licence not checked) | via pastclim |
| **PALEO-PGEM-Series** | Barreto et al. 2023, *GEB* 32, 1034–1045, https://doi.org/10.1111/geb.13683 | 1° | 5 Myr–present, 1-kyr steps. Monthly temperature/precipitation + 17 bioclim + emulator SE | (not checked) | pastclim `Barreto2023` |
| **PaleoClim** | Brown et al. 2018, *Sci. Data* 5, 180254, https://doi.org/10.1038/sdata.2018.254 | 2.5', 5', 10' | Paper: MIS19 (~787 ka), mPWP (~3.2 Ma), M2 (~3.3 Ma), HadCM3 snapshots. Site also lists Late Pleistocene/Holocene snapshots incl. LGM (**UNVERIFIED** this session; paleoclim.org certificate error) | (not checked) | pastclim `paleoclim_1.0_*` |
| **PaleoView** | Fordham et al. 2017, *Ecography* 40, 1348–1358, https://doi.org/10.1111/ecog.03031 | Coarse GCM grid (CCSM3; resolution not re-read) | 21 ka–present, down to decadal intervals; temperature, precipitation, humidity, sea-level pressure | Freeware | Desktop tool |
| **pastclim** (access layer) | Leonardi et al. 2023, *Ecography* 2023, e06481, https://doi.org/10.1111/ecog.06481 | — | Datasets confirmed on the package site: Beyer2020, Krapp2021, Barreto2023, CHELSA_trace21k_1.0_0.5m_vsi, HYDE_3.3_baseline, paleoclim_1.0_{2.5m,5m,10m}, WorldClim_2.1_RESm, CHELSA_2.1 future | Package GPL; datasets keep their own licences | CRAN 2.2.0 (2025-02). PDF: `leonardi_2023_pastclim.pdf` (preprint v1) |

**Recommendation for climate data**
- **Main analysis:** CHELSA V2.1 (present) + CHELSA-TraCE21k (LGM slice at 21 ka, plus the full 100-yr series for stability) = one consistent downscaling chain.
- **Sensitivity:** WorldClim 2.1 for present climate, and Beyer2020 for the LGM anomaly and 120-kyr stability (independent GCM: HadCM3 vs CCSM3).
- **Deeper-time stability:** Krapp2021 (800 kyr) or Barreto2023 (5 Myr, 1°).
- **Licence caveat:** TraCE21k is CC BY-SA, so derived layers that are redistributed must carry the same licence.

---

## K. Other environmental layers (mediators or covariates)

**Global Aridity Index & PET v3.** Zomer, R. J., Xu, J. & Trabucco, A. (2022). Version 3 of the Global Aridity Index and Potential Evapotranspiration Database. *Scientific Data* 9, 409. https://doi.org/10.1038/s41597-022-01493-1 — **VERIFIED**
- **Specification:** 30 arcsec; 1970–2000 averages; FAO Penman–Monteith ET0.
- **Current release:** Figshare now hosts **v3.1** (10.6084/m9.figshare.7504448.v7), **CC BY 4.0**. Annual AI/ET0 zip 0.65 GB; monthly ET0 0.95 GB; monthly AI 3.86 GB.

**NPP / GPP (MODIS MOD17).** Zhao, M., Heinsch, F. A., Nemani, R. R. & Running, S. W. (2005). Improvements of the MODIS terrestrial gross and net primary production global data set. *Remote Sensing of Environment* 95, 164–176. https://doi.org/10.1016/j.rse.2004.12.011 — **VERIFIED** *(abstract not read)*
- **Product:** Current MOD17A3HGF v061, 500 m, annual 2001–present, via NASA LP DAAC (resolution and licence from knowledge; **not verified** this session).
- **Alternative:** Beyer2020 includes BIOME4 NPP for both present and LGM, which allows an NPP anomaly.

**Biomes / ecoregions.**
- Olson, D. M. et al. (2001). Terrestrial ecoregions of the world: a new map of life on Earth. *BioScience* 51, 933–938. https://doi.org/10.1641/0006-3568(2001)051[0933:TEOTWA]2.0.CO;2 — **VERIFIED**
- Dinerstein, E. et al. (2017). An ecoregion-based approach to protecting half the terrestrial realm. *BioScience* 67, 534–545. https://doi.org/10.1093/biosci/bix014 — **VERIFIED**. Abstract read: 846 ecoregions; the Ecoregions2017 shapefile licence (CC BY 4.0) is from knowledge, **unverified**.
- **Use:** Realm or biome as a fixed blocking factor for nonstationarity tests and for leave-one-realm-out CV.

**Fire.** van der Werf, G. R. et al. (2017). Global fire emissions estimates during 1997–2016. *Earth System Science Data* 9, 697–720. https://doi.org/10.5194/essd-9-697-2017 — **VERIFIED**
- **Specification:** GFED4s, 0.25°, 1997–2016 (burned area including small fires). Later GFED5 exists (not checked).

**Soils.**
- Poggio, L. et al. (2021). SoilGrids 2.0: producing soil information for the globe with quantified spatial uncertainty. *SOIL* 7, 217–240. https://doi.org/10.5194/soil-7-217-2021 — **VERIFIED**
  - 250 m; 6 depths; SOC, N, pH, CEC, texture, bulk density, coarse fragments. SoilGrids licence is CC BY 4.0 (from knowledge; unverified).
- He, X. et al. (2021). Global patterns and drivers of soil total phosphorus concentration. *Earth System Science Data* 13, 5831–5846. https://doi.org/10.5194/essd-13-5831-2021 — **VERIFIED**
  - 5,275 soils; random-forest global map of total P; topsoil/subsoil stocks. Resolution not re-read.
- **Relevance:** Pierce's nitrogen hypothesis (Pierce 1985, *Am. Nat.* 125, 888–895, https://doi.org/10.1086/284387, **VERIFIED**) motivates N and P layers as candidate mediators of host-plant quality and ant attendance.

---

## L. Ant data for a mediation analysis

**L1. Guénard, B., Weiser, M. D., Gómez, K., Narula, N. & Economo, E. P. (2017).** The Global Ant Biodiversity Informatics (GABI) database: synthesizing data on the geographic distribution of ant species (Hymenoptera: Formicidae). *Myrmecological News* 24, 83–89. https://doi.org/10.25849/myrmecol.news_024:083 — **VERIFIED** (DataCite; not in Crossref)
- **Content (PDF read):** About 1.72 M records from 8,811 publications plus databases and museum records. Native-range data by political/biogeographic polygons ("Bentities"). Article licensed CC BY 3.0.
- **Data access (antmaps.org/about):**
  - "Data Release 1.0" ZIP, about 65 MB, valid taxa as of 2020-01-18. Excludes AntWeb records, unassignable records and exotic records.
  - No formal licence is stated. Users must cite Guénard et al. 2017, plus Janicki et al. 2016 when viewing via antmaps (*Ecol. Inform.* 32, 185–193, https://doi.org/10.1016/j.ecoinf.2016.02.006, **VERIFIED**). Contact zeroben@gmail.com / evaneconomo@gmail.com about uses.
  - **Since Dec 2023 the site recommends using Kass et al. 2022 (native) and Wong et al. 2023 (alien) instead.**
- **PDF:** `guenard_2017_gabi.pdf`.

**L2. Kass, J. M., Guénard, B., Dudley, K. L., Jenkins, C. N., Azuma, F., Fisher, B. L., ... & Economo, E. P. (2022).** The global distribution of known and undiscovered ant biodiversity. *Science Advances* 8, eabp9908. https://doi.org/10.1126/sciadv.abp9908 — **VERIFIED**
- **Content (PDF read):**
  - Range estimates for nearly all described ant species at **10 arcmin (~20 km)**: buffered points (30 km) for 5,168 species with <3 localities, plus Maxent SDMs (ENMeval) and polygons.
  - Stacked into richness and rarity maps. Random forests predict "undiscovered" diversity centres.
  - Robustness checked at coarser grains (20–500 arcmin), giving correlations >0.9 with the 10' maps.
  - Paper licence CC BY 4.0.
- **Data:** Dryad https://doi.org/10.5061/dryad.wstqjq2pp (v. 2022-08-24; 14.3 GB total).
  - `main_analysis_data.zip` (634 MB): raw and cleaned GABI occurrences plus **all diversity-estimate rasters** shown in the figures.
  - `results_sp_gen_data_add.zip` (5.53 GB): **individual species range estimates and genus results** ("results_species_add", "results_genus_add").
  - `random_forest_add.zip` (8.18 GB).
  - Code archived on Zenodo.
  - Licence: Dryad releases all data under **CC0** (repository policy; the landing page itself did not print it).
- **Answer to the brief:**
  - **Yes**, the gridded richness layer is downloadable, in main_analysis_data.zip.
  - **Genus-specific richness** (Myrmica, Formica, Camponotus, Crematogaster, Iridomyrmex, Oecophylla, etc.) can be built by stacking the per-species range estimates for those genera from results_sp_gen_data_add.zip. No ready-made genus richness product was found.
- **Caution:** Use the **stacked known-range** richness, not the RF-predicted "undiscovered" surface. The RF surface is a function of environmental predictors, so it would be circular in a climate → ants → strategy mediation.
- **PDF:** `kass_2022_ant_richness.pdf` (Univ. Pretoria repository copy of the published version).

**L3. Wong, M. K. L., Economo, E. P. & Guénard, B. (2023).** The global spread and invasion capacities of alien ants. *Current Biology* 33, 566–571.e3. https://doi.org/10.1016/j.cub.2022.12.020 — **VERIFIED**
- **Content:** More than 145,000 records across 602 regions; 522 alien species; 309 naturalised.
- **Application:** Use to *exclude* alien ants from host-ant richness. Not needed beyond that.
- **PDF:** paywalled (not checked).

**L4. Schultheiss, P., Nooten, S. S., Wang, R., Wong, M. K. L., Brassard, F. & Guénard, B. (2022).** The abundance, biomass, and distribution of ants on Earth. *PNAS* 119, e2201550119. https://doi.org/10.1073/pnas.2201550119 — **VERIFIED**
- **Content (PDF read):** 489 studies; 2,355 entries at 1,306 locations (leaf-litter and pitfall). About 3 × 10^15 epigaeic and about 20 × 10^15 total ants. Abundance is highest in tropical moist forests and savannas. Results are summarised by biome.
- **Data availability (quoted in substance):** All data used are in the SI. **The geographic locations of data entries have been removed**, pending further analyses, and are available on reasonable request.
- **Application:** Usable only as **biome-level** abundance or density covariates (SI Tables S3/S4 and Datasets S1–S5). Gridded ant abundance cannot be built without requesting the coordinates.
- **PDF:** `schultheiss_2022_ant_abundance.pdf` (PMC).

**L5. Economo, E. P., Narula, N., Friedman, N. R., Weiser, M. D. & Guénard, B. (2018).** Macroecology and macroevolution of the latitudinal diversity gradient in ants. *Nature Communications* 9, 1778. https://doi.org/10.1038/s41467-018-04218-4 — **VERIFIED**
- **Content (abstract read):** Latitudinal affinity is highly conserved in ants. Temperate clades are young and nested in tropical clades. Diversification time, not rate, drives the gradient.
- **Application:** Ant lineage history is itself phylogenetically conserved and climate-structured. Ant richness as a mediator is therefore collinear with climate and history; interpret mediation cautiously.
- **PDF:** already in the folder from another agent: `economo_2018_ant_latitudinal_gradient.pdf`.

**L6. AntWeb** (antweb.org): a specimen database with more than 0.5 M specimens (2016 figure per Guénard et al. 2017).
- Excluded from the GABI data release; it has an API.
- Useful only for point checks of host-ant genera. Not a gridded product.

**L7. Gridded genus-level ant richness products.** None found in this search (Myrmica, Formica, Camponotus, Crematogaster or Iridomyrmex).
- Build them from Kass et al. 2022 per-species ranges, or from GABI Bentity-level checklists, at 500-km cells.
- **UNVERIFIED:** whether genus-level layers already sit inside "results_genus_add". The folder name suggests genus-level range results, but the contents were not inspected because the README requires Dryad authentication via the API.

---

## M. Model papers partitioning climate's role in strategy or interaction proportions

| Study | Response variable | Unit | Spatial / phylogenetic handling | How variance explained was reported |
|---|---|---|---|---|
| **Jetz, W. & Rubenstein, D. R. (2011).** Environmental uncertainty and the global biogeography of cooperative breeding in birds. *Current Biology* 21, 72–78. https://doi.org/10.1016/j.cub.2010.11.075 — **VERIFIED**; PDF read | Cooperative breeding (0/1) for 9,310 non-marine species; mapped as proportional richness in 110-km cells | **Species-level** GLMs (across species) and a **nested "within-clades" GLMM** with 121 clades as random effect (no resolved phylogeny) | Phylogeny via clade random effect; species predictions **averaged per 110-km cell** to predict observed proportions (n = 11,098 cells) | AICΔ vs null for predictor groups (EnvMean, EnvVar, Biotic); AUC 0.67–0.70; cell-level Spearman r between mean predicted probability and observed proportion: rs = 0.66–0.68 without clade terms, **0.71–0.80 with clade membership**. Notes that some predictor signal is "subsumed" in phylogeny due to niche conservatism. **This species → cell aggregation is the closest template for our design.** PDF: `jetz_2011_cooperative_breeding.pdf` (Jetz lab copy) |
| **Steidinger, B. S., Crowther, T. W., Liang, J., ... & Peay, K. G. (2019).** Climatic controls of decomposition drive the global biogeography of forest-tree symbioses. *Nature* 569, 404–408. https://doi.org/10.1038/s41586-019-1128-0 — **VERIFIED**; PDF read | Proportion of tree basal area that is EM, AM or N-fixer | Plot data (GFBi) aggregated to **1°×1° cells** (n = 2,768) | **Random forest** with K-fold CV; geographic sub-sampling to equalise continents (Africa n = 50); projection restricted to the predictor envelope; no explicit spatial-autocorrelation model | Variance explained (1 − SSE/SST): **81%, 79%, 52%** for EM, AM, N-fixer; withholding 10% of training data cost <1% of variance explained. Univariate and multivariate RF agreed. PDF: `steidinger_2019_mycorrhizal.pdf` (accepted manuscript); another agent's copy `steidinger_2019_mycorrhizal_biogeography.pdf` |
| **Dalsgaard, B., Magård, E., Fjeldså, J., ... & Svenning, J.-C. (2011).** Specialization in plant-hummingbird networks is associated with species richness, contemporary precipitation and Quaternary climate-change velocity. *PLoS ONE* 6, e25891. https://doi.org/10.1371/journal.pone.0025891 — **VERIFIED**; PDF read | Network specialisation H2' | **31 networks** (sites) | OLS model sets compared by AIC ("velocity", "contemporary climate", "velocity + contemporary"); residual Moran's I tested (none significant); Dutilleul's corrected P for bivariate tests | Best models explained **53–64%** of variation; velocity, precipitation and richness retained. PDF: `dalsgaard_2011_hummingbird_velocity.pdf` |
| **Kissling, W. D., Eiserhardt, W. L., Baker, W. J., ... & Svenning, J.-C. (2012).** Cenozoic imprints on the phylogenetic structure of palm species assemblages worldwide. *PNAS* 109, 7379–7384. https://doi.org/10.1073/pnas.1120467109 — **VERIFIED**; PDF read | NRI (phylogenetic structure) of palm assemblages | TDWG "botanical countries" (n = 151 with >1 species); sampling pools at global, hemisphere and realm scales | Non-spatial and **SAR** models (citing Kissling & Carl 2008); predictors include LGM temperature/precipitation anomaly and Cenozoic rainforest-area loss per realm | Sampling-pool extent changes conclusions. Shows how pool definition and realm-level history enter. PDF: `kissling_2012_palm_phylostructure.pdf` |
| **Kissling, W. D., Böhning-Gaese, K. & Jetz, W. (2009).** The global distribution of frugivory in birds. *GEB* 18, 150–162. https://doi.org/10.1111/j.1466-8238.2008.00431.x — **VERIFIED**; abstract read | **Proportion** (and richness) of frugivorous bird species | Grid cells, global | Traditional and **spatial regression**; realm membership as "biogeographic history" | Current climate explains more variance in frugivore proportion than in non-frugivores. AET is the best single predictor. **Realm differences remain after controlling for AET**, an important precedent for a "history" residual. PDF: paywalled |
| **Bueno, C. G., Moora, M., Gerz, M., ... & Zobel, M. (2017).** Plant mycorrhizal status, but not type, shifts with latitude and elevation in Europe. *GEB* 26, 690–699. https://doi.org/10.1111/geb.12582 — **VERIFIED**; abstract read | Share of plant species by mycorrhizal status (OM/FM) and type (AM/ECM/ERM/NM) | 1,442 species on a **50×50 km grid** (Europe) | Analysed against climate, edaphic and productivity drivers (model details not read) | Temperature, soil pH and productivity drive type shares. A high share of obligate species in central European mountains suggests glacial-refugia legacy. The closest analogue to "obligate vs facultative" interaction strategy proportions. PDF: paywalled |
| **Sandel, B. et al. (2020).** Current climate, isolation and history drive global patterns of tree phylogenetic endemism. *GEB* 29, 4–15. https://doi.org/10.1111/geb.13001 — **VERIFIED**; abstract read | Tree phylogenetic endemism | 463 regions | Spatial regression with current climate, geography and history (LGM tree cover, Miocene) blocks | Relative importance of the three predictor groups reported; relationships differ among floristic regions | 
| **Stelbrink, P., Pinkert, S., Brunzel, S., Kerr, J., Wheat, C. W., Brandl, R. & Zeuss, D. (2019).** Colour lightness of butterfly assemblages across North America and Europe. *Scientific Reports* 9, 1760. https://doi.org/10.1038/s41598-018-36761-x — **VERIFIED**; abstract read | Assemblage-mean colour lightness of butterflies | 50×50 km cells | Family-level comparisons; climate predictors (insolation, temperature, humidity) | A butterfly-specific precedent for cell-level trait means. The Zeuss/Pinkert group typically partitions assemblage traits into phylogenetic vs specific components (Zeuss et al. 2014, *Nat. Commun.* 5, 3874, https://doi.org/10.1038/ncomms4874, **VERIFIED**); the exact method was not re-read. PDF: OA, not downloaded |
| **Krampe et al. (2026).** Global patterns in body size and colour lightness diversity of swallowtail butterflies highlight biogeographical legacy over common environmental explanations. *GEB* 35, e70306. https://doi.org/10.1111/geb.70306 — **VERIFIED**; abstract read | Assemblage means and dispersion of body size and colour lightness (511 Papilionidae species) | Global grid | Trend-surface models alongside environment to capture a "latent biogeographic driver" | R² reported per response; a strongly longitudinally structured latent driver explained residual pattern. A very recent GEB precedent for an "environment vs latent history/space" framing in butterflies. PDF: not checked |

Also relevant (VERIFIED, abstract read): Barnagaud et al. 2014, *Ecol. Lett.* 17, 811–820 (https://doi.org/10.1111/ele.12285). Phylogenetic structure computed *within the range of each species* (species-centred), which is another way to avoid assemblage-level pseudo-replication.

---

## Recommended analysis design (prioritised)

### 0. Framing
State the estimand explicitly: "share of among-cell variation in strategy composition statistically associated with present climate, past climate, spatial position and lineage composition, including shared fractions". Avoid causal language. The design has two levels because the cell-level R² is structurally inflated (Hawkins et al. 2017) and lineages are spatially clustered.

### 1. Primary inference: species-level phylogenetic models (avoids structural bias)
- **Unit:** each classified species (n ≈ 1,356).
- **Predictors:** range-weighted means over each species' GBIF-derived range cells.
  - **Present climate**, after a PCA of standardised layers: MAT, temperature seasonality, MAP, precipitation seasonality, aridity index (AI v3.1).
  - **Past climate:** LGM anomaly in MAT and MAP (CHELSA-TraCE21k 21 ka vs 1981–2010), log10 temperature velocity (gradient-based, floored), and climate stability (climateStability on 100-yr TraCE slices).
  - Optional covariates: NPP, soil N/P.
- **Models:**
  - (a) Three nested binary contrasts fitted with `phylolm::phyloglm` (or `phyr::pglmm_compare`): ant-associated vs non-ant-associated; obligate vs facultative within ant-associated; parasite vs mutualist within obligate. This handles the strongly unequal strategy frequencies and allows parasite clades to be analysed separately.
  - (b) A joint check: MCMCglmm `categorical` or brms `categorical` with a phylogenetic random effect.
- **Tree:** use the existing lycaenid phylogeny. Integrate over trees if posterior trees are available (refit on 100 trees and report the range).
- **Variance shares:** rr2 partial R²_lik (Ives 2019) for each block.
  - Full model vs drop-present, drop-past and drop-phylogeny.
  - Desdevises-style commonality: [climate only], [phylogeny only], [shared].
  - "Space" at species level: a covariance among species range centroids (great-circle; exponential kernel) entered as a second covariance (Freckleton & Jetz 2009 logic, or `pglmm_compare` with two `cov_ranef`).
- **Transferability:** phylogenetically blocked CV (leave-one-genus/tribe-out) and spatially blocked CV by species' realm (Roberts et al. 2017). Report out-of-sample AUC/R² for climate-only vs phylogeny-only vs full models.

### 2. Bridge to the mapped pattern: species → cell aggregation (Jetz & Rubenstein 2011 template)
- For each species-level model (phylogeny-only, present-only, past-only, present+past, full), average the predicted strategy probabilities over the species in each ≥10-species 500-km cell.
- Compare predicted with observed cell proportions using a multinomial deviance or Spearman r per strategy, weighted by N_j.
- The improvement from adding climate to the phylogeny-only model is the answer to "how much of the mapped variation does climate add beyond lineage".
- Lineage effects are fitted at species level, so the cell-level fit carries no extra pseudo-replication beyond what the null in §3 calibrates.

### 3. Cell-level models (needed for the maps and for a "space" fraction; interpret with nulls)
- **Response:** counts n_jk of classified species in strategy k in cell j; trials N_j. Use a multinomial or **Dirichlet-multinomial**. Do not model proportions with Dirichlet or beta regression (Douma & Weedon 2019).
- **Engines:**
  - brms `dirichlet_multinomial` with an `s(x, y)` or `gp()` or `car()` spatial term.
  - Or per-strategy binomial GAMs/GLMMs in mgcv (`bs = "sos"` on lon/lat) or spaMM (Matérn).
- **Blocks:**
  - **P** = present-climate PCs.
  - **H** = past climate: LGM anomaly, velocity, stability.
  - **S** = forward-selected MEMs (double stopping rule; Bauman et al. 2018) on the cell graph, or the spatial smooth.
  - **L** = lineage composition: the first PCPS axes from the cell × species matrix with the lycaenid tree (PCPS package), or the cell-mean "phylogenetic component" from a PVR/threshold-model decomposition (Diniz-Filho et al. 2007).
  - **C** = classification completeness (nuisance).
- **Partitioning:**
  - Commonality / variation partitioning with adjusted (or deviance-based, CV-based) R² for P, H, S and L.
  - Hierarchical partitioning (rdacca.hp, or glmm.hp for GLMMs) to allocate shared fractions.
  - Report the full 15-fraction commonality table. The shared P∩H∩S∩L fraction is expected to dominate and is a result, not a nuisance.
- **Calibration nulls:** recompute each fraction 999 times under each of:
  - (i) the free label-shuffle (Hawkins/Zelený): ranges fixed, strategies permuted among species;
  - (ii) a phylogenetically constrained shuffle: Mk-simulated or within-genus/tribe permutations;
  - (iii) MSR-randomised climate surfaces.
- **Reporting:** the observed fraction, the null 95% interval, and the standardised effect size. Also report the max-test / ter Braak parametric p (max of cell-level and species-level p) for each climate PC.
- **Out-of-sample explanatory power:** spatial-block CV (leave-one-realm-out and ~1,500-km blocks) for P-only, H-only, P+H, and P+H+S models. Report CV deviance explained.

### 4. Ant mediation (optional, secondary)
- **Mediator:** native ant richness (stacked known ranges, Kass et al. 2022, Dryad CC0) aggregated to 500-km cells.
- **Genus-specific mediators:** richness of key host genera (Myrmica, Formica, Camponotus, Crematogaster, Iridomyrmex, Oecophylla, Anoplolepis), built from per-species ranges in `results_sp_gen_data_add.zip`.
- **Model:** piecewise path model (climate → ant richness → strategy counts) with spatial random effects. Compare indirect vs direct paths with the same null calibration.
- **Avoid** the RF "undiscovered" surface (circular).
- Schultheiss et al. 2022 abundance gives biome-level density only (coordinates withheld).

### 5. Sensitivity checks (prioritised)
1. Minimum classified species per cell: 5, 10 (main), 20. Cell size: 250, 500 (main), 1,000 km. Equal Earth vs a hexagonal grid (dggridR).
2. Restrict to cells with classification completeness ≥ 0.5 (and ≥ 0.75). Add completeness as a covariate. Run "well-classified realms only" (Afrotropical south, Palaearctic, Australasia).
3. Clade jackknife: drop Lepidochrysops, Thestor, Phengaris/Maculinea, Aloeides, Chrysoritis one at a time, and drop each realm in turn.
4. Climate-source swaps: CHELSA vs WorldClim (present); TraCE21k (CCSM3) vs Beyer2020 (HadCM3) for the LGM; gradient vs analogue (backward) velocity; gradient floor 0.0001–0.01 °C/km; median vs mean of log velocity per cell.
5. Phylogenetic uncertainty (multiple trees) and alternative strategy codings (facultative merged with obligate mutualist; uncertain classifications excluded).
6. Spatial specification spread (Bini et al. 2009): OLS/GLM, SAR-error, MEM, spatial smooth, Matérn random effect. Report the coefficient and fraction range.

---

## Pitfalls to pre-empt (reviewer checklist)

1. **Structural (co-occurrence) bias of cell aggregates.**
   - Cell proportions share species. Spatial models (SAR, GWR) and RF/regression trees are among the most affected (Hawkins et al. 2017).
   - Never present cell-level R² without a label-shuffle null. Lead with species-level inference.
2. **Inflated Type I error of CWM-type tests** (Zelený & Schaffers 2012; Zelený 2018; Peres-Neto et al. 2017; Miller et al. 2019).
   - Use the max / modified permutation test or the ter Braak et al. (2018) parametric max-p.
3. **Phylogenetic pseudo-replication.**
   - Parasite and Cape clades are concentrated in a few genera. Without a phylogeny the effective sample size is a handful of radiations.
   - Use phylogenetic models and clade jackknifes. Report phylogenetic signal (α from phyloglm, or a D statistic).
4. **Niche conservatism makes climate and lineage collinear.**
   - Report shared fractions (Desdevises et al. 2003). Do not attribute shared variance to climate.
   - Jetz & Rubenstein (2011) explicitly note that predictor signal is "subsumed" in phylogeny.
5. **Present vs past climate collinearity.**
   - LGM anomaly and velocity correlate with latitude and present seasonality. Check VIFs and correlations at the cell level.
   - Report unique and shared fractions. Avoid selecting single "winning" variables.
   - Pre-register a small, fixed predictor set per block. AIC-driven MEM or eigenvector selection is invalid (Bauman et al. 2018).
6. **Spatial autocorrelation and coefficient instability.**
   - Show results across spatial specifications (Bini et al. 2009; Kissling & Carl 2008; Dormann et al. 2007).
   - Address the "spatial models are not always better" debate (Hawkins 2012; Kühn & Dormann 2012).
7. **Overfitting and optimistic R².**
   - Random CV is invalid with spatial and phylogenetic structure (Roberts et al. 2017; Ploton et al. 2020). Use spatial and phylogenetic block CV.
   - Note that block CV targets explanatory transferability, not map accuracy (Wadoux et al. 2021).
8. **Uneven classification coverage confounded with climate** (tropical vs temperate; Meyer et al. 2015).
   - Use the completeness covariate, completeness thresholds, multinomial weighting by N_j, and well-sampled-region subsets.
   - Make explicit that strategy proportions are among *classified* species.
9. **Modifiable areal unit and threshold choices.**
   - Test 250–1,000 km cells, the ≥10-species rule and grid type.
   - Velocity and stability must be computed at fine resolution, then aggregated (e.g. median log velocity). Never compute the gradient at 500 km.
10. **Velocity artefacts.**
    - Flat terrain → infinite velocity, so floor the gradient and log-transform.
    - Coastline and island edges and LGM ice and exposed shelves matter: TraCE21k includes paleo-orography and sea level, so mask cells that were ice-covered at the LGM or check their influence.
    - Use analogue (backward) velocity as a sensitivity check (Hamann et al. 2015; climetrics `dVe`).
11. **GCM dependence of palaeoclimate.**
    - A single GCM (CCSM3 TraCE) can drive results. Repeat with HadCM3-based Beyer2020/Krapp2021 (Garcia et al. 2014 on metric divergence).
12. **Circular mediators.**
    - Do not use model-predicted ant diversity surfaces built from climate as mediators. Use stacked known ranges.
    - Treat ant richness as itself climate- and history-structured (Economo et al. 2018).
13. **Compositional response handling.**
    - Proportions of four strategies sum to 1. Do not run four independent Gaussian models on transformed proportions.
    - Use multinomial or Dirichlet-multinomial, or nested binomial contrasts with an explicit reference category (Douma & Weedon 2019).
14. **Licensing and reproducibility.**
    - CHELSA-TraCE21k is CC BY-SA; Kass Dryad data are CC0; Beyer2020 and AI v3.1 are CC BY 4.0.
    - WorldClim and GABI release terms are not formally licensed; cite as requested.
    - VoCC is GitHub-only, so pin the commit (renv).
