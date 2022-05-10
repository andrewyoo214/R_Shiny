library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

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
      selectInput(
        "Team", "Team",
        unique(players$Team),
        selected = "Golden State Warriors"
      )
    ),
    mainPanel(
      strong(
        "There are",
        textOutput("num_players", inline = TRUE), ## filtering 에 걸리는 n 수만 보겠다.
        "players in the dataset"
      ),
      plotOutput("nba_plot"),
      DTOutput("players_data")
    )
  )
)

# server <- function(input, output, session) {
# 
#   output$players_data <- renderTable({ ## filtering된 데이터 만들기.
#     data <- players %>%
#       filter(VORP >= input$VORP,
#              Team %in% input$Team)
# 
#     data
#   })
# 
#   output$num_players <- renderText({
# 
#   })
# 
#   # Build the plot output here
# 
# }

server <- function(input, output, session) {
  
  output$players_data <- renderDT({ ##renderDT는 반응형 데이터 테이블
    data <- players %>%
      filter(VORP >= input$VORP,
             ## VORP 는 reactive 값이어서 고정된 것처럼 저장이 불가능해.
             Team %in% input$Team)
    
    data
  })
  
  output$num_players <- renderText({ ## 데이터에서 필터링된 사람 수
    data <- players %>%
      filter(VORP >= input$VORP,
             Team %in% input$Team)
    
    return(nrow(data))
  })
  
  output$nba_plot <- renderPlot({ ## 필터링 데이터에서 Salary 값의 히스토그램.
    data <- players %>%
      filter(VORP >= input$VORP,
             Team %in% input$Team)
    
    ggplot(data, aes(Salary)) + geom_histogram()+
      theme_classic() + scale_x_log10(labels=scales::comma)
  })
  
}


shinyApp(ui, server)
