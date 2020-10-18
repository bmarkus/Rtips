# Library Dev

1. https://r-pkgs.org/whole-game.html

# Workflow
```R
# steps for building the pkg
create_package(...)

use_gpl3_license('Barak')

# declare the use of dplyr
use_package("dplyr")

use_testthat()

# create R file
use_r("filename.R")
Code > Insert roxygen skeleton

# tests
use_test("filename.R")

# check()
check(cran = F)

# Document
document()

# LOad from outside
load_all("lib-path")
```


# General issues

## Help

### Inserting tables in help text
https://stackoverflow.com/questions/42813243/insert-markdown-table-in-roxygen2-r-package-documentation
(note the use the @md tag)

## devtools
1. __devtools::check__ failing to detect installed pck: https://github.com/r-lib/devtools/issues/2044. I use check(cran = F)
2. more ...

## tidyverse

### Using pipe in library functions
   1. https://stackoverflow.com/questions/27947344/r-use-magrittr-pipe-operator-in-self-written-package

### No visible binding for global variable

1. https://www.r-bloggers.com/2019/08/no-visible-binding-for-global-variable/
2. https://rlang.r-lib.org/reference/tidyeval-data.html

```R
#' @importFrom rlang .data
my_fn <- function() {
  mtcars %>% 
    mutate(mpg_div_hp = .data$mpg / .data$hp)
}
```

