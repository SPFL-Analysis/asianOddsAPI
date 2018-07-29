

library(httr)
library(magrittr)
library(dplyr)
library(tidyr)
library(purrr)
library(stringi)
library(stringr)

devtools::load_all()

testFun <- authenticateConnection()
sportsType <- getSportsId(testFun$url, testFun$token)
marketTypeId <- 2

leaguesId <-
  getLeagueIds(testFun$url, testFun$token,
             sportsType, marketTypeId,
             leaguesString = "SCOTLAND")


# need to map over the leagues and pass the id below

leagueList <-
getFeeds(testFun$url, testFun$token,
         leaguesId$leagueId[[1]],
         sportsType = 1, marketTypeId = 2,
         oddsFormat = "00")

FT1X2 <-
getLeagueOdds(leagueList, oddsMarket = "FullTimeOneXTwo")

getLeagueOdds(leagueList, oddsMarket = "FullTimeHdp")

