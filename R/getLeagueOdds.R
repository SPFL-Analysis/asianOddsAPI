

#' Get ths odds out of a JSON list from the web API
#'
#' @param leagueGames JSON list return from [getFeeds]
#' @param oddsMarket One of the FT1X2, AH, OU markets
#'
#' @return A dataframe in tidy format
#' @export
#'
#' @examples
getLeagueOdds <- function(leagueGames,
                          oddsMarket =
                            c("FullTimeOneXTwo",
                              "FullTimeHdp",
                              "FullTimeOu")) {

  oddsMarket <- match.arg(oddsMarket)

  purrr::map_dfr(
    leagueGames[["Result"]][["Sports"]][[1]]$MatchGames, # this map is over each game in the league Id
    function(x){
      homeTeam <- x$HomeTeam$Name
      awayTeam <- x$AwayTeam$Name
      leagueName <- x$LeagueName
      leagueId <- x$LeagueId
      matchId <- x$MatchId
      gameId = x$GameId
      marketTypeId <- x$MarketTypeId
      fullTimeFavoured <- x$FullTimeFavoured
      minus_AH_for <- ifelse(fullTimeFavoured == 1, "home", "away")
      matchDate <- x$StartsOn %>%
        stringi::stri_sub(., from = 1, to = 10) %>%
        lubridate::mdy(.)

      if(x[[oddsMarket]][["BookieOdds"]] != "") {
        oddsString <-
          switch(oddsMarket,
                 FullTimeOneXTwo =
                   read_booke_odds_FT1X2(x$FullTimeOneXTwo$BookieOdds),
                 FullTimeHdp =
                   read_booke_odds_FTHdp(x$FullTimeHdp),
                 FullTimeOu =
                   read_booke_odds_FTOU(x$FullTimeFTOu)
          )
      } else {
        oddsString <-
          dplyr::tibble(
            market = NA,
            bookie = NA,
            odds = NA
          )
      }

    #this is a one row datframe
    matchInfo <-
      dplyr::tibble(
        leagueId = leagueId,
        leagueName = leagueName,
        matchId = matchId,
        gameId = gameId,
        marketTypeId = marketTypeId,
        homeTeam = homeTeam,
        awayTeam = awayTeam,
        matchDate = matchDate,
        minus_AH_for = minus_AH_for
      )
    #match odd can be multiple row dataframe so bind all rows with matchInfo cols
    purrr::map_dfr(seq(nrow(oddsString)), function(row_num){
      dplyr::bind_cols(matchInfo, oddsString[row_num, ])
    })
    }
  ) %>%
    dplyr::filter(!is.na(market))
}
