    
    library(shiny)
    library(stringr)
    library(data.table)
    
    
    gidmapdt <- data.table(read.csv("GramIdMapping.csv", skipNul = TRUE))
    colnames(gidmapdt) <- c("word1id","word2id","word3id","grams","total")
    setkey(gidmapdt,word1id,word2id,grams,total,word3id)
    
    unigramdt <- data.table(read.csv("UniGramFull.csv", skipNul = TRUE))
    colnames(unigramdt) <- c("id","word","total")
    setkey(unigramdt,word,total,id)
    
    gidmap <- NULL
    unigram <- NULL
    unknown <- "???"
    
    # Non-reactive functions that will be available to each user session
    
    # returns string w/o leading whitespace
    trim.leading <- function (x)  sub("^\\s+", "", x)
    
    # returns string w/o trailing whitespace
    trim.trailing <- function (x) sub("\\s+$", "", x)
    
    # returns string w/o leading or trailing whitespace
    trim <- function (x) gsub("^\\s+|\\s+$", "", x)
    

    

shinyServer(function(input,output,session) {

  
    observe({

      if ( length(input$inputphrase) > 0 & nchar(input$inputphrase) > 0 ) {
        
          inphrase <- trim.leading( input$inputphrase )
          lastchar <- substring(inphrase,nchar(inphrase),nchar(inphrase))
          itexttokenized <- gsub("[[:punct:]]","",inphrase,ignore.case = TRUE)[[1]]
          itexttokenized <- strsplit(itexttokenized, "\\s+")[[1]]
          numtokens <- length(itexttokenized)
          
          if ( numtokens == 1 & lastchar != " " ) {
            nextword <- toString( predictedphrase() )
            if (length(nextword) == 0) {
              nextword <- unknown
            }
            phrase <- paste(nextword,sep=" ")
            
          } else if ( lastchar != " " ) {
            nextword <- toString( predictedphrase() )
            if (length(nextword) == 0) {
              nextword <- unknown
            }
            gpos <- regexpr("\\ [^\\ ]*$", inphrase)
            inphraseminuslastgram <- substring(inphrase,1,gpos-1)
            phrase <- paste(inphraseminuslastgram,nextword,sep=" ")
            
          } else if ( lastchar == " " ) {
            nextword <- toString(predictedphrase())
            if (length(nextword) == 0) {
              nextword <- unknown
            }
            phrase <- paste(inphrase,nextword,sep="")
          }

          updateTextInput( session, "predictedphraseUI", value = paste0(phrase) )


      } else { # make sure the predicted phrase is also empty
          updateTextInput( session, "predictedphraseUI", value = paste0("") )        
      }

      
    })


    
    
    
    
    
    predictedphrase <- reactive({
  
      if (length(input$inputphrase) > 0 & nchar(input$inputphrase) > 0 ) {
              inphrase <- trim.leading( input$inputphrase )
              lastchar <- substring(inphrase,nchar(inphrase),nchar(inphrase))
              itexttokenized <- gsub("[[:punct:]]","",inphrase,ignore.case = FALSE)[[1]]
              itexttokenized <- strsplit(itexttokenized, "\\s+")[[1]]
              numtokens <- length(itexttokenized)
              if ( numtokens == 1 ) {
                  word1 <- itexttokenized[1]
                  if ( lastchar != " " ) {
                      topphrase <- tail(
                                    unigramdt[  unigramdt[  unigramdt$word %like% word1, 
                                                            .I[], 
                                                            by = total
                                                            ]$V1,
                                                word,id
                                                ]
                                    ,n=1) #[1]
                      if ( !is.na(topphrase[1,word]) ) {
                        predphrase <- topphrase[1,word]
                      } else {
                        predphrase <- suggestedword() #unknown
                      }
                      return(predphrase)
                  } else { # numtokens == 1 & lastchar == " "
                      topphrase <- tail(
                                    unigramdt[  unigramdt[  unigramdt$word == word1, 
                                                            .I[], 
                                                            by = total
                                                            ]$V1,
                                                word,id
                                                ]
                                    ,n=1)
                      if ( !is.na(topphrase[1,id]) ) {
                        w1id <- topphrase[1,id]
                      } else {
                        predphrase <- suggestedword() #unknown
                        return(predphrase)
                      }
                      
                      setkey(gidmapdt,word1id,grams,total)
                      
                      topphrase <- tail(
                                    gidmapdt[ gidmapdt[  gidmapdt$word1id == w1id & 
                                                         grams == 2, 
                                                         .I[], 
                                                         by = total
                                                         ]$V1,
                                              word2id,total
                                              ]
                                    ,n=1)
                      if ( !is.na(topphrase[1,word2id]) ) {
                        w2id <- topphrase[1,word2id]
                      } else {
                        predphrase <- suggestedword() #unknown
                        return(predphrase)
                      }
                  
                      topphrase <- tail(
                                      unigramdt[  unigramdt[  unigramdt$id == w2id, 
                                                              .I[], 
                                                              by = total
                                                              ]$V1,
                                                  word,id
                                                  ]
                                      ,n=1)
                      if ( !is.na(topphrase[1,word]) ) {
                        predphrase <- topphrase[1,word]
                      } else {
                        predphrase <- suggestedword() #unknown
                      }
                      
                  return(predphrase)
                  
                } # end of else ( numtokens == 1 & lastchar == " " )
  
                
                
              } else if ( numtokens >= 2 ) { 
  
                
                  if ( lastchar != " " ) { # use the word hint to predict the second word
                
                    word1 <- tail(itexttokenized, n=2)[1]
                    word2 <- tail(itexttokenized, n=2)[2]
                    
                    setkey(unigramdt,word)
                    
                    topword1 <- tail(
                                  unigramdt[  unigramdt[  unigramdt$word == word1, 
                                                          .I[], 
                                                          by = total
                                                          ]$V1,
                                              id,word
                                              ]
                                  ,n=1)
                    if ( !is.na(topword1[1,id]) ) {
                      w1id <- topword1[1,id]
                    } else {
                      predphrase <- suggestedword() #unknown
                      return(predphrase)                
                    }
    
                    setkey(gidmapdt,word1id,grams,total)
                    
                    topword2id <- tail(
                                  gidmapdt[ gidmapdt[  gidmapdt$word1id == w1id & 
                                                       grams == 2, 
                                                       .I[], 
                                                       by = total
                                                       ]$V1,
                                            word2id,total
                                            ]
                                  ,n=100)
                    if ( is.na(topword2id[1,word2id]) ) {
                      predphrase <- suggestedword() #unknown
                      return(predphrase)
                    }
    
    
                    setkey(unigramdt,id)
                    
                    # This commented line used -1 to balance an incorrect offset of 1
                    subunigramdt <- unigramdt[topword2id[,word2id]-1, nomatch=0]
                    topword2 <- tail(
                      subunigramdt[ subunigramdt[ subunigramdt$word %like% word2, 
                                                  .I[], 
                                                  by = total
                                                  ]$V1,
                                    word,id
                                    ]
                      ,n=1)
                    if ( !is.na(topword2[1,word]) ) {
                      predphrase <- topword2[1,word]
                    } else {
                      predphrase <- suggestedword() #unknown
                    }
                    return(predphrase)                
                  
                  
                } else { # else ( lastchar == " " ) use the word hint to predict the third word
                
                    
                    word1 <- tail(itexttokenized, n=2)[1]
                    word2 <- tail(itexttokenized, n=2)[2]
                    
                    setkey(unigramdt,word)
                    
                    topword1 <- tail(
                      unigramdt[  unigramdt[  unigramdt$word == word1, 
                                              .I[], 
                                              by = total
                                              ]$V1,
                                  id,word
                                  ]
                      ,n=1)
                    if ( !is.na(topword1[1,id]) ) {
                      w1id <- topword1[1,id]
                    } else {
                      predphrase <- suggestedword() #unknown
                      return(predphrase)                
                    }
                    
                    setkey(unigramdt,word)
                    
                    topword2 <- tail(
                      unigramdt[  unigramdt[  unigramdt$word == word2, 
                                              .I[], 
                                              by = total
                                              ]$V1,
                                  id,word
                                  ]
                      ,n=1)
                    if ( !is.na(topword2[1,id]) ) {
                      w2id <- topword2[1,id]
                    } else {
                      predphrase <- suggestedword() #unknown
                      return(predphrase)                
                    }
                    
                    setkey(gidmapdt,word1id,word2id,grams,total)
                    
                    topword3id <- tail(
                      gidmapdt[ gidmapdt[  gidmapdt$word1id == w1id & 
                                             gidmapdt$word2id == w2id & 
                                             grams == 3, 
                                           .I[], 
                                           by = total
                                           ]$V1,
                                word3id,total
                                ]
                      ,n=1)
                    if ( !is.na(topword3id[1,word3id]) ) {
                      w3id <- topword3id[1,word3id]
                    } else {
                      predphrase <- suggestedword() #unknown
                      return(predphrase)                
                    }
                    
                    setkey(unigramdt,id)
                    
                    topword3 <- tail(
                      unigramdt[ unigramdt[  unigramdt$id == w3id, 
                                             .I[], 
                                             by = total
                                             ]$V1,
                                 word,id
                                 ]
                      ,n=1)
                    if ( !is.na(topword3[1,word]) ) {
                      predphrase <- topword3[1,word]
                    } else {
                      predphrase <- suggestedword() #unknown
                    }
                    return(predphrase)                
                    
                }
                  
  
              
              
              } else { # else ( numtokens > 2 ) { use the word hint to predict the third word
  
  
                
                
                  if ( lastchar != " " ) { # do a like for the third word with the word hint
                  
                        word1 <- tail(itexttokenized, n=3)[1]
                        word2 <- tail(itexttokenized, n=3)[2]
                        word3 <- tail(itexttokenized, n=3)[3]
                        
                        topword1 <- tail(
                                        unigramdt[  unigramdt[  unigramdt$word == word1, 
                                                                .I[], 
                                                                by = total
                                                                ]$V1,
                                                    id,word
                                                    ]
                                        ,n=1)
                        if ( !is.na(topword1[1,id]) ) {
                          w1id <- topword1[1,id]
                        } else {
                          predphrase <- suggestedword() #unknown
                          return(predphrase)                
                        }
      
                        topword2 <- tail(
                          unigramdt[  unigramdt[  unigramdt$word == word2, 
                                                  .I[], 
                                                  by = total
                                                  ]$V1,
                                      id,word
                                      ]
                          ,n=1)
                        if ( !is.na(topword2[1,id]) ) {
                          w2id <- topword2[1,id]
                        } else {
                          predphrase <- suggestedword() #unknown
                          return(predphrase)                
                        }
                    
  
                        setkey(gidmapdt,word1id,word2id,grams,total)
                    
                        topword3id <- tail(
                                      gidmapdt[ gidmapdt[  gidmapdt$word1id == w1id & 
                                                           gidmapdt$word2id == w2id & 
                                                           grams == 3, 
                                                           .I[], 
                                                           by = total
                                                           ]$V1,
                                                word3id,total
                                                ]
                                      ,n=100)
                        if ( is.na(topword3id[1,word3id]) ) {
                          predphrase <- suggestedword() #unknown
                          return(predphrase)
                        }
  
                        setkey(unigramdt,id)
                        
                        # This commented line used -1 to balance an incorrect offset of 1
                        subunigramdt <- unigramdt[topword3id[,word3id]-1, nomatch=0]
                        topword3 <- tail(
                                      subunigramdt[ subunigramdt[ subunigramdt$word %like% word3, 
                                                                  .I[], 
                                                                  by = total
                                                                  ]$V1,
                                                    word,id
                                                    ]
                                      ,n=1)
                        if ( !is.na(topword3[1,word]) ) {
                          predphrase <- topword3[1,word]
                        } else {
                          predphrase <- suggestedword() #unknown
                        }
                        return(predphrase)                
  
  
                  } # else { # we want the prediction for the third word based on the two previous complete words
  
  
              } # end of else statement where numtoken > 2
  
  
        }
        
      
    })
    





  
    suggestedword <- reactive({
        
        if (length(input$inputphrase) > 0 & nchar(input$inputphrase) > 0 ) {
          itexttokenized <- strsplit(input$inputphrase, "\\s+")[[1]]
          itexttokenized <- gsub("[[:punct:]]","",itexttokenized,ignore.case = FALSE)[[1]]
          word1 <- itexttokenized[1]
          topphrase <- tail(
                unigramdt[  unigramdt[  unigramdt$word %like% word1, 
                                        .I[], 
                                        by = total
                                        ]$V1,
                            word,id
                            ]
                ,n=1)
          if ( !is.na(topphrase[1,word]) ) {
            suggword <- topphrase[1,word]
          } else {
            suggword <- ""
          }
          
        } 
      
    })
    

    output$suggestedword <- renderText({ paste0( suggestedword() ) })

  
}
)

