#' Create charts of Electric vehicles in new sales

library(rio)
library(ggplot2)
library(dplyr)
source("R/create_plots/themes.R")
source("R/create_plots/utils.R")


#Elecytic vehicles
infile <- "data/Clean/RMI.rds"
exdir <- "plots/EV"

indicator <- "% price differential between EVs and ICE (100% represents price parity)" 
Source = "Market Research and WRI."
Title = "% price differential between Evs and ICE"
lab_y = "Differential (%)"

#prepare data ------------------------------------------------------------------
rmi <- import(infile) %>%
  filter(Indicator == indicator) %>%
  select(Model,Year, value, Type, Source) %>%
  filter(Type == "Update") %>%
  filter(!Year%in% c("2020","2023")) %>%
  mutate(Model = gsub("ICE autorickshaw", "ICE", Model),
    Model = forcats::fct_reorder(Model, value))
  
unique(rmi$Model)


 
 #Plot
rmi %>% 
  dodge_plot(x = value,
             y = Model,
             fill = Year,
             label = value,
             format = "percent",
             text = "horizontal") +
  #Labels --------------------------------------------------------------------
labs(y = "",
     x = lab_y,
     title =  Title,
     subtitle = "[100% represents price parity]",
     caption = paste("**Source:**", Source)) +
  scale_x_continuous(expand = c(0,0),
                     limits = c(0,4.8),
                     labels = function(x)(x *100)) +

  theme_ciff() +
  theme(
    axis.text.y = element_text(hjust = 0)
  )




exfile <- file.path(exdir,"4.1Price_differential_EV_ICE.png")
ggsave( exfile,
        last_plot(),
        height = 10.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)




  