##################################################################################################################
#                                                                                                                #
# This is the companion script to "ui.R", which is the other script required to run Shiny applications           #
#                                                                                                                #
##################################################################################################################

# To learn more about the Shiny package, visit http://www.rstudio.com/shiny/

# If you are new to R, check out Anthony Damico's 'two minute tutorials' at http://www.twotorials.com/

# Special thanks to Ramnath Vaidyanathan (github: ramnathv) for his rCharts package

#-----------------------------------------------------------------------------------------------------------------

require(shiny)      # Load the shiny package

require(rCharts)    # Load rCharts, the javascript wrapper for various js visualizations
                    # more info rCharts is available at http://ramnathv.github.io/rCharts/

# load the datasets comprised of yields for different thrift savings plan accounts
load("oneyearyields.Rdb")
load("fiveyearyields.Rdb")
load("eightyearyields.Rdb")

# although there are more thrift savings plans than listed here, this demo app only makes use of the G,F,I,C, and S funds


# the shinyServer function in part defines what will change within your application

# notice items that begin with input$ , which link to the items defined in the ui.R script
shinyServer(function(input, output) {
  
  
  # the (javascript based) morris chart is the only thing that changes in the ui, so it is the only thing defined in shinyServer()
  output$chart <- renderChart({
    
    # the base data for the graphic is assigned to an object based on which radio button is selected in the ui
    if(input$radio == "1 Year Yields") {
      data <- oneyearyields[seq(1, nrow(oneyearyields), by=5),]       # these seq() take a subset of the data in order to speed up 
    }                                                                 # the rendering of the graphic; you can remove the subset for 
    if(input$radio == "5 Year Yields") {                              # higher resolution
      data <- fiveyearyields[seq(1, nrow(fiveyearyields), by=21),]
    }
    if(input$radio == "8 Year Yields") {
      data <- eightyearyields[seq(1, nrow(eightyearyields), by=21),]
    }
    
    # morris charts play nicer with your dates as character objects 
    data <- transform(data, Date = as.character(Date))
    
    # mPlot specifies using a morris plot in the rCharts package
    # see the morris chart API for chart options: http://www.oesmith.co.uk/morris.js/lines.html (line and area charts)
    #                                                  http://www.oesmith.co.uk/morris.js/bars.html (bar charts)
    
    # alternatives include hPlot for highcharts, and rPlot for polycharts (via the rCharts package)
    
    # something didn't like spaces in list for y-values, so you can rename them directly with 'labels'
    m1 <- mPlot(x = "Date", y = c("S.Fund", "C.Fund", "I.Fund", "G.Fund", "F.Fund"), type = "Line", data = data,
                
                # morris chart seems to prefer no spaces in the column names, so this line hardcodes nicer looking labels
                labels = list("S Fund", "C Fund", "I Fund", "G Fund", "F Fund"),
                
                # list html color codes to replace default scheme
                # these color choices attempt to make the chart readable to those who are color-deficient
                lineColors = list("#006699","#FF0000","#006600","#330066","#666600")
                )
    
    # use a 'set' statement to apply options found in the API. multiple set statements are allowed
    
    # "dom = 'chart'" seems necessary to successfully carry the chart over to the ui
    # 'hideHover' is set to false given that it seems morris charts do not allow for static legends
    # as seen in ui.R axis labels are hard-coded into the ui given it seems morris charts do not allow for axis labels
      m1$set(pointSize = 0, lineWidth = 1.05, dom = "chart", postUnits = "%", hideHover=FALSE, fillOpacity="1.0")
    
    # this creates a recession plot band only when the user requests a time frame that includes it
      if(input$radio == "8 Year Yields") {m1$set(events=list("2008-09-01"), eventStrokeWidth = "50", eventLineColors = list("#F8F8F8"))}
    
    # return the plot
      return(m1)
    
  }) # end renderChart
  
  
}) #end shinyServer

