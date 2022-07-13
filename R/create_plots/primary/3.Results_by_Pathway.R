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

order_pathways <- c("Reduced barriers in auto sector",
                    "Improve awareness and adoption of EV",
                    "Improve public awareness and usage of public transport",
                    "Unlocking policy and regulatory barriers",
                    "Increased share of railways in freight transport",
                    "Improve public transport infrastructure & usage",
                    "Reduce financial barriers")

#count indicators by lever and Pathway
paths <- results %>% 
  mutate(Indicator = stringr::str_wrap(Indicator,30),
         Pathway = stringr::str_wrap(Pathway,30)) %>%
  group_by(Lever,Pathway,Indicator) %>%
summarise(total = n(), .groups = 'drop') %>%
    mutate(Pathway = factor(Pathway,
                            levels = c( "Reduced barriers in auto\nsector" ,
                                       
                                       "Improve awareness & adoption\nof EV",
                                       
                                       "Improve public awareness &\nusage of public transport",
                                       
                                       "Improve public transport\ninfrastructure & usage" ,
                                       
                                       "Unlocking policy & regulatory\nbarriers"     ,
                                       
                                       "Reduce financial barriers",
                                       
                                       "Increased share of railways in\nfreight transport"),
                            ordered = T
                            )
           )


unique(paths$Pathway)
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
