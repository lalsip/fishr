#' Calculate Catch Per Unit Effort (CPUE)
#'
#' Calculates CPUE from catch and effort data, with optional gear
#' standardization. Supports ratio and log-transformed methods.
#'
#' @param catch Numeric vector of catch (e.g., kg)
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
cpue <- function(
    catch,
    effort,
    gear_factor = 1,
    method = c("ratio", "log"),
    verbose = getOption("fishr.verbose", FALSE)
) {
  method <- match.arg(method) #mmust be one of ratio or log or itll throw error

  if (verbose) {
    message("Processing ", length(catch), " records using ", method, " method")
  }

  raw_cpue <- switch( #depending on value of method, do different thing
    method,
    ratio = catch / effort,
    log = log(catch / effort)
  )

  raw_cpue * gear_factor
}
