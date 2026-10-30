# Writing

- [`climate_manuscript.Rmd`](climate_manuscript.Rmd): comprehensive working document: every analysis (s01–s34) with the details the paper has cut, the meaning of the results, alternative explanations, projects beyond the paper and the responses to the reviews. It is not a draft. It runs the paper draft's setup chunk, so the two documents share every number, all computed from the notebook outputs. Render it with `Rscript code/render_manuscript.R` (HTML and Word; close the Word file first).
- [`paper_draft.Rmd`](paper_draft.Rmd): the paper for *Global Ecology and Biogeography*, kept focused, with its Supporting Information in the same document.
- [`study_plan.md`](study_plan.md): the question and framing, the data assembled, results, the audit of the palaeoclimate layers, the response to the external review and the next steps.
- [`literature_review.md`](literature_review.md): the hypotheses on climate and the geography of interaction strategies, with their predictions for each strategy and what they imply for the design.
- [`literature/`](literature/): three annotated bibliographies (lycaenid and ant biogeography; theory on climate and interactions; methods and data), with DOIs and the PDFs available in `data/raw/literature/pdfs/`.

The bibliographies were compiled with AI assistance and their DOIs matched to Crossref; entries marked as unverified must be checked before they are cited. `docx_template.docx` and `caption_style.lua` are copied from `butterfly_ant_interactions` and control the Word styles.
