library(rio)
source("R/create_primary_data/utils.R")
#Get primary data
exfile <- "data/Clean/results.csv"

#download from zoho
all_results <- download_ciff("All_Results1")



names(all_results)

#Keep relevant variables ------------------------------------------------------
results_clean <- all_results %>%
  select(Partner,
         Lever,
         level_toc = Indicators.Levels_ToC,
         Name = Name_result,
         Status,
         Period = Period1,
         Indicator = Indicators,
         Pathway = Pathways,
         Description,
        
         ) %>%
  mutate(Lever = gsub( "Zero-Emission Vehicles", "ZEV", Lever),
         Indicator = case_when(Indicator == "Policy and regulatory recommendations to increase railways in freight of transport" ~ "Policy recommendations",
                               Indicator == "Policy recommendations for improving technical and financial capacity of cities"   ~ "Policy recommendations",
                               Indicator == "Published papers and reports (external audience)" ~ "Publications",
                               Indicator == "Tools and platforms developed" ~ "Tools & platforms",
                               Indicator == "Communication pieces developed " ~ "Communication pieces",
                               Indicator == "Request for policy implementation support" ~ "Policy implementation request",
                               Indicator == "Policy dialogues with government agencies" ~ "Policy dialogues",
                               
                               T ~ Indicator
                               )
         ) %>%
  mutate(Pathway = gsub("and", "&", Pathway),
         Pathway = trimws(Pathway)) %>%
  arrange(Partner, Period, level_toc, Pathway, Indicator) %>%
  filter(Indicator != "")
 


unique(results_clean$Pathway)

#export ===================================================================
export(results_clean, exfile)

