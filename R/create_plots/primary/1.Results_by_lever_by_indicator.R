cli::cli_alert_info("Plot: results by lever")
library(rio)
library(dplyr)
library(ggplot2)
infile <- "data/Clean/results.csv"
exdir <- "report/plots/results"

#Plot parameters -------------------------------------------
title = "Number of results reported"
subtitle = "[By Lever - from 2021 to first half of 2022]"
Source = "Programme's MEL System."



#Preapare data -----------------------------------------------
results <- import(infile)

#count indicators by lever
by_lever <- results %>%
  mutate(Indicator = stringr::str_wrap(Indicator,40)) %>% 
  group_by(Lever, Indicator) %>%
  summarise(total = n(), .groups = 'drop')
            






#Plot =========================================================
by_lever %>%
  stacked_plot(x = total,
               y = Lever,
               fill = Indicator,
               label = total) +
  labs(title = title,
       subtitle =subtitle,
       caption = paste("**Source:**", Source),
       y = "",
       x = "Results (#)"
       ) +
  theme_ciff() +
 theme_stacked()




exfile1 <- file.path(exdir,"1.results_byLever.png")
ggsave( exfile1,
        last_plot(),
        height = 10.3,
        width = 10.11,
        units = "cm",
        type = 'cairo'
)


