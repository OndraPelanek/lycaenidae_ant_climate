# Climate summaries on the global Equal Earth grid: potential evapotranspiration and aridity,
# climate-change velocity and the aggregation of raster pixels to grid cells; used by
# s01_prepare_climate and s02_build_assemblages.

#' Extraterrestrial radiation for each latitude and month
#'
#' Daily extraterrestrial radiation on the 15th day of each month (FAO-56, Allen et al. 1998,
#' equations 21-25), expressed as the equivalent evaporation in mm per day (MJ m-2 day-1 x 0.408).
#' At polar latitudes the sunset hour angle is bounded at 0 and pi (polar night and day).
#' @param latitude Latitude in decimal degrees (vector).
#' @return Matrix with one row per latitude and 12 columns (months).
extraterrestrial_radiation <- function(latitude) {
  phi <- latitude * pi / 180
  doy <- c(15, 46, 74, 105, 135, 166, 196, 227, 258, 288, 319, 349)
  sapply(doy, function(j) {
    dr <- 1 + 0.033 * cos(2 * pi * j / 365)
    delta <- 0.409 * sin(2 * pi * j / 365 - 1.39)
    ws <- acos(pmin(pmax(-tan(phi) * tan(delta), -1), 1))
    ra <- 24 * 60 / pi * 0.0820 * dr *
      (ws * sin(phi) * sin(delta) + cos(phi) * cos(delta) * sin(ws))
    pmax(ra, 0) * 0.408
  })
}

#' Annual potential evapotranspiration by the Hargreaves equation
#'
#' Monthly PET = 0.0023 x Ra x (Tmean + 17.8) x sqrt(Tmax - Tmin) x days (Hargreaves & Samani
#' 1985), summed over the year. Tmean is the mean of Tmin and Tmax; negative monthly values
#' (very cold months) are set to zero.
#' @param tmin,tmax Matrices of monthly minimum and maximum temperature (degC), one row per
#'   pixel and 12 columns.
#' @param latitude Latitude of each pixel.
#' @return Annual PET in mm.
hargreaves_pet <- function(tmin, tmax, latitude) {
  stopifnot(ncol(tmin) == 12L, ncol(tmax) == 12L, nrow(tmin) == length(latitude))
  days <- c(31, 28.25, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
  ra <- extraterrestrial_radiation(latitude)
  tmean <- (tmin + tmax) / 2
  pet <- 0.0023 * ra * (tmean + 17.8) * sqrt(pmax(tmax - tmin, 0))
  pet <- pmax(pet, 0) * matrix(days, nrow(pet), 12L, byrow = TRUE)
  rowSums(pet)
}

#' Spatial gradient of a climate variable
#'
#' The local slope of the variable over a 3 x 3 neighbourhood, from `terra::terrain()`, which
#' treats the variable as an elevation surface and measures horizontal distances in metres on
#' the ellipsoid for longitude-latitude rasters. tan(slope) is therefore the change per metre.
#' @param x Single-layer SpatRaster in longitude-latitude.
#' @return SpatRaster of the gradient in units of the variable per km.
spatial_gradient <- function(x) {
  slope <- terra::terrain(x, v = "slope", unit = "radians", neighbors = 8)
  tan(slope) * 1000
}

#' Climate-change velocity
#'
#' Velocity (km per year) is the temporal change divided by the spatial gradient (Loarie et al.
#' 2009; Sandel et al. 2011). Gradients below `min_gradient` are raised to it, so that very flat
#' climates do not give infinite velocities.
#' @param anomaly SpatRaster of the change between the two times (same units as `present`).
#' @param present SpatRaster of the variable used for the spatial gradient.
#' @param years Number of years between the two times.
#' @param min_gradient Smallest gradient, in units of the variable per km.
#' @return SpatRaster with the layers `gradient` and `velocity` (km per year).
climate_velocity <- function(anomaly, present, years, min_gradient) {
  gradient <- spatial_gradient(present)
  velocity <- abs(anomaly) / years / terra::ifel(gradient < min_gradient, min_gradient, gradient)
  out <- c(gradient, velocity)
  names(out) <- c("gradient", "velocity")
  out
}

#' Assign raster pixels to cells of the global Equal Earth grid
#'
#' Pixel centres are projected to Equal Earth and assigned to `cell_km` square cells, with the
#' indices of `equal_area_species_cells()`. Each pixel is weighted by its area on the ground
#' (proportional to the cosine of its latitude in a longitude-latitude raster).
#' @param x SpatRaster in longitude-latitude; pixels without a value in any layer are dropped.
#' @param cell_km Cell side in km.
#' @return data.table with cell_x, cell_y, cell_id, weight and one column per layer of `x`.
pixels_to_cells <- function(x, cell_km) {
  d <- data.table::as.data.table(terra::as.data.frame(x, xy = TRUE, na.rm = FALSE))
  layer_values <- names(d)[-(1:2)]
  d <- d[rowSums(!is.na(d[, ..layer_values])) > 0]
  pts <- sf::st_as_sf(d[, .(x, y)], coords = c("x", "y"), crs = 4326)
  xy <- sf::st_coordinates(sf::st_transform(pts, global_equal_area_crs())) / 1000
  d[, `:=`(cell_x = as.integer(floor(xy[, 1] / cell_km)),
           cell_y = as.integer(floor(xy[, 2] / cell_km)),
           weight = cos(y * pi / 180))]
  d[, cell_id := paste(cell_x, cell_y, sep = ":")]
  d[]
}

#' Area-weighted summaries of pixel values in grid cells
#'
#' @param d Output of `pixels_to_cells()`.
#' @param variables Columns to summarise.
#' @param fun "mean" for area-weighted means, "median" for unweighted medians or "sd" for
#'   area-weighted standard deviations.
#' @param suffix Text appended to the output column names (none by default).
#' @return data.table with one row per cell.
summarise_cells <- function(d, variables, fun = "mean", suffix = "") {
  f <- switch(fun,
    mean = function(v, w) { k <- is.finite(v); sum(v[k] * w[k]) / sum(w[k]) },
    median = function(v, w) stats::median(v[is.finite(v)]),
    sd = function(v, w) {
      k <- is.finite(v)
      if (sum(k) < 2L) return(NA_real_)
      m <- sum(v[k] * w[k]) / sum(w[k])
      sqrt(sum(w[k] * (v[k] - m)^2) / sum(w[k]))
    })
  out <- d[, lapply(.SD, f, w = weight), by = cell_id, .SDcols = variables]
  data.table::setnames(out, variables, paste0(variables, suffix))
  out
}

#' Most common class of pixels in each grid cell, weighted by area
#' @param d Output of `pixels_to_cells()`.
#' @param variable Column with the class of each pixel.
#' @return data.table with cell_id, the majority class and its share of the cell's land area.
majority_class <- function(d, variable) {
  a <- d[!is.na(get(variable)), .(w = sum(weight)), by = c("cell_id", variable)]
  a[, share := w / sum(w), by = cell_id]
  a <- a[order(cell_id, -share)][!duplicated(cell_id)]
  data.table::setnames(a, c(variable, "share"), c(variable, paste0(variable, "_share")))
  a[, w := NULL][]
}
