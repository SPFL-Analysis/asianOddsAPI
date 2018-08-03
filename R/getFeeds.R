

#' Retrieves the feed or odds from the system.
#'
#' @references \url{https://www.asianodds88.com/documentation.aspx/#4-4-getfeeds}
#'
#' @param url
#' @param token
#' @param leagueId
#' @param sportsType
#' @param marketTypeId
#' @param oddsFormat
#' @param since
#'
#' @return
#' @export
#'
#' @examples
getFeeds <- function(url, token, leagueId,
                     sportsType = 1, marketTypeId = 2,
                     oddsFormat = "00", since = 1473254981365) {

    httr::GET(paste0(url, "/GetFeeds"),
              query = list(
                leagues = leagueId,
                sportsType = sportsType,
                marketTypeId = marketTypeId,
                oddsFormat = oddsFormat,
                since = since
              ),
              httr::add_headers(AOToken = token)) %>%
    httr::content(., "parsed")

}
