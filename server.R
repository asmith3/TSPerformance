library(shiny)
library(rCharts)

load("tspdata.Rdb")

oneyearlabels<-c("JAN'12","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC","JAN'13")
fiveyearlabels<-c("J","F","M","A","M","J","J","A","S","O","N","D")

shinyServer(function(input, output) {
  
  output$chart <- renderChart({
    
    if(input$radio == "Yields of Funds") {
      if(input$time == "5 Years"){subdata <- tspdata[,18:22][seq(1, nrow(tspdata), by=21),]; 
                                  labels<-c(fiveyearlabels,fiveyearlabels,fiveyearlabels,fiveyearlabels,fiveyearlabels,"J")
                                  
                                  c <- Highcharts$new()
                                  c$chart(type = "spline", height="500", width="900", zoomType="x")
                                  c$title(text = paste("TSP ", input$radio, ", Past ", input$time))
                                  c$set(dom = "chart")
                                  
                                  c$xAxis(title = list(text = "Month"), categories = labels
                                          , plotLines = (list(list(value=12, color='#A0A0A0', width=.75, dashStyle='longdash'),
                                                              list(value=24, color='#A0A0A0', width=.75, dashStyle='longdash'),
                                                              list(value=36, color='#A0A0A0', width=.75, dashStyle='longdash'),
                                                              list(value=48, color='#A0A0A0', width=.75, dashStyle='longdash')
                                          )))
                                  c$yAxis(title = list(text = "Percent Yield"))
                                  
                                  c$exporting(enabled = T)
                                  c$credits(text="Data by www.TSPcenter.com",href="http://www.TSPcenter.com")
                                  
                                  c$series(name = "G Fund", data = subdata[,1], dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "F Fund", data = subdata[,2], dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "C Fund", data = subdata[,3], dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "S Fund", data = subdata[,4], dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "I Fund", data = subdata[,5], dashStyle = "Solid", marker = list(enabled=FALSE))
                                  return(c)      
      }
      if(input$time == "1 Year"){subdata <- tspdata[,13:17][seq(998, nrow(tspdata), by=21),]
                                 labels<-oneyearlabels
      } 
      
      c <- Highcharts$new()
      c$chart(type = "spline", height="500", width="900", zoomType="x")
      c$title(text = paste("TSP ", input$radio, ", Past ", input$time))
      c$set(dom = "chart")
      
      c$xAxis(title = list(text = "Month"), categories = labels)
      c$yAxis(title = list(text = "Percent Yield"))
      
      c$exporting(enabled = T)
      c$credits(text="Data by www.TSPcenter.com",href="http://www.TSPcenter.com")
      
      c$series(name = "G Fund", data = subdata[,1], dashStyle = "Solid", marker = list(enabled=FALSE))
      c$series(name = "F Fund", data = subdata[,2], dashStyle = "Solid", marker = list(enabled=FALSE))
      c$series(name = "C Fund", data = subdata[,3], dashStyle = "Solid", marker = list(enabled=FALSE))
      c$series(name = "S Fund", data = subdata[,4], dashStyle = "Solid", marker = list(enabled=FALSE))
      c$series(name = "I Fund", data = subdata[,5], dashStyle = "Solid", marker = list(enabled=FALSE)) 
      return(c)
    }
    
    else if(input$radio == "Prices of Funds"){
      if(input$time == "5 Years"){subdata <- tspdata[,8:12][seq(1, nrow(tspdata), by=21),]; 
                                  labels<-c(fiveyearlabels,fiveyearlabels,fiveyearlabels,fiveyearlabels,fiveyearlabels,"J")
                                  
                                  c <- Highcharts$new()
                                  c$chart(type = "spline", height="500", width="900", zoomType="x")
                                  c$set(dom = "chart")    
                                  c$title(text = paste("TSP ", input$radio, ", Past ", input$time)) 
                                  
                                  c$xAxis(title = list(text = "Month"), categories = labels
                                          , plotLines = (list(list(value=12, color='#A0A0A0', width=.75, dashStyle='longdash'),
                                                              list(value=24, color='#A0A0A0', width=.75, dashStyle='longdash'),
                                                              list(value=36, color='#A0A0A0', width=.75, dashStyle='longdash'),
                                                              list(value=48, color='#A0A0A0', width=.75, dashStyle='longdash')
                                          )))
                                  c$yAxis(title = list(text = "Price (dollars)"),min=0)
                                  
                                  c$exporting(enabled = T)
                                  c$credits(text="Data by www.TSPcenter.com",href="http://www.TSPcenter.com")                                  
                                  
                                  c$series(name = "G Fund", data = subdata$G.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "F Fund", data = subdata$F.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "C Fund", data = subdata$C.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "S Fund", data = subdata$S.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                  c$series(name = "I Fund", data = subdata$I.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                  return(c)
      }
      if(input$time == "1 Year"){subdata <- tspdata[,8:12][seq(998, nrow(tspdata), by=21),]
                                 labels<-oneyearlabels 
                                 
                                 c <- Highcharts$new()
                                 c$chart(type = "spline", height="500", width="900", zoomType="x")
                                 c$set(dom = "chart")    
                                 c$title(text = paste("TSP ", input$radio, ", Past ", input$time))
                                 
                                 c$xAxis(title = list(text = "Month"), categories = labels)
                                 c$yAxis(title = list(text = "Price (dollars)"),min=0)
                                 
                                 c$exporting(enabled = T)
                                 c$credits(text="Data by www.TSPcenter.com",href="http://www.TSPcenter.com")
                                 
                                 c$series(name = "G Fund", data = subdata$G.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                 c$series(name = "F Fund", data = subdata$F.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                 c$series(name = "C Fund", data = subdata$C.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                 c$series(name = "S Fund", data = subdata$S.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                 c$series(name = "I Fund", data = subdata$I.Fund, dashStyle = "Solid", marker = list(enabled=FALSE))
                                 c$exporting(enabled = T)
                                 return(c)
      }
    }
    
  }) #renderchart
  
  
}) #ShinyServer

