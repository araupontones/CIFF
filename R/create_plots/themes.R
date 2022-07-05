
extrafont::loadfonts('win')

font<-"Roboto"

blue_dark <- "#0B1F51"
blue_chart <- "#0D47A1"
blue_light <- "#47A7E2"
grey_light <- "#FAFAFA"
orange_red <-"#F24F4A"
guinda <- "#731730"
green <- "#006344"
green_light <- "#4DD99E"


palette <- c(blue_chart, blue_light, orange_red, guinda,
             green, green_light)

color_background <- "#DBE4EC"




theme_ciff <- function(){
  
  
  #theme -----------------------------------------------------------------------
  
  theme(
    
    text = element_text(family = font, color = blue_dark),
    #Panel
    panel.background = element_rect(fill = color_background),
    panel.grid = element_blank(),
    panel.grid.major.y = element_line(colour = grey_light, size = .5),
    
    
    #Plot
    plot.background = element_rect(fill = color_background),
    plot.title = element_text(margin = margin(b = 5), size = 14, face = "bold"),
    plot.subtitle = element_text(margin = margin(b = 15), size = 12),
    plot.caption = ggtext::element_markdown(hjust = 0, size = 8),
    plot.title.position = "plot",
    plot.caption.position = "plot",
  
    
    
    
    
    #legend
    legend.position = "bottom",
    legend.background = element_rect(fill = "#DBE4EC"),
    legend.title = element_blank(),
    
    
    #axis
    axis.line.y = element_line(color = grey_light),
    axis.line.x.bottom = element_line(color = grey_light),
    axis.ticks = element_blank(),
    axis.text = element_text(face = "bold", color = blue_dark),
    axis.title = element_text(face = "bold", size = 10, color = blue_dark),
    axis.title.y = element_text(margin = margin(r = 5))
  )
}
  
  
  

#theme stacked ---------------------------------------

theme_stacked <- function(){
  
  theme(legend.text = element_text(size = 7),
        legend.position = "bottom",
        legend.justification = c(0,1),
        legend.margin = margin(r = 0, b = 10, l = -60, unit = "pt"),
        
        legend.key.height = unit(.3, 'cm'), #change legend key height
        legend.key.width = unit(.3, 'cm'), #change legend key width
        legend.key = element_rect(color = NA),
        axis.text.y = element_text(hjust = 0)  
        )
}


#theme alluvial -----------------------------------------------------
theme_alluvial <-function(){
  
  theme(
    text = element_text(family = font, color = blue_dark),
    #Panel
    panel.background = element_rect(fill = color_background, colour = NA),
    panel.border = element_blank(),
    # panel.border = element_rect(colour = color_background, 
    #                             fill=NA, size=1),
    
    
    #Plot
    plot.background = element_rect(fill = color_background, color = NA),
    plot.title = element_text(margin = margin(t = 5, l=5,b = 5), size = 14, face = "bold"),
    plot.subtitle = element_text(margin = margin(b = 15), size = 12),
    plot.caption = ggtext::element_markdown(hjust = 0, size = 8,
                                            margin = margin(b = 10)),
    plot.title.position = "plot",
    plot.caption.position = "plot",
    legend.position = "none",
    
    #Axis
    axis.text.x = element_text(size = 8, colour = blue_dark, face = "bold"),
    axis.title.x = element_text(size = 10)
  )
}
