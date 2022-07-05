
#' Format of the labels ========================================================
percent_label <- function(var){scales::percent(var, accuracy = 1)}
integer_label <- function(var){prettyNum(as.character(var), big.mark = ",")}

#'direction of text ===========================================


h_geom_text <-list(
  geom_text(
    
    color = blue_dark,
    hjust = 0,
    position = position_dodge(.8),
    vjust = .5,
    size = 2
    
  )
)


v_geom_text <- 
  list(
    geom_text(
      color = blue_dark,
      hjust = .5,
      position = position_dodge(.8),
      vjust = -.3,
      size = 2
    )
  )




#'Dodge plot===================================================================
#'@param format whether the label should be in % or integer c("percent", "integer")
#'@param label variable to display as label
#'@param text whether the geom_text is to vertical or horizontal vars
dodge_plot <- function(.data,
                       x,
                       y,
                       fill, 
                       label,
                       format = "percent",
                       text = "vertical",
                       color_bars = c(orange_red,blue_chart)){
  
  if(format == "percent"){
    
    label_fn <- percent_label
  } else{
    
    label_fn <- integer_label
  }
  
  if(text == "vertical"){
    
    text_fn <- v_geom_text
  } else{
    
    text_fn <- h_geom_text
  }
  
  .data %>%
    ggplot(
      aes(x = {{x}},
          y = {{y}},
          fill = {{fill}},
          label =label_fn({{label}})
      ))+
    #columns --------------------------------------------------
  geom_col(position = "dodge",
           width = .8) +
    #text -------------------------------------------------
  text_fn +
    
    #Scales ----------------------------------------------------
  scale_fill_manual(values = color_bars) 
  
  
  
}

#Stacked plot===============================================

stacked_plot <- function(  .data,
                           x,
                           y,
                           fill,
                           label,
                           rows_legend = 3){
  
  
  .data %>%
    ggplot(aes(x = {{x}},
               y = {{y}},
               fill = {{fill}},
               label = {{label}},
               group = {{fill}}
    )) +
    geom_col(
      width = .7
    ) +
    geom_text(position = position_stack(vjust = .5),
              color = grey_light
    ) +
    scale_x_continuous(expand = c(0,0))+
    scale_fill_manual(values = palette) +
    guides(fill=guide_legend(nrow=  rows_legend,byrow=F))
}


#Alluvial results
alluvial_plot <- function(.data){
  .data %>%
  ggplot(aes(axis1 = Pathway,
                            axis2 = Indicator,
                            y= total)) +
  geom_alluvium(aes(fill = Indicator)) +
  geom_stratum(fill = color_background,
               color= grey_light) +
  geom_text(stat = "stratum",
            aes(label = after_stat(stratum)),
            size = 2,
            color = blue_dark
  ) +
    #text in flow -------------------------------------
    geom_text(stat = "flow",
              aes(label = total),
              nudge_x = -.2,
              color = grey_light,
              size = 2)+
  scale_x_discrete(limits = c("Patwhays", "Results"),
                   expand = c(0.15, 0.05),
                   position = "top") +
  scale_fill_manual(values = palette) +
  theme_void() +
  labs(title = title,
       subtitle =subtitle,
       caption = paste("**Source:**", Source),
       y = "",
       x = "Reported"
  ) +
  theme_alluvial()
}

#Alluvial Toc, Pathways, Indicator =============================================
alluvial_plot_3 <- function(.data){
  
  
  .data %>%
    ggplot(aes(axis1= Pathway,
               axis2 = Indicator,
               axis3 = level_toc,
               y = total)) +
    geom_alluvium(aes(fill = Pathway)) +
    geom_stratum(fill = color_background,
                 color= grey_light) +
    geom_text(stat = "stratum",
              aes(label = after_stat(stratum)),
              size = 2,
              color = blue_dark
    ) +
    #text in flow -------------------------------------
  geom_text(stat = "flow",
            aes(label = total),
            nudge_x = -.25,
            color = grey_light,
            size = 2) +
    scale_x_discrete(limits = c("Pathways", "Results", "Level ToC"),
                     expand = c(0.05, 0.05, 0.05, 0.15),
                     position = "top") +
    theme_void() +
    theme_alluvial()
    
}


