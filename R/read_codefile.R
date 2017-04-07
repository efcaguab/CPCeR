#' Read a CPC code file
#'
#' @param file
#' @param encoding
#' @param fileEncoding
#'
#' @return a list with two data frames describing the major and the minor categories
#' @export
#'
#' @examples
read_codefile <- function(file, encoding = "unknown", fileEncoding = "") {
  # object to be returned
  list(major_categ = data.frame(major_code = NULL,
                                major_name = NULL,
                                col = NULL),
       minor_categ = data.frame(minor_code = NULL,
                                minor_name = NULL,
                                major_code = NULL))
}
