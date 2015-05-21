library(shiny)

source(file = "titantic.R")

shinyServer(
        function(input, output){
                output$text1 <- renderText({
                        paste("You are a", 
                              input$Sex, 
                              "who is a (an)",
                              tolower(input$agebrack), 
                              "in class ", 
                              paste(input$Pclass,
                                    ".", 
                                    sep = ""),
                              sep = " ")
                }), 
                output$Sex <- renderPlot({
                        
                })
        })
