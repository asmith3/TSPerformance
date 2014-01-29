library(shiny)
library(rCharts)

row <- function(...) {
  tags$div(class="row", ...)
}

col <- function(width, ...) {
  tags$div(class=paste0("span", width), ...)
}

shinyUI(bootstrapPage(
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),
  
  tags$div(
    class = "container",
    
    tags$p(tags$br()),
    
    row(
      h1('Thrift Savings Performance',align="center")
    ),
    
    tags$hr(), #horizontal rule, may not render in some IE versions
  
    row(
      col( 4,tags$br()),
      col( 2, h4("Select Chart Type:", align="right")),
      
      col( 3, 
           gsub("label class=\"radio\"", "label class=\"radio inline\"", 
                radioButtons(inputId = "radio", label="", choices = c("Yields", "Prices"))), align="left"
        )    
      ),
    
    row(
      col( 4,tags$br()),      
      col( 2, h4("Select Time Period:", align="right")),      
      col( 3, 
                   gsub("label class=\"radio\"", "label class=\"radio inline\"", 
                        radioButtons(inputId = "time", label="", choices = c("1 Year", "5 Years"))), align="left"
        )
      ),
    
    tags$hr(),    
    
    row( 
      col( 12, align="center",
           showOutput("prices","Highcharts")
        )
      ),

    tags$hr(),
    
    row(
      col( 3,(tags$br())),
      HTML('<p style="margin:0;">This app licensed under <a href="http://www.gnu.org/licenses/gpl.html">GPL-3</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
          Hosted by <a href="aws.amazon.com"><img src="awslogo.jpg" width="7%" height="7%"></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
           Powered by <a href="http://www.rstudio.com/shiny/"><img src="RstudioLogo.png" width="7%" height="7%"></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
             See code at <a href="https://github.com/asmith3"><img src="gitlogo.png" width="5%" height="5%"></a>
           ')
    )
        
  )   #tags$div 
) #bootstrap  
) #shinyUI

