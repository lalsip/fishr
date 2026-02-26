#' Calculate Catch Per Unit Effort (CPUE)
#'
#' Calculates CPUE from catch and effort data, with optional gear
#' standardization. Supports ratio and log-transformed methods.
#'
#' @rdname cpue
#'
#' @param catch numeric vector of catch (e.g. kg)
#' @param effort Numeric vector of effort (e.g., hours)
#' @param gear_factor Numeric scalar for gear standardization (default 1)
#' @param method Character; one of `"ratio"` (default) or `"log"`.
#' @param verbose Logical; print processing info? Default from
#'   `getOption("fishr.verbose", FALSE)`.
#'
#' @return A numeric vector of CPUE values
#' @export
#'
#' @examples
#' cpue(100, 10)
#' cpue(c(100, 200), c(10, 20), method = "log")
cpue.numeric <- function(
    catch,
    effort,
    gear_factor = 1,
    method = c("ratio", "log"),
    verbose = getOption("fishr.verbose", FALSE),
    ...
) {
  method <- match.arg(method)

  validate_numeric_inputs(catch = catch, effort = effort)

  if (verbose) {
    message("Processing ", length(catch), " records using ", method, " method")
  }

  raw_cpue <- switch(
    method,
    ratio = catch / effort,
    log = log(catch / effort)
  )

  new_cpue_result(
    values = raw_cpue * gear_factor,
    method = method,
    gear_factor = gear_factor,
    n_records = length(catch)
  )
}

#' @rdname cpue
#' @export
cpue.data.frame <- function(
    catch,
    gear_factor = 1,
    method = c("ratio", "log"),
    verbose = getOption("fishr.verbose", FALSE),
    ...
) {
  if (!"catch" %in% names(catch)) {
    stop("Column 'catch' not found in data frame.", call. = FALSE)
  }
  if (!"effort" %in% names(catch)) {
    stop("Column 'effort' not found in data frame.", call. = FALSE)
  }

  # We can then call the numeric method by extracting the relevant columns and passing them to cpue() again.
  # This way we reuse the existing logic and maintain a single source of truth for the CPUE calculation.
  cpue(
    catch = catch[["catch"]],
    effort = catch[["effort"]],
    gear_factor = gear_factor,
    method = method,
    verbose = verbose,
    ...
  )
}

#' @rdname cpue
#' @export
cpue.default <- function(catch, ...) {
  stop("Unsupported input type for cpue(): ", class(catch), call. = FALSE)
}
