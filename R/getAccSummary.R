

#' Title
#'
#' @param url
#' @param token
#'
#' @return
#' @export
#'
getAccountSummary <- function(url, token) {

  r <-
    httr::GET(
      paste0(
        url,
        "/GetAccountSummary"
        ),
      httr::add_headers(AOToken = token)
      ) %>%
    httr::content("parsed")

    r[["Result"]]
}
