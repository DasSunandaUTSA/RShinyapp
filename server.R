## Shiny Server component for dashboard
##creating ggplot 

function(input, output){
  output$dataT <- renderDataTable(
    my_data
  )
  
  output$plot <- renderPlotly({
    p= ggplot(my_data, aes(x=get(input$var1),y=Cuisine)) +
      geom_boxplot()+
      ggtitle("Popularity of Resturants in Austin")+
      xlab( paste("Number of ", input$var1))+
      theme(legend.position="none")
    
    # applied ggplot to make it interactive
    ggplotly(p)
    
  })
  
  
  output$box <- renderPlotly({
    q= my_data %>%
      ggplot(aes(x=input$var1,y=Cuisine,fill=get(input$var2))) +
      geom_boxplot()+
      ggtitle("Popularity of Resturants in Austin")+
      labs(subtitle= paste("Customer's  ", input$var1))
    
    
    # applied ggplot to make it interactive
    ggplotly(q)
    
  })
}
