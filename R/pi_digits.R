#' Compute Digits of Pi
#'
#' Compute the first n digits of pi using arbitrary precision arithmetic.
#' Results are memoised so repeated calls for the same n are instantaneous.
#'
#' @param n Integer. Number of digits of pi to return after the decimal point.
#' @param type Character. Output type: "char", "numeric", or "mpfr".
#'
#' @return A character string, numeric value, or mpfr object depending on `type`.
#'
#' @importFrom memoise memoise
#' @importFrom Rmpfr Const asNumeric formatMpfr
#'
#' @examples
#' pi_digits(10)
#' pi_digits(50)
#' pi_digits(20, type = "numeric")
#'
#' @export
pi_digits <- memoise::memoise(function(n, type = c("char", "numeric", "mpfr")) {
    type <- match.arg(type)

    if (!is.numeric(n) || length(n) != 1 || n <= 0) {
        stop("n must be a positive integer.")
    }

    n <- as.integer(n)

    # convert decimal digits → bits of precision
    bits <- ceiling(n * log2(10))

    # compute pi with mpfr
    p <- Rmpfr::Const("pi", prec = bits)

    if (type == "mpfr") {
        return(p)
    }

    if (type == "numeric") {
        return(Rmpfr::asNumeric(p))
    }

    # character output
    raw <- Rmpfr::formatMpfr(p, digits = n + 1)
    frac <- strsplit(raw, "\\.")[[1]][2]
    frac <- substr(frac, 1, n)

    paste0("3.", frac)
})
