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
      h1('Thrift Savings Plan Account Yields',align="center")
    ),
    
    row(
      HTML("<center><a href=http://en.wikipedia.org/wiki/Thrift_Savings_Plan>(What's a Thrift Savings Plan?)</a></center>")
    ),
    
    tags$hr(), #horizontal rule, may not render in some IE versions
    
    row(
      col( 2, tags$br()),
      col( 3, h4("Select Chart Timeline:", align="right")),
      
      col( 4, 
           gsub("label class=\"radio\"", "label class=\"radio inline\"", 
                radioButtons(inputId = "radio", label="", choices = c(paste("1 Year Yields"), paste("5 Year Yields"), paste("8 Year Yields")) )), align="left"
      )    
    ),
    
    tags$hr(),    
    
    row( 
      col( 12, align="center",
           showOutput("chart","morris")
      )
    ),
    
    row(
      col( 8, tags$br()),
      col( 4, HTML("Data provided by <a href=http://www.tspcenter.com>tspcenter.com</a>"))
    ),
    
    tags$hr(),
    
    row(
      col( 3,(tags$br())),
      HTML('<p style="margin:0;">This app licensed under <a href=http://www.gnu.org/licenses/gpl.html>GPL-3</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
          Hosted by <a href=http://aws.amazon.com><img src="awslogo.jpg" width="7%" height="7%"></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
           Powered by <a href=http://www.rstudio.com/shiny/><img src="RstudioLogo.png" width="7%" height="7%"></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
             See code on <a href=https://github.com/asmith3/TSPerformance><img src="gitlogo.png" width="5%" height="5%"></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspv1.2
           ')
    )
    
  )   #tags$div 
) #bootstrap  
) #shinyUI





