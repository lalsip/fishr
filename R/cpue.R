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
cpue <- function(catch, effort, gear_factor = 1, verbose=FALSE) {
  if (verbose) {
    message("Processing", length(catch), " records")
  }
  raw_cpue <- catch / effort

  raw_cpue * gear_factor

}


