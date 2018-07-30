

#' Title
#'
#' @param oddsMarket
#' @param leagueGames
#'
#' @return
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
          data.frame(
            market = NA,
            bookie = NA,
            odds = NA,
            stringsAsFactors = F
          )
      }

      data.frame(
        homeTeam,
        awayTeam,
        matchDate,
        oddsString,
        stringsAsFactors = F
      )
    }
  ) %>%
    dplyr::filter(!is.na(market))
}
