# Dry-niche test, version 2: declaration before analysis

Written on 30 October 2026, after the results of version 1 (`code/s36_test_dry_niche.Rmd`) were known and before any model of version 2 (`code/s37_test_dry_niche_v2.Rmd`) was fitted. Version 1 stays in the record as the pre-specified test; version 2 is reported whatever it shows.

## What version 1 found, and why version 2 exists

Version 1 (pre-specified primary: dry months given temperature) gave a pooled difference between obligate mutualists and facultative congeners of 0.80 log relative intensity per SD (95% interval −0.11 to 1.71; 5 of 8 genera positive), "no convincing support" under its own rules. With 8 genera, its minimum detectable difference (80% power) was about 1.3 per SD: the test was underpowered. Most of the uncertainty came from contrasts resting on one or two species of a strategy, and from unstable slopes of narrow-ranged species. Version 2 changes the design to address these causes, not to change the result.

## Changes, each with its reason

1. **Primary measure for H1: dry months alone.** The proposal's H1 concerns occupancy of seasonally dry environments (dry-season duration); temperature enters the proposal "to distinguish moisture-related associations from thermal gradients", which is H3. Version 2 therefore tests H1 with dry months alone and H3 with dry months given temperature, months below 50 mm given temperature (a dry-season length that does not depend on temperature) and temperature alone. **Disclosure: this choice was made after seeing version 1, in which dry months alone was the one measure whose pooled interval excluded zero (0.95, 0.19 to 1.71). It is a post hoc change of the primary measure, and is reported as such.**
2. **GBIF supplementation of occurrences (allowed by the proposal).** Each species' occupied pixels are its cleaned-record pixels plus the pixels holding its own GBIF records (same bases of record and years) within 100 km of a cleaned-record pixel and in the same accessible area. The distance limit keeps out records far from the cleaned range (misplaced coordinates, introductions). Eligibility (at least 20 occupied pixels per accessible area) is applied to the supplemented pixels.
3. **One contrast per origin of obligate mutualism (H2).** Within each accessible area: every genus with eligible mutualists and eligible facultative species forms a contrast (as in version 1). For a genus with eligible mutualists but no eligible facultative congeners, the comparison group is the eligible facultative species of the smallest clade on the tree of genera that contains the genus and at least one such species, provided the clade stays within one subfamily; the contrast includes every eligible mutualist of that clade not already in a contrast. Contrasts that share species are merged. Contrasts of the same mutualist genera in different areas are combined into one estimate per origin, as in version 1.
4. **A single joint model.** All species-area units in one inhomogeneous Poisson point-process model (infinitely weighted logistic regression, `mgcv::bam`): fixed intercepts per unit; fixed slopes of the measure for facultative species and for the mutualist-minus-facultative difference; random slopes per unit (species), per origin, and a random mutualist-minus-facultative difference per origin. Quadrature: 2,000 background pixels per unit, drawn with probability proportional to the background weight. Temperature enters only in the H3 models.

## Unchanged from version 1

Accessible areas (realms on glacial-shelf landmasses), the three backgrounds (all-butterfly records with the species' own records removed and capped at the 95th percentile; recorded pixels weighted equally; all land), standardisation over the land of the eight regions, 10-arc-minute pixels, obligate mutualists against facultative species only.

## Inference and outcome rules

- **Primary estimate:** the joint-model coefficient of the mutualist-minus-facultative difference in the slope of dry months, against the all-butterfly background.
- **Intervals:** model-based 95% interval from the joint model, and a cluster bootstrap over origins (199 resamples of origins with replacement, percentile interval).
- **Strong support:** both 95% intervals above zero for the all-butterfly background; positive point estimates under the other two backgrounds; a positive two-stage difference in at least two thirds of origins; and a positive joint estimate when each origin is left out.
- **Lineage-specific support:** at least one origin with a two-stage 95% interval above zero, but the criteria of strong support not met.
- **No convincing support:** otherwise.

## Also reported

The two-stage comparison (as in version 1) on the version 2 data; the step-by-step decomposition (version 1 data with the joint model; adding supplementation; adding origin contrasts); the H3 measures; leave one origin out.
