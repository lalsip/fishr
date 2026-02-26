#' Calculate Biomass Index
#'
#' Calculates biomass index from CPUE and area swept. Can optionally
#' compute CPUE from catch and effort data.
#'
#' @param cpue Numeric vector of CPUE values. If `catch` and `effort` are
#'   provided, this is computed automatically.
#'  @param catch Numeric vector of catch (e.g., kg)
#' @param area_swept Numeric vector of area swept (e.g., km²)
#' @inheritParams cpue.numeric
#' @inheritDotParams cpue.numeric -effort -catch
#' @param ... Additional arguments passed to 'cpue.numeric()'.
#'
#' @return A numeric vector of biomass index values
#' @export
#'
#' @examples
#' # From pre-computed CPUE
#' biomass_index(cpue = 10, area_swept = 5)
#'
#' # Compute CPUE on the fly
#' biomass_index(area_swept = 5, catch = 100, effort = 10)
#'
#' # Pass method through to cpue()
#' biomass_index(
#'   area_swept = 5,
#'   catch = c(100, 200),
#'   effort = c(10, 20),
#'   method = "log"
#' )
biomass_index <- function(
    cpue = NULL,
    area_swept,
    catch = NULL,
    effort = NULL,
    verbose=getOption("fishr.verbose", default=FALSE),
    ...
) {
  rlang::check_dots_used()

  if (is.null(cpue) && (!is.null(catch) && !is.null(effort))) {
    cpue <- cpue(catch, effort, verbose=verbose, ...)
  }

  if (is.null(cpue)) {
    stop("Must provide either 'cpue' or both 'catch' and 'effort'.")
  }

  validate_numeric_inputs(cpue = cpue, area_swept = area_swept)

  cpue * area_swept
}
