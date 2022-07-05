cli::cli_alert_info("Plot: results by pathways")

library(rio)
library(dplyr)
library(ggplot2)
library(ggalluvial)
infile <- "data/Clean/results.csv"
exdir <- "report/plots/results"

#Plot parameters -------------------------------------------
title = "Interaction between results and pathways"
subtitle = "[ZEV - from 2021 to first half of 2022]"
Source = "Programme's MEL System."



#Preapare data -----------------------------------------------
results <- import(infile)

#count indicators by lever and Pathway
paths <- results %>% 
  mutate(Indicator = stringr::str_wrap(Indicator,15),
         Pathway = stringr::str_wrap(Pathway,15)) %>%
  group_by(Lever,Pathway,Indicator) %>%
summarise(total = n(), .groups = 'drop') 



#ZEV ======================================================
paths %>%
  filter(Lever == "ZEV") %>%
  alluvial_plot()

  



exfile1 <- file.path(exdir,"3.results_byPathway_ZEV.png")
ggsave( exfile1,
        last_plot(),
        height = 11.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)

#Modal shift ============================================

subtitle = "[Modal Shift - from 2021 to first half of 2022]"
paths %>%
  filter(Lever == "Modal Shift") %>%
  alluvial_plot() 



exfile1 <- file.path(exdir,"3.results_byPathway_Moda_Shift.png")
ggsave( exfile1,
        last_plot(),
        height = 11.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)
