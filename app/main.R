box::use(
    shiny[bootstrapPage, moduleServer, NS, reactive, navbarPage, tabPanel, div, fluidPage, fluidRow,
        titlePanel, sliderInput, sidebarPanel, mainPanel],
)

box::use(
    app/logic[covid19],
    app/view[table, continent_filter],
)

#' @export
ui <- function(id) {
    ns <- NS(id)
    fluidPage(
        titlePanel("COVID-19 Tracker"),
        sidebarPanel(
        continent_filter$ui(ns("continent_filter"))
        ),
        mainPanel(
        table$ui(ns("table"))
        )
    )
}

#' @export
server <- function(id) {
    moduleServer(id, function(input, output, session) {
        raw_data <- reactive(covid19$fetch_data())
        data <- continent_filter$server("continent_filter", raw_data)
        table$server("table", data)
    })
}
