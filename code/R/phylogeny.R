# Reading, pruning and genus-grafting of the published trees, copied from
# butterfly_ant_interactions (code/R/phylogeny.R and the grafting function of
# s04_fit_models.Rmd); used by s04_fit_phylogenetic_models.

#' Read one published phylogeny without changing it
#'
#' The file extension determines whether `ape::read.nexus()` or
#' `ape::read.tree()` is used. Multi-tree files are rejected because each
#' study contributes one published tree.
#' @param path Path to a Newick or NEXUS tree.
#' @return An object of class `phylo`.
read_published_tree <- function(path) {
  if (!file.exists(path)) stop("Tree file not found: ", path)
  extension <- tolower(tools::file_ext(path))
  first_line <- readLines(path, n = 1L, warn = FALSE)
  nexus_content <- length(first_line) && grepl(
    "^[[:space:]]*#NEXUS", first_line, ignore.case = TRUE
  )
  tree <- if (extension %in% c("nex", "nexus") || nexus_content) {
    ape::read.nexus(path)
  } else {
    ape::read.tree(path)
  }
  if (inherits(tree, "multiPhylo")) {
    stop("Expected one published tree, but the file contains ", length(tree), ".")
  }
  if (!inherits(tree, "phylo")) stop("File did not parse as one phylo object: ", path)
  tree
}

#' Prune a published tree to analysis species and relabel its tips
#'
#' @param tree Published phylogeny.
#' @param crosswalk Curated one-to-one crosswalk for the tree.
#' @param species_names Analysis species names to retain.
#' @param branch_treatment Published branch lengths, Grafen lengths calculated
#'   after pruning, or Grafen lengths calculated on the complete source tree
#'   before pruning.
#' @return A `phylo` whose tip labels equal the analysis species names.
prepare_analysis_tree <- function(
    tree, crosswalk, species_names,
    branch_treatment = c("published", "grafen", "grafen_full")) {
  branch_treatment <- match.arg(branch_treatment)
  map <- crosswalk[
    crosswalk$matched & crosswalk$analysis_species %in% species_names,
    c("analysis_species", "tree_tip_original"), drop = FALSE
  ]
  map <- map[match(species_names, map$analysis_species), , drop = FALSE]
  if (anyNA(map$tree_tip_original) || anyDuplicated(map$tree_tip_original) ||
      anyDuplicated(map$analysis_species)) {
    stop("Tree preparation requires a complete one-to-one crosswalk.")
  }
  source_tree <- tree
  if (branch_treatment == "grafen_full") {
    source_tree <- ape::compute.brlen(source_tree, method = "Grafen", power = 1)
  }
  output <- ape::drop.tip(
    source_tree, setdiff(source_tree$tip.label, map$tree_tip_original)
  )
  replacement <- map$analysis_species[match(output$tip.label, map$tree_tip_original)]
  if (anyNA(replacement)) stop("A retained tree tip could not be relabelled.")
  output$tip.label <- replacement
  if (branch_treatment == "grafen") {
    output <- ape::compute.brlen(output, method = "Grafen", power = 1)
  }
  if (!setequal(output$tip.label, species_names) ||
      ape::Ntip(output) != length(species_names)) {
    stop("Tree and model rows are not one-to-one after pruning.")
  }
  output
}

#' Graft analysed species that are missing from a tree onto their genus
#'
#' Species are added in alphabetical order. A species whose genus has two or
#' more tips is attached at the most recent common ancestor of its congeners
#' (a polytomy at the genus node, as in `phytools::add.species.to.genus(where =
#' "root")`, but matching genera exactly at the start of the label); a species
#' whose genus has one tip becomes its sister, splitting that tip's branch at
#' its midpoint. The tree is made ultrametric first (`force.ultrametric`,
#' method "extend") if necessary, and new branches keep it ultrametric.
#' Species of genera absent from the tree are not grafted.
#' @param tree Ultrametric `phylo` tree whose tip labels are analysis names
#'   (`Genus_species`).
#' @param species Analysis names that should be on the tree.
#' @param genus_map Optional named character vector (analysis name -> genus) giving the
#'   genus of tips and of species to graft, for names whose current genus differs from the
#'   genus in the name (revised classification). Names not in the map use the genus at the
#'   start of the label.
#' @return The grafted tree; attribute `grafted` lists the added species.
graft_species_to_genus <- function(tree, species, genus_map = NULL) {
  # Make the tree ultrametric if it is not
  if (!ape::is.ultrametric(tree))
    tree <- phytools::force.ultrametric(tree, method = "extend")

  # Genus of tip labels or species names: the genus map where it has an entry, else the
  # genus at the start of the name
  genus_of <- function(x) {
    g <- sub("_.*", "", x)
    if (!is.null(genus_map)) {
      m <- unname(genus_map[x])
      g[!is.na(m)] <- m[!is.na(m)]
    }
    g
  }

  # --- Graft the missing species in alphabetical order ---
  grafted <- character()
  for (s in sort(setdiff(species, tree$tip.label))) {
    # Species of genera absent from the tree are skipped
    ii <- which(genus_of(tree$tip.label) == genus_of(s))
    if (!length(ii)) next

    if (length(ii) > 1L) {
      # Two or more congeners: polytomy at their most recent common ancestor
      node <- phytools::findMRCA(tree, tree$tip.label[ii])
      tree <- phytools::bind.tip(tree, s, where = node)
    } else {
      # One congener: sister to it, splitting its branch at the midpoint
      half <- 0.5 * tree$edge.length[tree$edge[, 2] == ii]
      tree <- phytools::bind.tip(tree, s, where = ii, position = half)
    }
    grafted <- c(grafted, s)
  }

  # The grafted species are recorded as an attribute
  attr(tree, "grafted") <- grafted
  tree
}
