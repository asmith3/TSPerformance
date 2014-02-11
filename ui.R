##################################################################################################################
#                                                                                                                #
#  This is the companion script to "server.R", which is the other script required to run Shiny applications      #
#                                                                                                                #
##################################################################################################################

# To learn more about the Shiny package, visit http://www.rstudio.com/shiny/

# If you are new to R, check out Anthony Damico's 'two minute tutorials' at http://www.twotorials.com/

# Special thanks to Joe Cheng (github: jcheng5) for his bootstrap and css templates

#-----------------------------------------------------------------------------------------------------------------

library(shiny)      # Load the shiny package

library(rCharts)    # Load rCharts, the javascript wrapper for various js visualizations
                    # more info rCharts is available at http://ramnathv.github.io/rCharts/

# define the functions that pass ui definitions to the bootstrapPage function
row <- function(...) {
  tags$div(class="row", ...)
}

col <- function(width, ...) {
  tags$div(class=paste0("span", width), ...)
}

# begin the ui definition

# instead of pre-defined templates available in the shiny package (ex pageWithSidebar),
# a bootstrap page makes use of the Twitter Bootstrap CSS framwork that allows for full control of the ui
shinyUI(bootstrapPage(
  
  #"href='styles.css'" references the file in [www/] to overwrite the standard css definitions
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),
  
  tags$div(
    class = "container",
    
    # adds a break up top for aesthetics    
    tags$p(tags$br()),
    
    # ui definition using the bootstrapPage function uses the previously defined functions, generally nested as row(col(...),...),
    # where row defines the next row, and column defines the next column within the row, and its span (width) as col(span,...)    
    row(
      h1('Thrift Savings Plan Account Yields',align="center")
    ),
    
    row(
      HTML("<center><a href=http://en.wikipedia.org/wiki/Thrift_Savings_Plan>(What's a Thrift Savings Plan?)</a></center>")
    ),
    
    #horizontal rule, may not render in some IE versions
    tags$hr(),
    
    row(
      col( 2, tags$br()),
      col( 3, h4("Select Time Frame:", align="right")),      
      col( 4, 
           gsub("label class=\"radio\"", "label class=\"radio inline\"", 
                radioButtons(inputId = "radio", label="", choices = c(paste("1 Year Yields"), paste("5 Year Yields"), paste("8 Year Yields")) )), align="left"
          )    
    ),
    
    # horizontal rule
    tags$hr(),    
    
    row(
      col( 1, tags$br()),
      
      # hard-coded axis label, as morris chart doesn't seem to provide this
      col( 2, h4("Percent Yield"), align = "center"),
      
      col( 12, align="center",
           
           # carries morris chart over to the ui, using the 'dom=' name from the file, and the type of chart
           showOutput("chart","morris")
      )
    ),
    
    # hard-coded axis label, as morris chart doesn't seem to provide this
    row(h4("Time"), align="center"),
    
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
           See code on <a href=https://github.com/asmith3/TSPerformance><img src="gitlogo.png" width="5%" height="5%"></a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspv1.3
           ')
      )
    
      )   #tags$div 
    ) #bootstrap  
    ) #shinyUI





