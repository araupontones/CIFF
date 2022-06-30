#' Create charts of Electric vehicles in new sales

library(rio)
library(ggplot2)
library(dplyr)
source("R/create_plots/themes.R")
source("R/create_plots/utils.R")


#Elecytic vehicles
infile <- "data/Clean/RMI.rds"
exdir <- "plots/EV"

indicator <- "# cumulative public charging points* Installed" 
Source = "DHI-RMI Database, and DDC."
Title = "# of cumulative public charging points"
lab_y = ""

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
             format = "integer") +
  #Labels --------------------------------------------------------------------
labs(y = lab_y,
     x = "",
     title =  Title,
     subtitle = "[Installed]",
     caption = paste("**Source:**", Source)) +
  scale_y_continuous(expand = c(0,0),
                     limits = c(0,8e3),
                     labels = function(x)prettyNum(x, big.mark = ",")) +

  theme_ciff()




exfile <- file.path(exdir,"3.1.Number_cum_public_charging_points.png")
ggsave( exfile,
        last_plot(),
        height = 10.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)




  