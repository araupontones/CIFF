library(rio)
source("R/create_primary_data/utils.R")
#Get primary data
exfile <- "data/Clean/results.csv"

#download from zoho
all_results <- download_ciff("All_Results")
View(all_results)
#Keep relevant variables
results_clean <- all_results %>%
  select(Partner = Report_Results.Partners,
         Lever = Pathways.Levers,
         Status,
         Period = Report_Results.Period,
         Indicator = Indicators,
         Pathway = Pathways,
         Description
         ) %>%
  mutate(Lever = gsub( "Zero-Emission Vehicles", "ZEV", Lever))
        


export(results_clean, exfile)
