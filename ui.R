library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        tabsetPanel("Data Analysis",                  
                    tabPanel("Surviving or Perishing?", 
                             sidebarLayout(  
                                     sidebarPanel(
                                             h5("Have you ever thought if you would survive or perish 
                                                if you were on the RMS Titantic?"), 
                                             br(), 
                                             h5("In order to process your information, please complete the following"),
                                             br(),
                                             selectInput("Sex", "What is your sex?", 
                                                          choices = list("Male" = "male",
                                                                       "Female" = "female"), 
                                                          selected = "male"),
                                             br(),
                                             selectInput("agebrack", "What is your age?", 
                                                         choices = list("0-11 yrs old (Child)" = "Child", 
                                                                        "12-19 yrs old (Teen)" = "Teen", 
                                                                        "20-49 yrs old (Adult)" = "Adult", 
                                                                        "50+ yrs old (Older Adult)" = "Older Adult")),
                                             br(),
                                             selectInput("Pclass", "What ticket class", 
                                                         choices=list("First Class" = 1, 
                                                                      "Economy Comfort" = 2,
                                                                      "Economy" = 3), 
                                                         selected=1), 
                                             submitButton("Decide My Fate!")
                                             
                                     ),
                                     
                                     mainPanel(
                                             h2("Here We Go!"),
                                             h4("The RMS Titantic has set sail from Southampton, UK to New York, NY."),
                                             br(),
                                             h4("The RMS Titantic has hit an iceburg and did not make it to New York."),
                                             br(),
                                             h4("Are you wondering if you survived?"),
                                             br(),
                                             h2("Here Are Your Results"),
                                             "According to the information you provided, you would have",
                                             textOutput("results", container=strong), " !",
                                             tableOutput("collect.data"),
                                             br()
                                             
                                     )
                             )),
                    "Decision Tree", 
                    tabPanel("Decision Tree", 
                             mainPanel(
                                     h3("Decision Tree Algorithm Used In Prediction"), 
                                     plotOutput("decision.tree")
                                     )
                             ),
                    "Course Assignment",
                    tabPanel("Project Instructions",
                             h2("Develeping Data Products:"),
                             h3("Course Project"),
                             p("This peer assessed assignment has two parts. First, you will create a 
                               Shiny application and deploy it on Rstudio's servers. Second, you will 
                               use Slidify or Rstudio Presenter to prepare a reproducible pitch 
                               presentation about your application."), 
                             br(), 
                             h4("Your Shiny Application:"),
                             p("1.) Write a shiny application with associated supporting documentation. 
The documentation should be thought of as whatever a user will need to get started using your application."),
                             p("2.) Deploy the application on Rstudio's shiny server"),
                             p("3.) Share the application link by pasting it into the text box below"),
                             p("4.) Share your server.R and ui.R code on github"),
                             br(), 
                             h4("The application must include the following:"),
                             p("1.) Some form of input (widget: textbox, radio button, checkbox, ...)"),
                             p("2.) Some operation on the ui input in sever.R"),
                             p("3.) Some reactive output displayed as a result of server calculations"),
                             p("4.) You must also include enough documentation so that a novice user could 
                               use your application."),
                             p("5.) The documentation should be at the Shiny website itself. Do not post to 
                               an external link."),
                             br(), 
                             p("The Shiny application in question is entirely up to you. However, if you're 
                               having trouble coming up with ideas, you could start from the simple prediction 
                               algorithm done in class and build a new algorithm on one of the R datasets packages. 
                               Please make the package simple for the end user, so that they don't need a lot of 
                               your prerequisite knowledge to evaluate your application. You should emphasize a 
                               simple project given the short time frame.")
                    ),
                    tabPanel("Data Information",
                             h2("Titantic: Machine Learning from Disaster"),
                             p("Data was taken from Titantic: Machine Learning from Disaster in which is available
                               at www.kaggle.com."), 
                             br(), 
                             p("The sinking of the RMS Titanic is one of the most infamous shipwrecks in 
                               history.  On April 15, 1912, during her maiden voyage, the Titanic sank after 
                               colliding with an iceberg, killing 1502 out of 2224 passengers and crew. This 
                               sensational tragedy shocked the international community and led to better safety 
                               regulations for ships."),
                             br(),
                             p("One of the reasons that the shipwreck led to such loss of life was that there 
                               were not enough lifeboats for the passengers and crew. Although there was some 
                               element of luck involved in surviving the sinking, some groups of people were more 
                               likely to survive than others, such as women, children, and the upper-class."),
                             br(),
                             p(“In this challenge, we ask you to complete the analysis of what sorts of people 
                               were likely to survive. In particular, we ask you to apply the tools of machine 
                               learning to predict which passengers survived the tragedy.”),
                             br(),
                             p("This Kaggle Getting Started Competition provides an ideal starting place for 
                               people who may not have a lot of experience in data science and machine learning. 
                               The data is highly structured, and we provide tutorials of increasing complexity 
                               for using Excel, Python, pandas in Python, and a Random Forest in Python (see links 
                               in the sidebar). We also have links to tutorials using R instead. Please use the 
                               forums freely and as much as you like. There is no such thing as a stupid question; 
                               we guarantee someone else will be wondering the same thing!")
                    )
        )
))
