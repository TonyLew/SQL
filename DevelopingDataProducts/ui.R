
# runApp(display.mode = "showcase")

  shinyUI(pageWithSidebar(
    headerPanel("Country Population Percentages"),

    sidebarPanel( 
      h1("Report Choices"),
      selectInput("dataset", "Choose a dataset:", choices = c("Population Of Foreigners", "Population Of Females")), 
      h1("Interactive Control"),
      sliderInput("year", "Year to be displayed:", min=2000, max=2014, value=2000, step=1, sep="", animate=TRUE) ,
      checkboxInput(inputId = "pageable", label = "Pageable"),
      conditionalPanel("input.pageable==true",
                      numericInput(inputId = "pagesize",
                      label = "Countries per page",10)
                      )    
    ),
  mainPanel(

        verbatimTextOutput("instructions"),
        verbatimTextOutput("credits"),
        verbatimTextOutput("chosen"),
        htmlOutput("geochart"),
        htmlOutput("geotable")         
        
      )
  )
  )

  
