#' Create charts of Electric vehicles in new sales

library(rio)
library(ggplot2)
library(dplyr)
source("R/create_plots/themes.R")
source("R/create_plots/utils.R")


#Elecytic vehicles
infile <- "data/Clean/RMI.rds"
exdir <- "plots/EV"

indicator <- "% of electric vehicles in new sales"
Source = "vahan.parivahan.gov.in"
Title = "% Of electric vehicles in new sales"
lab_y = "Proportion (%)"

#prepare data ------------------------------------------------------------------
rmi <- import(infile) %>%
  filter(Indicator == "% of electric vehicles in new sales" ) %>%
  select(Model,Year, value, Type, Source) %>%
  filter(Type == "Update") %>%
  filter(!Year%in% c("2020","2023"))





#By model ====================================================================

rmi %>% 
  filter(!Model %in% c("Delhi", "Maharashtra")) %>%
  dodge_plot(x = Model,
             y = value,
             fill = Year,
             label = value,
             format = "percent") +
  #Labels --------------------------------------------------------------------
labs(y = lab_y,
     x = "",
     title =  Title,
     subtitle = "[By Model]",
     caption = paste("**Source:**", Source)) +
  scale_y_continuous(breaks = seq(0,.1,.02),
                     limits = c(0,.1),
                     labels = function(x)x*100,
                     expand = c(0,0)
  ) +
  theme_ciff()
 



exfile1 <- file.path(exdir,"1.1.electric_vehicles_in_new_sales_byModel.png")
ggsave( exfile1,
       last_plot(),
       height = 10.3,
       width = 10.11,
       units = "cm",
       type = 'cairo'
)


#BY region ====================================================================


rmi %>% 
  filter(Model %in% c("Delhi", "Maharashtra")) %>%
  dodge_plot(x = Model,
             y = value,
             fill = Year,
             label = value,
             format = "percent") +
  #Labels --------------------------------------------------------------------
labs(y = lab_y,
     x = "",
     title = Title,
     subtitle = "[By State]",
     caption = paste("**Source:**", Source)) +
  scale_y_continuous(breaks = seq(0,.1,.02),
                     limits = c(0,.1),
                     labels = function(x)x*100,
                     expand = c(0,0)) +
  theme_ciff()




exfile1 <- file.path(exdir,"1.2.electric_vehicles_in_new_sales_byState.png")
ggsave( exfile1,
        last_plot(),
        height = 10.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)


