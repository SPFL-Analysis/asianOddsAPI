

#' Title
#'
#' @param url
#' @param token
#' @param sport
#'
#' @return
#' @export
#'
#' @examples
getSportsId <- function(url, token, sport = "Football") {

  r <-
    httr::GET(
      paste0(
        url,
        "/GetSports"
        ),
      httr::add_headers(AOToken = token)
      ) %>%
    httr::content("parsed")

    purrr::map_dfr(
      r$Data,
      ~data.frame(
        sportName = .x[["Name"]],
        sportId = .x[["Id"]],
        stringsAsFactors = F)
      ) %>%
      dplyr::filter(sportName == sport) %>%
      dplyr::pull(sportId)
}
