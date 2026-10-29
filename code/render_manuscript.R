# Render the working manuscript and the paper draft (Word and HTML) into writing/ from the notebook outputs; nothing
# is recomputed. Run from the repository root: Rscript code/render_manuscript.R
# Close the Word document before rendering, otherwise it cannot be overwritten.

# Pandoc ships with RStudio; outside RStudio, use its bundled copy when none is on the PATH.
if (!rmarkdown::pandoc_available() && .Platform$OS.type == "windows") {
  candidate <- "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools"
  if (file.exists(file.path(candidate, "pandoc.exe"))) Sys.setenv(RSTUDIO_PANDOC = candidate)
}
if (!rmarkdown::pandoc_available()) stop("Pandoc is required; set RSTUDIO_PANDOC to its directory.")

reports <- here::here("writing", c("climate_manuscript.Rmd", "paper_draft.Rmd"))
for (report in reports) for (format in c("bookdown::word_document2", "bookdown::html_document2")) {
  rmarkdown::render(report, output_format = format, quiet = TRUE,
                    envir = new.env(parent = globalenv()))
}
