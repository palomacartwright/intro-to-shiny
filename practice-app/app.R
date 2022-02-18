# load packages ---- 
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(here)
library(ggplot2)
library(shinyWidgets)

# combine UI and server into an app ----
shinyApp(ui = ui, server = server)


