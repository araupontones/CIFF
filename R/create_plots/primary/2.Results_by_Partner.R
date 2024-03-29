cli::cli_alert_info("Plot: results by partner")
library(rio)
library(dplyr)
library(ggplot2)
infile <- "data/Clean/results.csv"
exdir <- "report/plots/results"

#Plot parameters -------------------------------------------
title = "Number of results reported"
subtitle = "[By Partner - from 2021 to first half of 2022]"
Source = "Programme's MEL System."



#Preapare data -----------------------------------------------
results <- import(infile)

#count indicators by lever
results %>% 
  group_by(Partner,Indicator) %>%
  mutate(Indicator = stringr::str_wrap(Indicator,40)) %>%
  summarise(total = n(), .groups = 'drop') %>%
  stacked_plot(x = total,
               y = Partner,
               fill = Indicator,
               label = total) +
  labs(title = title,
       subtitle =subtitle,
       caption = paste("**Source:**", Source),
       y = "",
       x = "Results (#)"
  ) +
  theme_ciff() +
  theme_stacked() +
  theme(
    legend.margin = margin(l = -30, b = 10)
  )



exfile1 <- file.path(exdir,"2.results_byPartner.png")
ggsave( exfile1,
        last_plot(),
        height = 10.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)



