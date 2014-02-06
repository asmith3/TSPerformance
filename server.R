library(shiny)
library(rCharts)

load("oneyearyields.Rdb")
load("fiveyearyields.Rdb")
load("eightyearyields.Rdb")

shinyServer(function(input, output) {
  
  output$chart <- renderChart({
    
    if(input$radio == "1 Year Yields") {
      data <- oneyearyields[seq(1, nrow(oneyearyields), by=5),]    
    }
    if(input$radio == "5 Year Yields") {
      data <- fiveyearyields[seq(1, nrow(fiveyearyields), by=21),]
    }
    if(input$radio == "8 Year Yields") {
      data <- eightyearyields[seq(1, nrow(eightyearyields), by=21),]
    }
    
    data <- transform(data, Date = as.character(Date))
    
    m1 <- mPlot(x = "Date", y = c("S.Fund", "C.Fund", "I.Fund", "G.Fund", "F.Fund"), type = "Line", data = data, 
                labels = list("S Fund", "C Fund", "I Fund", "G Fund", "F Fund"))
    m1$set(pointSize = 0, lineWidth = 1, dom = "chart", postUnits = "%", hideHover=FALSE, fillOpacity="1.0")
    if(input$radio == "8 Year Yields") {m1$set(events=list("2008-09-01"), eventStrokeWidth = "50", eventLineColors = list("#F8F8F8"))}
    return(m1)
    
  }) #renderchart
  
  
}) #ShinyServer

