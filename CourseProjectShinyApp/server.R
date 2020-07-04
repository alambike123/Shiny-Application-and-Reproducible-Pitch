library(shiny)
library(HistData)
library(dplyr)
library(ggplot2)


#Transforming the variable am to factor. 
mtcars$am = as.factor(mtcars$am)

# linear model
regmod <- lm(mpg ~  am + hp + wt, data = mtcars)

shinyServer(function(input, output) {
    output$parentsText <- renderText({
        paste("When the HP is",
              strong(round(input$Hp, 1)),
              ", and WT is",
              strong(round(input$Wt, 1)),
              ", for the transmission:")
    })
    output$prediction <- renderText({
        df <- data.frame(hp=input$Hp,
                         wt=input$Wt,
                         am=factor(input$am, levels=levels(mtcars$am)))
        ch <- predict(regmod, newdata=df)
        sord <- ifelse(
            input$am=="0",
            "Automatic",
            "Manual"
        )
        paste0(em(strong(sord)),
               ". The predicted Miles/(US) gallon (mpg) would be approximately ",
               em(strong(round(ch)))
        )
    })
    
    output$barsPlot <- renderPlot({
        sord <- ifelse(
            input$am=="0",
            "Automatic",
            "Manual"
        )
        df <- data.frame(hp=input$Hp,
                         wt=input$Wt,
                         am=factor(input$am, levels=levels(mtcars$am)))
        
        ch <- predict(regmod, newdata=df)
        
        yvals <- c("MPG", "Gross horsepower (HP)", "Weight (1000 lbs) (WT)")
        
        df <- data.frame(
            x = factor(yvals, levels = yvals, ordered = TRUE),
            y = c(ch, input$Hp, input$Wt),
            colors = c("red", "green", "blue")
        )
        
        ggplot(df, aes(x=x, y=y, color=colors, fill=colors)) +
            geom_bar(stat="identity", width=0.5) +
            xlab("") +
            ylab("MPG - Miles/(US) gallon") +
            theme_minimal() +
            theme(legend.position="none")
    })
})