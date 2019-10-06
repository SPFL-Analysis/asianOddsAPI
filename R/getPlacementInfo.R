


getPlacementInfo <- function(url, token, GameId,
                     GameType, IsFullTime = 1,
                     Bookies, MarketTypeId,
                     oddsFormat = "00", OddsName,
                     SportsType) {

    httr::GET(paste0(url, "/GetPlacementInfo"),
              query = list(
                GameId = GameId,
                GameType = GameType,
                IsFullTime = IsFullTime,
                Bookies = Bookies,
                MarketTypeId = MarketTypeId,
                oddsFormat = oddsFormat,
                OddsName = OddsName,
                SportsType = SportsType
              ),
              httr::add_headers(AOToken = token)) %>%
    httr::content(., "parsed")

}
