library(shiny)
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)
library(shinyWidgets)

# user interface ----
ui <- fluidPage(
  
  navbarPage(
    "Paloma's Penguins App",
    tabPanel("Background", 
             em("Some placeholder information about Penguins here")),
    
    tabPanel("Graphs", 
             tabsetPanel(
               tabPanel("Scatterplot",
                        # body mass slider input ----
                        sliderInput(inputId = "body_mass_input", 
                                    label = "Select a range of bodymasses (g):",
                                    min = 2700, max = 6300, # sets the range of the slider bar 
                                    value = c(3000, 4000)),
                        
                        # body mass output ----
                        plotOutput(outputId = "body_mass_scatter"),
                        ),
               tabPanel("Histogram",
                        
                        # reactive histogram input ----
                        pickerInput(inputId = "histogram_input", 
                                    label = "Select an island:", 
                                    choices = c("Torgersen", "Dream", "Biscoe"),
                                    selected = c("Torgersen", "Dream", "Biscoe"),
                                    multiple = TRUE,
                                    options = pickerOptions(actionsBox = TRUE)),
                       
                         # bin number input ---- 
                        sliderInput(inputId = "bin_num", label = "Select number of bins:",
                                    min = 1, max = 100, value = 25), 
                        
                        # flipper length plot output ----
                        plotOutput(outputId = "histogram_output"),
                        ))),
    
    tabPanel("Arctic Weather", 
             em("some widget to explore weather data here")),
    
    tabPanel("Explore the Data",
             tabsetPanel(
               tabPanel("Penguin Data",
                        # data table output ----
                        DT::dataTableOutput(outputId = "penguins_dt")),
               tabPanel("Palmer Station Weather Data",
                        em("weather DT here")))),
    
  )
  
)
