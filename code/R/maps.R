# Equal Earth cell polygons and the map style of the butterfly_ant_interactions figures;
# used by all notebooks.

#' Convert equal-area Equal Earth cells to map polygons
#'
#' Cells of `cell_km` x `cell_km` in the Equal Earth projection all have the same area on
#' the ground (unlike longitude-latitude cells, which shrink towards the poles). Cell indices
#' are those of `equal_area_species_cells()`: the lower-left corner is `cell_x * cell_km` km
#' east and `cell_y * cell_km` km north in the projection.
#' @param cells Data frame with integer columns `cell_x` and `cell_y`; other columns are kept.
#' @param cell_km Cell side in km (the value used to create the indices).
#' @return sf polygons in the Equal Earth CRS of `global_equal_area_crs()`.
equal_area_cell_polygons <- function(cells, cell_km = 250) {
  stopifnot(all(c("cell_x", "cell_y") %in% names(cells)), is.finite(cell_km), cell_km > 0)
  s <- cell_km * 1000

  # One closed square (five corners, starting at the lower-left one) per cell
  geometries <- lapply(seq_len(nrow(cells)), function(i) {
    x0 <- cells$cell_x[i] * s
    y0 <- cells$cell_y[i] * s
    sf::st_polygon(list(rbind(c(x0, y0), c(x0 + s, y0), c(x0 + s, y0 + s),
                              c(x0, y0 + s), c(x0, y0))))
  })
  sf::st_sf(cells, geometry = sf::st_sfc(geometries, crs = global_equal_area_crs()))
}

#' Prepare land and gridded data for publication maps
#'
#' The cells are transformed to Equal Earth and clipped to land, so that coastal
#' cells do not colour the sea. Unoccupied land remains grey and the panel
#' background supplies the light-blue ocean.
#' @param cells sf polygons of the 500-km Equal Earth cells (e.g. from
#'   `equal_area_cell_polygons()`).
#' @return A list with projected `cells` and `land` layers.
map_layers <- function(cells) {
  # Land and cells in the Equal Earth projection
  target <- global_equal_area_crs()
  land <- rnaturalearth::ne_countries(scale = "small", returnclass = "sf")
  land <- sf::st_make_valid(sf::st_transform(land[, "geometry"], target))
  cells <- sf::st_make_valid(sf::st_transform(cells, target))

  # Unioning first avoids duplicating coastal grid fragments at country borders.
  clipped <- suppressWarnings(sf::st_intersection(cells, sf::st_union(land)))
  list(cells = clipped, land = land)
}

#' Draw one publication map in Equal Earth
#'
#' @param layers Output from `map_layers()`.
#' @param variable Column in `layers$cells` to map.
#' @param title Legend title.
#' @param palette Colours of the sequential scale, or low, mid and high colours of a
#'   diverging scale.
#' @param trans Scale transformation, usually `identity` or `log10`.
#' @param midpoint Optional midpoint for a diverging scale.
#' @param limits Optional limits of the colour scale; values outside them take the end colour.
#' @param breaks Optional scale breaks; defaults to ggplot2's automatic choice.
#' @param labels Optional labels for `breaks` (sequential scale only), e.g. to mark a truncated
#'   end ("≤ 0.5") when values outside `limits` are squished onto it.
#' @return A ggplot object.
plot_grid_map <- function(layers, variable, title, palette,
                          trans = "identity", midpoint = NULL, limits = NULL,
                          breaks = ggplot2::waiver(), labels = ggplot2::waiver()) {
  # Cells with a finite value (and a positive one on a log scale)
  values <- layers$cells[[variable]]
  keep <- is.finite(values) & (trans != "log10" | values > 0)
  cells <- layers$cells[keep, , drop = FALSE]
  cells$value <- cells[[variable]]

  # Colour scale: sequential, or diverging when a midpoint is given
  scale <- if (is.null(midpoint)) {
    ggplot2::scale_fill_gradientn(
      colours = palette,
      trans = trans, limits = limits, breaks = breaks, labels = labels,
      oob = scales::squish, name = title,
      na.value = NA,
      guide = ggplot2::guide_colourbar(title.position = "top", title.hjust = 0.5,
                                       barwidth = grid::unit(35, "mm"),
                                       barheight = grid::unit(3, "mm")))
  } else {
    ggplot2::scale_fill_gradient2(
      low = palette[1], mid = palette[2], high = palette[3],
      midpoint = midpoint, limits = limits, oob = scales::squish,
      breaks = breaks, name = title, na.value = NA,
      guide = ggplot2::guide_colourbar(title.position = "top", title.hjust = 0.5,
                                       barwidth = grid::unit(35, "mm"),
                                       barheight = grid::unit(3, "mm")))
  }

  # Grey land, the cells on top of it, then the country outlines
  ggplot2::ggplot() +
    ggplot2::geom_sf(data = layers$land, fill = "grey55", colour = "grey35",
                     linewidth = 0.08) +
    ggplot2::geom_sf(data = cells, ggplot2::aes(fill = value), colour = NA) +
    ggplot2::geom_sf(data = layers$land, fill = NA, colour = "grey25", linewidth = 0.08) +

    # Colour scale, projection and axis labels
    scale +
    ggplot2::coord_sf(crs = global_equal_area_crs(), expand = FALSE,
                      label_axes = list(bottom = "E", left = "N")) +
    ggplot2::labs(x = NULL, y = NULL) +

    # Minimal theme with a light-blue ocean and a colour bar above the map
    ggplot2::theme_minimal(base_size = 9) +
    ggplot2::theme(
      panel.background = ggplot2::element_rect(fill = "#ADD8E6", colour = NA),
      panel.grid.major = ggplot2::element_line(colour = "white", linewidth = 0.2),
      panel.grid.minor = ggplot2::element_blank(),

      legend.position = "top",
      legend.title = ggplot2::element_text(size = 8),
      legend.text = ggplot2::element_text(size = 7),

      axis.title = ggplot2::element_text(size = 8),
      axis.text = ggplot2::element_blank(),
      axis.ticks = ggplot2::element_blank(),

      plot.margin = ggplot2::margin(2, 3, 2, 3)
    )
}
