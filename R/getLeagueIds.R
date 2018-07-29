

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
getLeagueIds <- function(url, token,
                         sportsType, marketTypeId,
                         leaguesString = "SCOTLAND") {

  leagues <-
    httr::GET(paste0(url, "/GetLeagues"),
              query = list(sportsType = sportsType,
                           marketTypeId = marketTypeId),
              add_headers(AOToken = token))

  df <-
    httr::content(leagues, "parsed")[["Result"]][["Sports"]][[1]]$League %>%
    purrr::map_dfr(
      ~data.frame(
        league = .x[["LeagueName"]],
        leagueId = .x[["LeagueId"]],
        stringsAsFactors = FALSE))

  try(
    getLeagueNames <-
    stringr::str_subset(df[["league"]], leaguesString)
  )

  dplyr::filter(df, league %in% getLeagueNames)

}
