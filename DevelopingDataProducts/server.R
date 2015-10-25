
#install.packages('googleVis')
library(googleVis)
library(shiny)
library(sqldf)


dPopulationFemale <- read.csv("PopulationFemale.csv")
dPopulationForeign <- read.csv("PopulationForeign.csv")

shinyServer(function(input,output) {

  output$instructions <- renderText({
    paste0(
      "Instructions: \n",
      "       The side panel is where report choices are made. \n",
      "       Choose a report, step through years, and  \n",
      "       select display options for the table. \n",
      "       Please note that these percentages are for each country's population. \n",
      "       Also, please be patient as it may take some time to color the world map. \n"
    )
  })
  
  output$credits <- renderText({
    paste0(
      "Credits: \n",
      "       All data used in these reports were extracted from \n",
      "       http://www.worldbank.org/."
    )
  })
  
  output$chosen <- renderText({
    paste0(
      "Your Choice: \n",
      "       Here are the graphs for your chosen dataset and year: \n",
      "         ",input$dataset, " ", input$year
    )
  })

  
  
  populationdata <- reactive({  
    dPFor <- paste0("select CountryCode, CountryName, printf('%.2f', Percentage) as Percentage ",
                    "from dPopulationForeign x ",
                    "where Year = '",as.character(input$year),"'"
    )
    dPFem <- paste0("select CountryCode, CountryName, printf('%.2f', Percentage) as Percentage ",
                    "from dPopulationFemale x ",
                    "where Year = '",as.character(input$year),"'"
    )
    choice <- switch(input$dataset, "Population Of Foreigners"=dPFor, "Population Of Females"=dPFem) 
    data.frame(sqldf(choice))
  })
  
  populationdatamap <- reactive({  
    dPFor <- paste0("select CountryCode, printf('%.2f', Percentage) as Percentage ",
                    "from dPopulationForeign x ",
                    "where Year = '",as.character(input$year),"'"
    )
    dPFem <- paste0("select CountryCode, printf('%.2f', Percentage) as Percentage ",
                    "from dPopulationFemale x ",
                    "where Year = '",as.character(input$year),"'"
    )
    choice <- switch(input$dataset, "Population Of Foreigners"=dPFor, "Population Of Females"=dPFem) 
    data.frame(sqldf(choice))
  })
  
  
  output$geochart <- renderGvis({  
    gvisGeoChart(data=populationdatamap(),
                 locationvar="CountryCode", colorvar="Percentage"
                 )
})  
  
  myOptions <- reactive({ 
    list( page=ifelse(input$pageable==TRUE,'enable','disable'), pageSize=input$pagesize, width=550 ) 
  }) 
  
  output$geotable <- renderGvis({ 
    gvisTable( data=populationdata(),options=myOptions() ) 
  })
  
  
}
)

