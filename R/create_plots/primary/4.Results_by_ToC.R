cli::cli_alert_info("Plot: results by TOC")

library(rio)
library(dplyr)
library(ggplot2)
library(ggalluvial)
infile <- "data/Clean/results.csv"
exdir <- "report/plots/results"

#Plot parameters -------------------------------------------
title = "Interaction between pathways, results, and ToC"
subtitle = "[ZEV - from 2021 to first half of 2022]"
Source = "Programme's MEL System."



#Preapare data -----------------------------------------------
results <- import(infile)

#count indicators by lever and Pathway
toc <- results %>% 
  mutate(Indicator = stringr::str_wrap(Indicator,15),
         Pathway = stringr::str_wrap(Pathway,15)) %>%
  group_by(Lever,Pathway,level_toc,Indicator) %>%
summarise(total = n(), .groups = 'drop') 



#ZEV ======================================================
toc %>%
  filter(Lever == "ZEV") %>%
  alluvial_plot_3()+
  #labs--------------------------------------------------
  
  labs(title = title,
       subtitle =subtitle,
       caption = paste("**Source:**", Source),
       y = "",
       x = ""
  ) 
  #theme ------------------------------------------------

  

  
  exfile1 <- file.path(exdir,"4.results_byPathway_TOC_ZEV.png")
ggsave( exfile1,
        last_plot(),
        height = 11.3,
        width = 11.11,
        units = "cm",
        type = 'cairo'
)

#Modal shift ====================================================================

subtitle = "[Modal Shift - from 2021 to first half of 2022]"

toc %>%
  filter(Lever == "Modal Shift") %>%
  alluvial_plot_3() +
  labs(title = title,
       subtitle =subtitle,
       caption = paste("**Source:**", Source),
       y = "",
       x = ""
  ) 



exfile1 <- file.path(exdir,"4.1results_byPathway_TOC_Moda_Shift.png")
ggsave( exfile1,
        last_plot(),
        height = 11.3,
        width = 11.11,
        units = "cm",
        type = 'cairo'
)
