box::use(
    shiny,
)
box::use(
    app/logic[covid19],
)

#' @export
ui <- function(id) {
    ns <- shiny$NS(id)
    shiny$checkboxGroupInput(
        inputId = ns("continents"),
        label = "Continent",
        choices = covid19$continents,
        selected = covid19$continents
    )
}

#' @export
server <- function(id, data) {
    shiny$moduleServer(id, function(input, output, session) {
        shiny$reactive({
            covid19$filter_continents(data(), input$continents)
        })
    })
}
