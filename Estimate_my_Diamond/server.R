## ./09_Project/Help_Me_RC  -- server.R
library(shiny)
library(ggplot2)
### --- prepare data and model for deployment level refresh
# Import only 5 columns and non- size utlyers dataset
Dia <- subset(diamonds, subset = carat < 2.7, select = c(carat:clarity, price))
Dia$carat <- round(Dia$carat, 1)
for (i in 2:4) {Dia[ , i] <- as.numeric(Dia[ , i])}

## Choosen Model - 2) Fit Model using factor -> numeric coefficient approach with 4 variables
fitDia_Nglm <- glm(price ~ carat + as.numeric(cut) + as.numeric(color) + 
                       as.numeric(clarity), data = Dia)
modelCoef <- fitDia_Nglm$coefficients

### --- Establish refreshable functions inside the App instance
shinyServer(
    function(input, output) {
        # use for testing -- left inside for QA by graders. 
        output$newdata <- reactive({
            as.numeric(c(input$carat, input$cut, input$color, input$clarity))
        })
        # to predict the estimate
        myDiamond <- reactive({
            as.numeric(c(input$carat, input$cut, input$color, input$clarity))
        })
        
        model <- as.numeric(modelCoef) # get rid of extraneous that caused issues below
        
        output$estimate <- reactive({
            round(sum(model[2:5] * myDiamond()) + model[1] , 2)    
        })  # This works were predict() didn't. values confirmed to match.
        
        estimate <- reactive({
            sum(model[2:5] * myDiamond()) + model[1]    
        })
         
        # to display the histogram of the carat size choosen
        data4Hist <- reactive({
            subset(Dia, subset = (carat == input$carat),
                            select = price)
        })
        output$histPlot <- renderPlot({hist(data4Hist()[,1],
                                        main = 'Price Spread for the Carat Size You Choose',
                                        xlab = 'Diamond Price Based only on Carat Size',
                                        col = 'light yellow')
                                       est <- estimate()
                                       abline(v = est, col = "red", lwd = 3)                              
        })
        
        # to display the correlations betwen Price and the other variables carat held constant
        data4Cor <- reactive({
            subset(Dia, subset = (carat == input$carat), select = c(cut:clarity, price))
        })
         
        output$Cor2Price <- renderText({
            cor2Out <- cor(data4Cor())
            paste0('Cut = ', round(cor(data4Cor())[4, 1], 2), ' ; ' ,
                  'Color = ', round(cor(data4Cor())[4, 2], 2), ' ; ' ,
                  'Clarity = ', round(cor(data4Cor())[4, 3], 2), ' ; ',
                  'Price = ', round(cor(data4Cor())[4, 4], 2), ' ; ' )
    })
})

