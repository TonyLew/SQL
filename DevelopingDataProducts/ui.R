
# runApp(display.mode = "showcase")

  library(shiny)
  shinyUI(pageWithSidebar(
    headerPanel("Developing Data Products Project"),
    sidebarPanel(
      h1("Input Details"),
      numericInput("purchase","Purchase Price",350000,min=1,max=50000000),
      numericInput("loanamt","Loan Amount",300000,min=0,max=10,step=1),
      numericInput("loanyears","Loan Term Years",30,min=1,max=50),
      numericInput("iratey","Interest Rate",5,min=0,max=20,step=.25),
      numericInput("ptax","Property Tax Percentage",1,min=0,max=10,step=1),
      numericInput("insurance","Annual Insurance Amount",1200,min=0,max=10,step=1),
      numericInput("rent","Monthly Rent Amount",2000,min=0,max=10,step=1),
      submitButton("Submit")
    ),

      mainPanel(
        h3("Loan Payoff Schedule"),
        h4("This website will calculate the total number of months it will take to pay off your "),
        h4("mortgage with the amount of rent you are currently paying"),
        h3(""),
        h4("The purchase price you entered"),
        verbatimTextOutput("purchase"),
        h4("The loan term in years you entered"),
        verbatimTextOutput("loanyears"),
        h4("The interest rate you entered"),
        verbatimTextOutput("iratey"),
        h4("The annual property tax you entered"),
        verbatimTextOutput("ptax"),
        h4("The annual property insurance amount you entered"),
        verbatimTextOutput("insurance"),
        h4("The rent you entered"),
        verbatimTextOutput("rent"),
        h4("The loan amount you entered"),
        verbatimTextOutput("loanamt"),
        h3(""),
        h4("Your monthly payment amount is: "),
        verbatimTextOutput("ownmonthlyamount"),
        h3(""),
        h4("The total number of months it will take to payoff "),
        h4("the loan amount if you had purchased a home: "),
        verbatimTextOutput("rentpayoffmonth"),
        h3(""),
        plotOutput("ROPlot", width = 400, height = 300)
        
      )
  )
  )

  
