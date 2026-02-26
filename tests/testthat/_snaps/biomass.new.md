# biomass_index throws error on invalid input

    Code
      biomass_index("ten", 5)
    Condition
      Error:
      ! 'cpue' must be numeric, got character.

---

    Code
      biomass_index(10, "five")
    Condition
      Error:
      ! 'area_swept' must be numeric, got character.

# biomass_index uses verbosity when set as an option

    Code
      biomass_index(cpue = 5, area_swept = 100)
    Output
      [1] 500

