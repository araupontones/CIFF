#' Imports raw data from RMI
#' Formats and clean the data for a friendly visualization

library(rio)
library(dplyr)
library(tidyr)

options(scipen=999)
#define paths to read and to export
infile <- "data/1.secondary/RMI_secondary.xlsx"
exfile <-"data/Clean/RMI.rds"

#read sheets of the raw file to identigy which is the summary one
sheets <- openxlsx::getSheetNames(infile)
sum_sheet <- sheets[which(grepl("Summary", sheets))]


#read the summary tab of the RMI raw data ==========================
raw <- import(infile, sheet = sum_sheet) %>%
  #remove empty colums
  janitor::remove_empty('cols') %>%
  #remove empty rows
  janitor::remove_empty('rows')
  

#get names of colums correctly
raw[1,1] <- "Indicator"
raw[1,2] <- "Model"

names(raw) <- raw[1,]
#drop first column because it contains the names of the variables
raw <- raw[-1,]

View(clean)

#clean it ==================================

clean <- raw %>%
  #fill emtpy values indicators due to merged cells
  tidyr::fill(Indicator) %>%
  #drop rows with comments
  filter(!grepl("diffcult to get this data|The Indicator is|2020 numbers|will no more be valid", Indicator)) %>%
  #'Identify National Indicators
  #'And define the format of the indicator
  mutate(Model = ifelse(is.na(Model), "National", Model),
         Format = ifelse(grepl("%", Indicator), "Percent", "Integer")
         ) %>%
  #'Pivot longer
  #'For that, all the columns should have the same format
  mutate_all(function(x)as.character(x)) %>%
  pivot_longer(-c(Indicator,
                  Model,
                  Format, 
                  Source),
               names_to = "Year") %>%
  #' Clean Year because it contains redundant symbols
  mutate(Year = gsub("\\*", "", Year),
         Type = ifelse(grepl("Update", Year), "Update", "Estimate"),
         Year = gsub("[a-zA-Z]|-","", Year),
         Year = stringr::str_trim(Year, "both"),
         value = stringr::str_trim(value, "both"),
         #'The indicator comes with spaces from the raw format
         #'Eliminate those:
         Indicator = gsub("\\r\\n"," ", Indicator)
         
         ) %>%
  #'Some rows contain data that is headers from the unformat excel
  #'Remove those:
  filter(#'If it is a year header
         !value %in% c("2020", "2022", "2023", "2024"),
         #'If it is a comment
         !grepl("^[A-Z]|Update", value)
         ) %>%
  #'Convert value to numbers
  #'Some of the formatting is inconsistent in the raw data.
  #'Some are reported in string and the other in percentage
  #'Fix them
  mutate(value = as.numeric(value),
         #Fix inconsistencies for electric vehicles
         value = ifelse(Indicator == "% of electric vehicles in new sales"
                        & Type == "Estimate" 
                        & Year %in% c("2021", "2022", "2023"),
                        value/100, value
                        )
         )
  


#Export =============================================================
export(clean, exfile)
