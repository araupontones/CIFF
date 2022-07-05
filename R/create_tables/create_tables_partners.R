#tables for indicators
library(dplyr)
library(rio)
library(openxlsx)
source("R/create_tables/utils_tables.R")
source("R/create_tables/styles_tables.R")

exdir <- 'report/tables'
infile <- "data/Clean/results.csv"
results <- import(infile) 


#Lever as directory
#Partner as file title and as table header

#order level_toc as merged row
#Status, Period (order), Pathway (order), Indicator, Description

results_partners <- lapply(split(results, results$Partner), function(x){
  
  lever = x$Lever[1]
  partner = x$Partner[1]
 
  exdir_lever <- file.path(exdir, lever)
  exfile <- glue::glue('{exdir_lever}/{partner}.xlsx')
  
  #create exdir_lever if it does not exist
  create_dir(exdir_lever)
  
  #create table
  sheet_name <- partner
  wb <- createWorkbook()
  #create sheet ---------------------------------------------------------------
  addWorksheet(wb, sheet_name, 
               orientation = openxlsx_getOp("orientation", "landscape"),
               gridLines = FALSE)
  
  #add header -----------------------------------------------------------------
  writeData(wb, sheet_name, partner, startCol = 1,startRow = 1)
  mergeCells(wb, sheet_name, cols = c(1:5), rows = 1)
  addStyle(wb, sheet_name, rows = 1, cols = 1, style_headers)
  setRowHeights(wb, sheet_name, rows = 1, heights = 30 )
  
  #names of vairables ----------------------------------------------------------
  nombres_x <- names(x)
  no_headers <- which(nombres_x %in% c("Lever", "Partner", "level_toc"))
  headers <- nombres_x[-no_headers]
  
  #headers of table ------------------------------------------------------------
  for(header in headers){
    
    column <- which(headers == header)
    writeData(wb, sheet_name, header,startRow = 2, startCol = column)
    addStyle(wb, sheet_name, rows = 2, cols = c(1:5), style_titles)
  }
  
  #ToC levels ------------------------------------------------------------------
  levels <- unique(x$level_toc)
  next_row <- 3
  for(toc_level in levels){
    
  #merged row with the name of the toc level
  toc_level_plural <- paste0(toc_level,"s")
  writeData(wb, sheet_name, toc_level_plural, startRow = next_row, startCol = 1)
  mergeCells(wb, sheet_name, cols = c(1:5), rows = next_row)
  addStyle(wb, sheet_name, rows = next_row, cols = c(1:5), style_groups)
  
  #data of the toc_level ---
  next_row <- next_row + 1
  toc_level_data <- x %>% 
    filter(level_toc == toc_level) %>%
    select(-c(Lever, Partner, level_toc))
    
  
  writeData(wb, sheet_name, toc_level_data, startRow = next_row, startCol = 1, colNames = F)
  
  until_row <- next_row + nrow(toc_level_data) - 1
  addStyle(wb, sheet_name, rows = c(next_row:until_row), cols = c(1:5), style_results, gridExpand = T)
  
  
  #define start row for the next level
  next_row <- until_row + 1
  
    
    
  }
  

  #Set colum width ---------------------------------------------------------
  setColWidths(wb, sheet_name, cols = c(1:5), widths = c(
    
    #Status and period
    rep(13,2),
    #Indicator and patway
    rep(30,2),
    #Description
    rep(70)
  ))
  
  
  #Save workbook
  saveWorkbook(wb, exfile, overwrite = T)
  cli::cli_alert_success(partner)
  
  
})



#View(results_partners)
