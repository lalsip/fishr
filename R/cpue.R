#' Calculate Catch per unit Effort (CPUE)
#'
#' @param catch Numeric vector of catch (e.g., kg)
#' @param effort Numeric vector of effort (e.g., hours)
#' @param gear_factor Numeric adjusment fo gear standardization (default is 1)
#'
#' @returns A numeric vector of CPUE values
#' @export
#'
#' @examples
#' cpue(100,10)
#' cpue(100,10,gear_factor=0.5)
#'
cpue <- function(
    catch,
    effort,
    gear_factor = 1,
    method = c("ratio", "log"),
    verbose = getOption("fishr.verbose", FALSE)
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

  raw_cpue * gear_factor
}
