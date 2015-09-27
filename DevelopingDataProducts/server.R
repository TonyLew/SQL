
  library(shiny)

  shinyServer(
  function(input,output) {
    
    purchase <- reactive({as.numeric(input$purchase)})
    loanamt <- reactive({as.numeric(input$loanamt)})
    loanyears <- reactive({as.numeric(input$loanyears)})
    iratey <- reactive({as.numeric(input$iratey)/100})
    propertytax <- reactive({as.numeric(input$ptax)/100})   
    insurance <- reactive({as.numeric(input$insurance)})
    rent <- reactive({as.numeric(input$rent)})   
    iratem <- reactive({(iratey()/100)/12})
    payments <- reactive({loanyears()*12})
    ownmonthlyamount <- payments
    propertytaxm <- reactive({(propertytax()*purchase()) / 12})
    insurancem <- reactive({insurance()/12})
    a <- reactive({iratem()*loanamt()*((1+iratem())^payments())/(((1+iratem())^payments()) - 1)})
    ownmonthlyamount <- reactive({a() + propertytaxm() + insurancem()})

    output$purchase <- renderPrint({input$purchase})
    output$loanamt <- renderPrint({input$loanamt})
    output$loanyears <- renderPrint({input$loanyears})
    output$iratey <- renderPrint({input$iratey})
    output$ptax <- renderPrint({input$ptax})
    output$insurance <- renderPrint({input$insurance})
    output$rent <- renderPrint({input$rent})
    output$ownmonthlyamount <- renderPrint({toString(ownmonthlyamount())})

    rentpayoffmonth <- reactive({as.integer((loanamt()/rent())+1)})
    output$rentpayoffmonth <- renderPrint({rentpayoffmonth()})

    # for (i in 1:payments)
    # {
    #  renti <- renti + rent
    #  rentmonthlyamounts <- rbind(rentmonthlyamounts,renti)
    #  i <- i + 1
    # }
        
    # output$ROPlot <- renderPlot({
    # plot(rentmonthlyamounts,xlab='Months of Rent',ylab='Home Loan Amount',main='Rent VS Own')
    # abline(h=loanamt, col = "red")    
    # })
    
  }
)


