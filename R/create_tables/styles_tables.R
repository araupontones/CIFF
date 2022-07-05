#'Styles tables

assign("color_header","#0b1f51" , envir = globalenv())
assign("color_elements","#8EAADB" , envir = globalenv())
assign("white","#FFFFFF" , envir = globalenv())
assign("black","#000000" , envir = globalenv())
assign("color_title","#808080" , envir = globalenv())
assign("color_groups","#8eaadb" , envir = globalenv())
assign("gray","#d9d9d9" , envir = globalenv())
assign("light_blue","#d9e2f3" , envir = globalenv())





style_headers <- openxlsx::createStyle(fontSize = 14,
                                       fontName = "Arial",
                                       wrapText = T,
                                       fgFill = color_header,
                                       valign = "center",
                                       border = "TopBottomLeftRight",
                                       fontColour = "#FFFFFF",borderColour = "#FFFFFF",
                                       halign = "center")



assign("style_headers",style_headers , envir = globalenv())


style_titles <-openxlsx::createStyle(fontSize = 10,
                                     fontName = "Arial",
                                     wrapText = T,
                                     fgFill = color_title,
                                     valign = "top", border = "TopBottomLeftRight",
                                     fontColour = "#FFFFFF",textDecoration = "bold",halign = "center",
                                     borderColour = white)



assign("style_titles",style_titles , envir = globalenv())

style_groups <-openxlsx::createStyle(fontSize = 10, fontName = "Arial",wrapText = T,
                                     fgFill = color_groups, valign = "top", border = "TopBottomLeftRight",
                                     fontColour = black,textDecoration = "bold",
                                     borderColour = white,
                                     halign = "center")

assign("style_groups",style_groups , envir = globalenv())

style_milestones <-openxlsx::createStyle(fontSize = 10,
                                         fontName = "Arial",
                                         fontColour = black,
                                         wrapText = T,
                                         fgFill = gray,
                                         valign = "top",
                                         border = "TopBottomLeftRight",
                                         borderColour = white
                                         
)

assign("style_milestones",style_milestones , envir = globalenv())

style_results <-openxlsx::createStyle(fontSize = 10,
                                      fontName = "Arial",
                                      fontColour = black,
                                      wrapText = T,
                                      fgFill = light_blue,
                                      valign = "top",
                                      border = "TopBottomLeftRight",
                                      borderColour = white
                                      
                                      
)


assign("style_results",style_results , envir = globalenv())

style_results_indicators <-openxlsx::createStyle(fontSize = 10,
                                                 fontName = "Arial",
                                                 fontColour = black,
                                                 wrapText = T,
                                                 fgFill = light_blue,
                                                 valign = "top",
                                                 halign = "center",
                                                 border = "TopBottomLeftRight",
                                                 borderColour = white)



assign("style_results_indicators",style_results_indicators , envir = globalenv())
