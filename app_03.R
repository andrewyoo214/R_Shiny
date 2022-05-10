library(shiny)

players <- read.csv("data/nba2018.csv")

ui <- fluidPage(
  titlePanel("NBA 2018/19 Player Stats"),
  sidebarLayout(
    sidebarPanel(
      "Exploring all player stats from the NBA 2018/19 season",
      h3("Filters"),
      sliderInput(
        inputId = "VORP",
        label = "Player VORP rating at least",
        min = -3, max = 10,
        value = 0
      ),
      
      selectInput( ## 선택하는 것.
        "Team", "Team",
        choices = unique(players$Team), ##unique 함수를 통해서 모든 팀들.
        selected = "Golden State Warriors"
      )
    ),
    mainPanel(
      strong(
        "There are",
        nrow(players),
        "players in the dataset"
      )
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
