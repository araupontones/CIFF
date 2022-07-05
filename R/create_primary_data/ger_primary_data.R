library(rio)
source("R/create_primary_data/utils.R")
#Get primary data
exfile <- "data/Clean/results.csv"

#download from zoho
all_results <- download_ciff("All_Results1")

names(all_results)
indicators <- download_ciff("All_Indicators") %>%
  select(Indicator, Levels_ToC)




#Keep relevant variables ------------------------------------------------------
results_clean <- all_results %>%
  select(Partner,
         Lever,
         level_toc = Indicators.Levels_ToC,
         Status,
         Period = Period1,
         Indicator = Indicators,
         Pathway = Pathways,
         Description,
        
         ) %>%
  mutate(Lever = gsub( "Zero-Emission Vehicles", "ZEV", Lever),
         Indicator = case_when(Indicator == "Policy and regulatory recommendations to increase railways in freight of transport" ~ "Policy and regulatory recommendations",
                               Indicator == "Policy recommendations for improving technical and financial capacity of cities"   ~ "Policy recommendations",
                               T ~ Indicator
                               )
         ) 
 




#export ===================================================================
export(results_clean, exfile)
