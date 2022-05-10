######### testing, practice

library(shiny)

ui<- fluidPage(
  sliderInput("num", "Choose a Number", 0, 100, 20),  ## id: num
  plotOutput("myplot")                                ## id: myplot
)


server<-function(input, output){
  
  output$myplot <-renderPlot({
    plot(rnorm(input$num))
  })
}


shinyApp(ui = ui, server = server)











