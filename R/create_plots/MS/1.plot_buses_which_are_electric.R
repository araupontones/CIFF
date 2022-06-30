#' Create charts of Electric vehicles in new sales

library(rio)
library(ggplot2)
library(dplyr)
source("R/create_plots/themes.R")
source("R/create_plots/utils.R")


#Elecytic vehicles
infile <- "data/Clean/RMI.rds"
exdir <- "plots/MS"

indicator <- "% of buses which are electric" 
Source = "DMRC, PMPML, Navi Mumbai."
Title = "% of buses which are electric"
lab_y = "Proportion (%)"

#prepare data ------------------------------------------------------------------
rmi <- import(infile) %>%
  filter(Indicator == indicator) %>%
  select(Model,Year, value, Type, Source) %>%
  filter(Type == "Update") %>%
  filter(!Year%in% c("2020","2023")) %>%
  mutate(Model = forcats::fct_reorder(Model, value))
  

  
 
#Plot
rmi %>% 
  dodge_plot(x = Model,
             y = value,
             fill = Year,
             label = value,
             format = "percent",
             color_bars = c(guinda, blue_light)) +
  #Labels --------------------------------------------------------------------
labs(y = lab_y,
     x = "",
     title =  Title,
     subtitle = "[By State]",
     caption = paste("**Source:**", Source, 
                     "<br>**Chart:** Oxford Policy Management. June, 2022")) +
  scale_y_continuous(expand = c(0,0),
                     limits = c(0,.5)) +

  theme_ciff()




exfile <- file.path(exdir,"1.buses_which_are_electrict.png")
ggsave( exfile,
        last_plot(),
        height = 10.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)




  