#'create all charts
library(ggplot2)
source("R/create_plots/themes.R")
source("R/create_plots/utils.R")
scripts <- list.files("R/create_plots/primary", full.names = T)
scripts <- scripts[!grepl("X", scripts)]


for (s in scripts) {
  source(s)
}
