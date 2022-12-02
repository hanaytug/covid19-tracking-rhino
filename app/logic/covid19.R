box::use(
    dplyr,
    httr,
    reactable[reactable],
    rhino,
    tidyjson,
    tidyr
)

#' @export
continents <- c(
    "Africa",
    "Asia",
    "Europe",
    "North America",
    "Oceania",
    "South America"
)

#' @export
fetch_data <- function() {
    response <- httr::GET(
        "https://covid-19-stats2.p.rapidapi.com/",
        httr::add_headers(
            "X-RapidAPI-Key" = "aa9b7f8139msh413a7ec6fe2c5a4p19798bjsn3b6d9eb52fb5",
            "X-RapidAPI-Host" = "covid-19-stats2.p.rapidapi.com"
            )
        )
    raw <- httr::content(response, "text")
    data <- tibble::as_tibble(tidyjson$spread_all(tidyjson$gather_array(raw))[-c(0, 1, 2, 4)])
}

#' @export
filter_continents <- function(data, continents) {
    data |>
        dplyr$filter(continent %in% continents)
}

#' @export
table <- function(data) {
    data |>
    reactable(
        minRows = 10,
        showPageSizeOptions = TRUE,
        pageSizeOptions = c(10, 50, 100),
        striped = TRUE,
        highlight = TRUE,
        bordered = TRUE,
    )
}
