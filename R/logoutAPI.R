

#' Title
#'
#' @param url
#' @param token
#'
#' @return
#' @export
#'
#' @examples
logoutAPI <- function(url, token) {
  
  r <-
    httr::GET(
      paste0(
        url,
        "/Logout"
      ),
      httr::add_headers(AOToken = token)
    ) %>%
    httr::content("parsed")
  
}
