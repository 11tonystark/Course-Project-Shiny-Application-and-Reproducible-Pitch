#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)

# Define UI for slider demo app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("Sliders APP for Looping animation "),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar to demonstrate various slider options ----
        sidebarPanel(
            
            # Input: Simple integer interval ----
            sliderInput("integer", "Int:",
                        min = 0, max = 1000,
                        value = 500),
            
            # Input: Decimal interval with step value ----
            sliderInput("decimal", "Decimal or Float :",
                        min = 0, max = 1,
                        value = 0.5, step = 0.1),
            
            # Input: Specification of range within an interval ----
            sliderInput("range", "Range of Number:",
                        min = 1, max = 1000,
                        value = c(200,500)),
            
            # Input: Custom currency format for with basic animation ----
            sliderInput("format", "Custom Format for input:",
                        min = 0, max = 10000,
                        value = 0, step = 1500,
                        pre = "$", sep = ",",
                        animate = TRUE),
            
            # Input: Animation with custom interval (in ms) ----
            # to control speed, plus looping
            sliderInput("animation", "Looping Animation for output:",
                        min = 1, max = 2000,
                        value = 1, step = 20,
                        animate =
                            animationOptions(interval = 300, loop = TRUE))
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Table summarizing the values entered ----
            tableOutput("values")
            
        )
    )
)

# Define server logic for slider examples ----
server <- function(input, output) {
    
    # Reactive expression to create data frame of all input values ----
    sliderValues <- reactive({
        
        data.frame(
            Name = c("Int",
                     "Decimal / FloAT",
                     "Range FOR input",
                     "Custom Format For input",
                     "Animation for output"),
            Value = as.character(c(input$integer,
                                   input$decimal,
                                   paste(input$range, collapse = " "),
                                   input$format,
                                   input$animation)),
            stringsAsFactors = FALSE)
        
    })
    
    # Show the values in an HTML table ----
    output$values <- renderTable({
        sliderValues()
    })
    
}

# Create Shiny app ----
shinyApp(ui, server)