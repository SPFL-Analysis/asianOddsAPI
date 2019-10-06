

#' Retrieves the statement history or odds from the system
#'
#' @references <https://www.asianodds88.com/documentation.aspx/#3-2-gethistorystatement>
#'
#' @param url,token see [httr::GET()].
#' @param from,to dDate string, mm/dd/yyy.
#' @param bookies comma seperated string of bookie ids.
#' @param shouldHideTransactionData string with a logical.
#'
#' @return
#' @export
#'
#' @examples
getHistoryStatement <- function(url, token, from = "01/01/2016",
                                to = "08/06/2018",
                                bookies = "IBC,SBO,SIN,PIN,ISN,GA",
                                shouldHideTransactionData = "false") {
  httr::GET(
    paste0(
      authConn$url,
      "/GetHistoryStatement"
    ),
    query = list(
      from = "01/01/2016",
      to = "08/06/2018",
      bookies = "IBC,SBO,SIN,PIN,ISN,GA",
      shouldHideTransactionData = "false"
    ),
    httr::add_headers(AOToken = authConn$token)
  ) %>%
    httr::content("parsed")
}
