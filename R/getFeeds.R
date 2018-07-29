

#' Title
#'
#' @param url
#' @param token
#' @param leagueId
#' @param sportsType
#' @param marketTypeId
#' @param oddsFormat
#'
#' @return
#' @export
#'
#' @examples
getFeeds <- function(url, token, leagueId,
                     sportsType = 1, marketTypeId = 2,
                     oddsFormat = "00") {

    httr::GET(paste0(url, "/GetFeeds"),
              query = list(
                leagues = leagueId,
                sportsType = sportsType,
                marketTypeId = marketTypeId,
                oddsFormat = oddsFormat
              ),
              httr::add_headers(AOToken = token)) %>%
    httr::content(., "parsed")

}
