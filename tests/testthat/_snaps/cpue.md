# cpue provides informative message when verbose

    Code
      cpue(c(100, 200), c(10, 20), verbose = TRUE)
    Message
      Processing 2 records using ratio method
    Output
      [1] 10 10

# cpue error message is informative

    Code
      cpue("not a number", 10)
    Condition
      Error in `catch / effort`:
      ! non-numeric argument to binary operator

# cpue produces no warnings with valid input

    Code
      cpue(catch = c(100, 200, 300), effort = c(10, 20))
    Condition
      Warning in `catch / effort`:
      longer object length is not a multiple of shorter object length
    Output
      [1] 10 10 30

