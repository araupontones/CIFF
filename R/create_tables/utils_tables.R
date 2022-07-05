#'Create dir if does not exis 
#'

create_dir <- function(newdir){
  
  if(!dir.exists(newdir))
  
    dir.create(newdir)
}


