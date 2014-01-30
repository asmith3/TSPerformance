library(shiny)
library(rCharts)

load("tspdata.Rdb")

shinyServer(function(input, output) {
  
  ## code to create necessary data frame, may need to go into render plot  
    
  
  # Plot title
  chartlabel <- reactive(function(){ 
    paste("TSP ", input$radio, ", Past ", input$time)
    })
  
  output$prices <- renderChart({

    if(input$radio == "Yields") {
      if(input$time == "5 Years"){subdata <- tspdata[,18:22][seq(1, nrow(tspdata), by=21),]}
      if(input$time == "1 Year"){subdata <- tspdata[,13:17][seq(999, nrow(tspdata), by=21),]} 
      
      h1 <- Highcharts$new()
      h1$chart(type = "spline", height="450", width="900", zoomType="x")
      h1$title(text = paste("TSP ", input$radio, ", Past ", input$time))
      h1$set(dom = "prices")

      h1$xAxis(title = list(text = "Month"))
      h1$yAxis(title = list(text = "Percent Yield"))
      h1$series(name = "G Fund", data = subdata[,1], dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "F.Fund", data = subdata[,2], dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "C.Fund", data = subdata[,3], dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "S.Fund", data = subdata[,4], dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "I.Fund", data = subdata[,5], dashStyle = "longdash", marker = list(radius="1")) 
      return(h1)
    }
    
    else if(input$radio == "Prices"){
      if(input$time == "5 Years"){subdata <- tspdata[seq(1, nrow(tspdata), by=21),]}
      if(input$time == "1 Year"){subdata <- tspdata[seq(999, nrow(tspdata), by=21),]} 
      
      h1 <- Highcharts$new()
      h1$chart(type = "spline", height="450", width="900", zoomType="x")
      h1$set(dom = "prices")    
      h1$title(text = paste("TSP ", input$radio, ", Past ", input$time))      
      h1$xAxis(title = list(text = "Month"))
      h1$yAxis(title = list(text = "Price (dollars)"))
      h1$series(name = "G Fund", data = subdata$G.Fund, dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "F.Fund", data = subdata$F.Fund, dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "C.Fund", data = subdata$C.Fund, dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "S.Fund", data = subdata$S.Fund, dashStyle = "longdash", marker = list(radius="1"))
      h1$series(name = "I.Fund", data = subdata$I.Fund, dashStyle = "longdash", marker = list(radius="1")) 
      return(h1)
    }

  })
  
  
})
