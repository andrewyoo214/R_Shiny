################################################################################
### SHINY 에는 ui 와 server로 구성이 되어있다는 점.

library(shiny)

players <- read.csv("data/nba2018.csv")

# ui <- fluidPage(
#   h1("My Shiny App"),
#   strong("Dean Attali"),
#   br(),
#   "Hello ODSC"
# )

ui<- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(
      "This is a side Panel"
    ),
    mainPanel(
      "And this is the main stuff"
    )
  )
)


## Shiny는 ui를 html로 만든다. 


server <- function(input, output, session) {
  
}

shinyApp(ui, server)


