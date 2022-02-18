# practice code for my shiny app 

library(palmerpenguins)
library(tidyverse)
library(here)


body_mass_df <- penguings %>% 
  filter(body_mass_g %in% 3000:4000)

ggplot(data = na.omit(body_mass_df), 
       aes(x = flipper_length_mm, y = bill_length_mm, color = species, shape = species)) +
  geom_point() +
  scale_color_manual(values = c("#FEA346", "#B251F1", "#4BA4A4")) +
  labs(x = "Flipper Length (mm)", 
       y = "Bill Length (mm)", 
       color = "Penguin Species", 
       shape = "Penguin Species") +
  theme_minimal()



DT::datatable(penguins, 
              caption = "Table 1. Palmer Penguins", 
              class = 'cell-border stripe', 
              filter = 'top', 
              editable = TRUE,
              # extensions = 'Buttons',
              options = list(pageLength = 5,
                             # buttons = c('csv','excel','pdf'),
                             lengthMenu = c(5, 10, 15, 20)))
  

