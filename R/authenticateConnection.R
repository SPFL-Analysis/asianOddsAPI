
#' Authenticate connection
#'
#' @param url
#' @param username
#' @param password
#'
#' @return
#' @export
#'
#' @examples
authenticateConnection <-
  function(
    url = "https://webapi.asianodds88.com/AsianOddsService/Login?",
    username,
    password) {

    r <-
      httr::GET(url = url,
                query =
                  list(
                    username = username,
                    password = password
                  ))

    url <- httr::content(r, "parsed")$Result$Url
    Token <- httr::content(r, "parsed")$Result$Token
    Key <- httr::content(r, "parsed")$Result$Key

    auth <-
      httr::GET(paste0(url, "/Register?username=", username),
                httr::add_headers(AOToken = Token,
                            AOKey = Key)) %>%
      httr::content(., "parsed")

    list(
      url = url,
      token = Token
    )
  }
