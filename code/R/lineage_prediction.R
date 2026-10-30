# Out-of-sample prediction from binomial GAMs with random intercepts of lineage (subfamily,
# genus); used by s12_audit_evidence, s20_predict_held_out and s28_test_robustness.

#' Predicted probabilities that average over the random effects of unseen lineages
#'
#' `predict()` gives a genus or subfamily absent from the training data a random effect of 0,
#' the probability of a "typical" lineage, which on the logit scale is far from the average over
#' lineages when the random-effect variances are large. Here each held-out species gets the
#' average of the inverse logit over the distribution of the random effects it does not know:
#' the genus variance for an unseen genus, plus the subfamily variance for an unseen subfamily.
#' @param m A fitted binomial `gam` with `s(<term>, bs = "re")` smooths.
#' @param train Data the model was fitted to.
#' @param newdata Data to predict (with all factor levels of the model).
#' @param terms Names of the random-intercept terms.
#' @param n_nodes Number of equally spaced normal quantiles used for the average.
#' @return Vector of predicted probabilities.
predict_lineage <- function(m, train, newdata, terms = c("subfamily", "genus"), n_nodes = 201) {
  eta <- as.numeric(predict(m, newdata = newdata, type = "link"))
  # Random-effect standard deviations from the smoothing parameters (variance = scale / sp for
  # an identity penalty); this equals gam.vcomp() and also works when `sp` was fixed
  # (smooths are located through their labels; `sp` holds estimated smoothing parameters and is
  # empty when they were fixed, in which case they are in `full.sp`)
  labels <- vapply(m$smooth, function(s) s$label, character(1))
  sp_all <- if (length(m$sp)) m$sp else m$full.sp
  v <- numeric(length(eta))
  for (term in terms) {
    k <- match(paste0("s(", term, ")"), labels)
    sd <- sqrt(m$sig2 / sp_all[m$smooth[[k]]$first.sp])
    unseen <- !(as.character(newdata[[term]]) %in% as.character(unique(train[[term]])))
    v <- v + unseen * sd^2
  }
  z <- stats::qnorm(stats::ppoints(n_nodes))
  vapply(seq_along(eta), function(i) mean(stats::plogis(eta[i] + sqrt(v[i]) * z)), numeric(1))
}
