library(shiny)
library(rCharts)

load("tspdata.Rdb")

tspdata$Date <- as.numeric(
  as.POSIXct(tspdata$Date, origin="1970-01-01")
) * 1000

h1 <- hPlot(x = "Date", y = "F.Fund", data = tspdata, type = "line")


m1 <- mPlot(x = "Date", y = c("G.Fund", "F.Fund"), type = "Line", data = tspdata)
m1$set(pointSize = 0, lineWidth = 1)
m1$print("chart2")