

<!-- README.md is generated from README.qmd. Please edit that file -->

# pidigits

<!-- badges: start -->

<!-- badges: end -->

**pidigits** provides an arbitrary-precision helper function,
`pi_digits()`, for computing decimal digits of $\pi$ in R.

Under the hood, calculations are powered by GNU MPFR via the
[Rmpfr](https://cran.r-project.org/package=Rmpfr) library. Results are
automatically cached with
[memoise](https://cran.r-project.org/package=memoise), ensuring that
repeated queries for the same precision are instantaneous.

## Features

- **Arbitrary Precision**: Compute dozens, hundreds, or thousands of
  decimal digits of $\pi$.
- **Flexible Return Types**:
  - `"char"` (default): Returns a character string (`"3.14159..."`),
    ensuring exact digits are preserved without floating-point
    truncation.
  - `"numeric"`: Converts the result to standard R 64-bit double
    precision.
  - `"mpfr"`: Returns an `Rmpfr` arbitrary-precision object for
    downstream mathematical operations.
- **Automatic Memoisation**: Results are cached in memory so subsequent
  calls for the same $n$ take zero computation time.

## Installation

You can install the development version of pidigits from
[GitHub](https://github.com/jkylearmstrong/pidigits) with:

``` r
# install.packages("pak")
pak::pak("jkylearmstrong/pidigits")
```

## Quick Start

``` r
library(pidigits)

# First 10 decimal digits (as character string)
pi_digits(10)
#> [1] "3.1415926537"

# 50 decimal digits
pi_digits(50)
#> [1] "3.14159265358979323846264338327950288419716939937510"

# Return as standard R double numeric
pi_digits(20, type = "numeric")
#> [1] 3.141593

# Return as an Rmpfr arbitrary precision object
pi_digits(50, type = "mpfr")
#> 1 'mpfr' number of precision  167   bits 
#> [1] 3.141592653589793238462643383279502884197169399375101
```

## Memoisation in Action

Because `pi_digits()` is memoised, repeated calls for the same digit
length return instantly from the cache:

``` r
# Initial computation (computes and caches)
system.time(pi_digits(2000))
#>    user  system elapsed 
#>       0       0       0

# Second call (instant cache hit)
system.time(pi_digits(2000))
#>    user  system elapsed 
#>       0       0       0
```

## Development

`README.md` is generated from `README.qmd`. To regenerate `README.md`,
run:

``` r
devtools::build_readme()
```

or render with Quarto:

``` bash
quarto render README.qmd
```
