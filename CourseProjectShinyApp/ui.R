library(shiny)

shinyUI(fluidPage(
    titlePanel("Prediction of Miles/(US) gallon from the mtcars dataset"),
    sidebarLayout(
        sidebarPanel(
            helpText("Select the weight (wt), horsepower (HP), and transmission parameters:"),
            sliderInput(inputId = "Hp",
                        label = "HP is:",
                        value = 75,
                        min = 1,
                        max = 100,
                        step = 1),
            sliderInput(inputId = "Wt",
                        label = "WT is:",
                        value = 5,
                        min = 0,
                        max = 15,
                        step = 1),
            radioButtons(inputId = "am",
                         label = "Transmission type: ",
                         choices = c("automatic"="0", "manual"="1"),
                         inline = TRUE)
        ),
        
        mainPanel(
            htmlOutput("parentsText"),
            htmlOutput("prediction"),
            plotOutput("barsPlot", width = "50%")
        )
    )
))