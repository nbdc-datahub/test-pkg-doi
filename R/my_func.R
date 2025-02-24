
#' My function
#' @description This function takes a number and returns its square.
#' @param x numeric, length 1. The number to be squared.
#'
#' @return numeric, length 1. The square of x.
#' @export
#'
#' @examples
#' my_function(3)
my_function <- function(x) {
  chk_number(x)
  return(x^2)
}




