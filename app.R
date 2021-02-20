#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
data("iris")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Iris Data Analysis"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(fluid = FALSE,
            selectInput("Variable1","Variable 1:",
                        c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")
                        ),
            selectInput("Variable2","Variable 2:",
                        c("Sepal.Length", "Sepal.Width",  "Petal.Length", "Petal.Width")
            ),
            out = h5("use the input selector for visual data analysis")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("irisPlot")
          
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$irisPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        iris %>% ggplot(aes(x = get(input$Variable1) , y = get(input$Variable2), color = Species))+geom_point() 
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
