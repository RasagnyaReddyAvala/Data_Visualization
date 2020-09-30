library(ggplot2)
library(shiny)
ui <- basicPage(
  plotOutput("plot1", click = "plot_click"),
  verbatimTextOutput("info")
)

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(google, aes(x=Last.Updated, y=Installs)) + geom_point(color="blue") + scale_y_continuous(name=waiver(), trans = "log10") + labs(title="Installs over years", x="Year") + theme(plot.title = element_text(face = "bold", color = "darkgrey", size = 20))
  })
  
  output$info <- renderPrint({
    # With ggplot2, no need to tell it what the x and y variables are.
    # threshold: set max distance, in pixels
    # maxpoints: maximum number of rows to return
    # addDist: add column with distance, in pixels
    nearPoints(google, input$plot_click, threshold = 10, maxpoints = 1
               )
  })
}

shinyApp(ui, server)
