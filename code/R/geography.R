# Presence cells on the global Equal Earth grid (as in butterfly_ant_interactions); used by
# s01_prepare_climate and s02_build_assemblages.


#' Build a species-by-cell presence table on an equal-area grid
#'
#' Each species contributes at most once to a cell, irrespective of how many
#' occurrence records were retained there. The grid uses the repository's
#' global Equal Earth projection, so cells have a common area and do not become
#' narrower towards the poles.
#' @param occurrences Named list of occurrence data frames with longitude and
#'   latitude columns.
#' @param cell_km Nominal square-cell width in kilometres.
#' @return Data frame with one row per occupied species-cell combination.
equal_area_species_cells <- function(occurrences, cell_km = 200) {
  stopifnot(is.list(occurrences), !is.null(names(occurrences)),
            length(cell_km) == 1L, is.finite(cell_km), cell_km > 0)
  rows <- lapply(names(occurrences), function(species) {
    x <- occurrences[[species]]
    if (!nrow(x)) return(NULL)
    data.frame(
      species = species,
      decimalLongitude = x$decimalLongitude,
      decimalLatitude = x$decimalLatitude,
      stringsAsFactors = FALSE
    )
  })
  points <- do.call(rbind, rows)
  points <- project_occurrences(points)
  points$cell_x <- floor(points$easting_km / cell_km)
  points$cell_y <- floor(points$northing_km / cell_km)
  points$cell_id <- paste(points$cell_x, points$cell_y, sep = ":")
  points <- points[!duplicated(points[c("species", "cell_id")]), ]
  cell_centres <- unique(points[c("cell_id", "cell_x", "cell_y")])
  centres_sf <- sf::st_as_sf(
    data.frame(
      cell_id = cell_centres$cell_id,
      # `project_occurrences()` stores projected coordinates in kilometres,
      # whereas the Equal Earth CRS is defined in metres. Convert the cell
      # centres back to metres before the inverse projection to WGS84.
      easting_m = (cell_centres$cell_x + 0.5) * cell_km * 1000,
      northing_m = (cell_centres$cell_y + 0.5) * cell_km * 1000
    ),
    coords = c("easting_m", "northing_m"), crs = global_equal_area_crs()
  )
  centre_coordinates <- sf::st_coordinates(sf::st_transform(centres_sf, 4326))
  cell_centres$cell_longitude <- centre_coordinates[, 1]
  cell_centres$cell_latitude <- centre_coordinates[, 2]
  points <- merge(points, cell_centres, by = c("cell_id", "cell_x", "cell_y"),
                  all.x = TRUE, sort = FALSE)
  points[, c("species", "cell_id", "cell_x", "cell_y",
             "easting_km", "northing_km", "decimalLongitude",
             "decimalLatitude", "cell_longitude", "cell_latitude")]
}
