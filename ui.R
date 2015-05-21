library(shiny)
shinyUI(fluidPage(
        titlePanel(strong("Would You Survive The Titantic?")),
        
        sidebarLayout(position = "left",
                sidebarPanel(
                        h3("Ticket Information:"), 
                        h4("Please complete the following:"), 
                        selectInput(inputId = "Sex", label = "Your Sex:", 
                                     choices = list("Male" = "male", 
                                                    "Female" = "female"), 
                                     selected = 1),
                        selectInput(inputId = "agebrack", label = "Your Age:", 
                                    choices = list("0-11 yrs old (Child)" = "Child", 
                                                   "12-19 yrs old (Teen)" = "Teen", 
                                                   "20-49 yrs old (Adult)" = "Adult", 
                                                   "50+ yrs old (Older Adult)" = "Older Adult"), 
                                    selected = 1),
                        selectInput(inputId = "Pclass", label = "Ticket Class: ",
                                           choices = list("First Class (1)" = 1, 
                                                          "Economy Comfort (2)" = 2, 
                                                          "Economy (3)" = 3), 
                                           selected = 1),
                        submitButton("Submit")
                        ),
                mainPanel(
                        h3("Based on the information you provided", align = "left"),
                        h4(textOutput("text1"))
                )
        )
))
