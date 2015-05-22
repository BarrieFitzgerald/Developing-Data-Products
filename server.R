library(shiny)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(ggplot2)

train <- read.csv("./train.csv")

cleanup <- function(x) {
        data <- x
        ## age bracket function
        age.bracket <- function(x) {
                train <- x
                ## separating out the age data
                age <- as.data.frame(train[, 6])
                colnames(age) <- "ageraw"
                ## Age Groups
                age$age <- age$ageraw
                age$age[is.na(age$ageraw) == TRUE] <- 999999        
                age$agebrack <- "Teen"
                age$agebrack[age$age < 11] <- "Child"
                age$agebrack[age$age >= 20] <- "Adult"
                age$agebrack[age$age >= 50] <- "Older Adult"
                age$agebrack[age$age == 999999] <- "Unknown"
                ## removing old age data
                age <- age[, -1]
                ## remaining data...nothing is done to it
                data <- train[, -6]
                ## combining the data back together
                train <- cbind(data, age)
        }
        ## applying the age bracket function
        data <- age.bracket(data)
        ## Personal Title Function
        titles <- function(x) {
                train <- x
                ## separating the names out
                titles <- as.data.frame(train$Name)
                colnames(titles) <- "names"
                titles$names <- as.character(titles$names)
                ## spliting names of indiviuals
                ## separate function
                separate <- function(x) {strsplit(x, split='[,.]')[[1]][2]}
                titles$titles <- sapply(titles$names,
                                        FUN = separate)
                titles$titles <- sub(" ", "", titles$titles)
                ## adjusting the names of the individuals
                titles$titles[titles$titles %in% c('Mme', 'Mlle')] <- 'Mlle'
                titles$titles[titles$titles %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
                titles$titles[titles$titles %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'
                titles$titles[titles$titles %in% c('Mrs', 'Ms')] <- 'Mrs.Ms'
                titles$titles <- factor(titles$titles)
                ## remaining data...nothing is done with it
                data <- train[,-4]
                ## combining the data back together
                train <- cbind(data, titles)
        }
        ## applying the titles function
        data <- titles(data)
        ## Age adjustment function based on titles
        age.cleanup <- function(x) {
                train2 <- x
                data <- train2[, c(11, 14, 12)]
                ## adjusting ages based on titles
                data$agebrack.new <- data$agebrack
                data$agebrack.new[train2$age == 999999 &
                                          train2$titles == "Master"] <- "Child"
                data$agebrack.new[train2$age == 999999 &
                                          train2$titles == "Mr"] <- "Adult"
                data$agebrack.new[train2$age == 999999 &
                                          train2$titles == "Mrs"] <- "Adult"
                data$agebrack.new[train2$age == 999999 &
                                          train2$titles == "Miss"] <- "Adult"
                data$agebrack.new[train2$age == 999999 &
                                          train2$titles == "Ms"] <- "Adult"
                data$agebrack.new[train2$age == 999999 &
                                          train2$titles == "Mrs.Ms"] <- "Adult"
                ## keeping only the new age brackets
                data <- as.data.frame(data[, 4])
                colnames(data) <- "agebrack"
                ## remaining data...nothing done to it
                train2 <- train2[, -12]
                ## combine the data back together
                train2 <- cbind(train2, data)
        }
        ## applying the age bracket clean up function
        data <- age.cleanup(data)
}

train <- cleanup(train)


shinyServer(
        function(input, output) {
                collect.data <- reactive({
                        data.frame(Sex = input$Sex, 
                                   agebrack = input$agebrack, 
                                   Pclass = input$Pclass)
                })
                output$collect.data <- renderTable({
                        collect.data()
                })
                output$results <- renderText({
                        fit <- rpart(formula = Survived ~ Sex + agebrack + Pclass, 
                                     data = train, control=rpart.control(minsplit=2, cp=0), 
                                     method = "class")
                        collected.data <- data.frame(Sex = input$Sex, 
                                                     agebrack = input$agebrack, 
                                                     Pclass = as.numeric(input$Pclass))
                        prediction <- ifelse(predict(fit, collected.data, type = "class") == 0, "perished", "survived")
                        write.csv(prediction, "prediction.csv")
                        return(as.character(prediction))
                })
                output$decision.tree <- renderPlot({
                        fit <- rpart(formula = Survived ~ Sex + agebrack + Pclass, 
                                     data = train, control=rpart.control(minsplit=2, cp=0), 
                                     method = "class")
                        fancyRpartPlot(fit)
                })
                
        })
