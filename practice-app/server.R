library(shiny)
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)
library(shinyWidgets)

# server instructions ----

server <- function(input, output){
  
  # filter body masses ----
  body_mass_df <- reactive({
    penguins %>% 
      filter(body_mass_g %in% input$body_mass_input[1]:input$body_mass_input[2])
  })
  
  # render scatterplot ----
  
  output$body_mass_scatter <- # code to generate scatterplot here
    renderPlot({
      ggplot(data = na.omit(body_mass_df()), # when you have a reactive data frame, you have to have it followed by ()
             aes(x = flipper_length_mm, y = bill_length_mm, color = species, shape = species)) +
        geom_point(size = 4) +
        scale_color_manual(values = c("Adelie" = "#FEA346", 
                                      "Chinstrap" = "#B251F1", 
                                      "Gentoo" = "#4BA4A4")) +
        scale_shape_manual(values = c("Adelie" = 19, 
                                      "Chinstrap" = 17, 
                                      "Gentoo" = 15)) +
        labs(x = "Flipper Length (mm)", 
             y = "Bill Length (mm)", 
             color = "Penguin Species", 
             shape = "Penguin Species") + 
        theme_minimal()
    })
  
  # break ------------------------------------------
  
  # render penguins DT ----
  output$penguins_dt <- DT::renderDataTable({
    DT::datatable(penguins, 
                  caption = tags$caption(em("Table 1. Palmer Penguins Data Table")), 
                  class = 'cell-border stripe', 
                  colnames = c("Species", "Island", "Bill Length (mm)", 
                               "Bill Depth (mm)", "Flipper Length (mm)", 
                               "Body Mass (g)", "Sex", "Year"),
                  filter = 'top', 
                  editable = TRUE,
                  #extensions = 'Buttons',
                  options = list(pageLength = 5,
                                 #buttons = c('csv','excel','pdf'),
                                 lengthMenu = c(5, 10, 15, 20)))
  })
  
  # filter island data ----
  island_df <- reactive({
    validate( # validate() tests a condition, returns error if test fails-
      # need() takes an exp that returns T or F + chr string to return if exp is FALSE 
      need(length(input$histogram_input) > 0, "Please select at least one island to visualize.") 
    ) 
    penguins %>% 
      filter(island == input$histogram_input)
  })
  
  # render the flipper length histogram ----
  output$histogram_output <- renderPlot({
    ggplot(na.omit(island_df()), aes(x = flipper_length_mm, fill = species)) +
      geom_histogram(alpha = 0.6, bins = input$bin_num) +
      scale_fill_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
      labs(x = "Flipper length (mm)", y = "Frequency", 
           fill = "Penguin species") +
      theme_minimal() +
      theme(legend.position = "bottom",
            legend.background = element_rect(color = "white"))
  })
  
  
  
}