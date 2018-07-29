
#' Title
#'
#' @param oddsString
#'
#' @return
#' @export
#'
#' @examples
read_booke_odds_FT1X2 <- function(oddsString) {
  splitString <-
    unlist(stringr::str_split(oddsString, ";"))

  oddsString <-
    splitString[dplyr::starts_with(match = "BEST", vars = splitString)] %>%
    stringr::str_replace_all( "BEST=", "") %>%
    stringr::str_split(",") %>%
    unlist() %>%
    stringi::stri_split_fixed(" ") %>%
    rlang::set_names(c("home", "away", "draw")) %>%
    imap_dfr(
      ~data.frame(
        market = .y,
        bookie = .x[1],
        odds = .x[2],
        stringsAsFactors = F
      ))
}

#' Title
#'
#' @param oddsList
#' @param Hdp
#'
#' @return
#' @export
#'
#' @examples
read_booke_odds_FTHdp <- function(oddsList, Hdp) {

  splitString <-
    unlist(stringr::str_split(oddsList[["BookieOdds"]], ";"))

  Hdp <- oddsList$Handicap

  oddsString <-
    splitString[dplyr::starts_with(match = "BEST", vars = splitString)] %>%
    stringr::str_replace_all( "BEST=", "") %>%
    stringr::str_split(",") %>%
    unlist() %>%
    stringi::stri_split_fixed(" ") %>%
    rlang::set_names(
      c(paste0("home", Hdp, "ah"),
        paste0("away", Hdp, "ah"))) %>%
    imap_dfr(
      ~data.frame(
        market = .y,
        bookie = .x[1],
        odds = .x[2],
        stringsAsFactors = F
      ))
}

read_booke_odds_FTOU <- function(oddsString, OU) {

}
