test_that("cpue calculates simple ratio correctly", {
  expect_equal(cpue(catch = 100, effort = 10), 10)
  expect_equal(cpue(catch = 50, effort = 2), 25)
})
test_that("cpue handles vectors of data", {
  catches <- c(100, 200, 300)
  efforts <- c(10, 10, 10)
  expected_results <- c(10, 20, 30)

  expect_equal(cpue(catches, efforts), expected_results)
})

# test optional arguments
test_that("gear_factor standardization scales correctly", {
  expect_equal(cpue(catch = 100, effort = 10, gear_factor = 0.5), 5)
  expect_equal(
    cpue(catch = 100, effort = 10),
    cpue(catch = 100, effort = 10, gear_factor = 1)
  )
})

# test edge cases
test_that("cpue handles missing data", {
  expect_true(is.na(cpue(NA_real_, 10)))
  expect_true(is.na(cpue(100, NA_real_)))
})

test_that("cpue works with generated data") {
  data <- generate_fishing_data(n=5)

  results<-cpue(data$catch, data$effort) #run data and results to get the numbers for expect_equal

  expect_equal(results, c(34.05, 9.06, 19.24, 135.64, 6.37),
               tolerance=1e-2)
}

test_that("cpue matches reference data", {
  result <- cpue(reference_data$catch, reference_data$effort)

  expect_equal(result, reference_data$expected_cpue)
})
