
# runApp(display.mode = "showcase")

  library(shiny)
#   library(shinyapps)

  shinyUI(fluidPage(

    sidebarPanel( 
      
      h3("Description"),
      HTML('<hr style="color: black;">'),
      h5("This will predict the next word "),
      h5("based on the given phrase."),
      h5("..."),
      h5("Please be patient as there "),
      h5("may be a delay in predicting "),
      h5("the next word."),
      HTML('<hr style="color: black;">'),
      h5("Included is a word suggestion "),
      h5("that exists in addition "),
      h5("to the phrase prediction."),
      HTML('<hr style="color: black;">'),
      textOutput("suggestedword"),
      HTML('<hr style="color: black;">')
      
    ),
    
  mainPanel(

    titlePanel("Type Ahead Word Prediction"),
    HTML('<hr style="color: black;">'),
    textInput("inputphrase", label = "Enter Phrase"),
    HTML('<hr style="color: black;">'),
    textInput("predictedphraseUI", label = "Predicted Phrase" ),
    HTML('<hr style="color: black;">')

      )

  ))

  
