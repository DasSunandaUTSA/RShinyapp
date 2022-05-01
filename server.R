## Shiny Server component for dashboard
##creating ggplot 

function(input, output){
  output$dataT <- renderDataTable(
    my_data
  )
 

 # Create overall box-plot
    
    output$plot <- renderPlotly({
        
      
      p = my_data %>%
        ggplot(aes(x=get (input$var1), fill=Cuisine)) +
        geom_boxplot(outlier.shape = NA)+
        ggtitle (paste(input$var1, "of Yelp users for Resturants in Austin")) +
        xlab(paste(input$var1)) 
       
 
    ggplotly(p) %>%
      layout(xaxis = list(autorange = TRUE),
             yaxis = list(autorange = TRUE))   # auto scale in Rshiny server
      
  })
  
    # Create box-plot for different price-range
    
  output$box <- renderPlotly ({
    
      q = my_data %>%
        ggplot(aes(x=get (input$var2), y= Cuisine)) +
       
        geom_point(aes(color=price))+
        ggtitle ("Popular resturants in Austin") +
        xlab(paste(input$var1))
      
      ggplotly(q) %>%
        layout(xaxis = list(autorange = TRUE),
               yaxis = list(autorange = TRUE))   # auto scale in Rshiny server
   
  })
  
  
  #create shortlist of resturants
  selections = reactive({
    req(input$var4)
    req(input$var5)

    filter(my_data, price == input$var4) %>%
      filter(Cuisine %in% input$var5)
    })
  
  output$dataTN = 
    DT::renderDataTable({
      DT::datatable(selections()[,c("Resturant", "Rating", "Review")],
                    colnames = c("Resturant", "Rating", "Review"),
                    options = list(order = list(2, 'des')),
                    rownames = FALSE,
      )
      
    })
  
}
