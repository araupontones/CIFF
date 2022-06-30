#'create all charts

scripts <- list.files("R/create_plots/primary", full.names = T)
scripts <- scripts[!grepl("X", scripts)]


for (s in scripts) {
  source(s)
}
