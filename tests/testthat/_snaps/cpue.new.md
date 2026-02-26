# cpue uses verbosity when option set to TRUE

    Code
      cpue(100, 10)
    Message
      Processing 1 records using ratio method
    Output
      CPUE Results for 1 records
      Method: ratio 
      Gear factpr: 1 
      Values: 10 

# cpue error message is informative

    Code
      cpue("not a number", 10)
    Condition
      Error:
      ! 'catch' must be numeric, got character.

# cpue produces no warnings with valid input

    Code
      cpue(catch = c(100, 200, 300), effort = c(10, 20))
    Condition
      Warning in `catch / effort`:
      longer object length is not a multiple of shorter object length
    Output
      CPUE Results for 3 records
      Method: ratio 
      Gear factpr: 1 
      Values: 10 10 30 

