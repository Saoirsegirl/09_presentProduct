## ./09_Project/Help_Me_RC  -- ui.R
library(shiny)
library(ggplot2)

dataset <- diamonds

fluidPage(
    titlePanel("Diamond Price Estimator"),
    sidebarLayout(
        sidebarPanel(
            h3("Enter the 4 C's of Diamonds"),
            #tags$a(href="http://www.lumeradiamonds.com/diamond-education/choose-a-diamond", "Choosing A Diamond"),
            p("The price of a diamond is primarily defined by the 4 C's. They are 
              listed here in order of general importance - although the links attached 
              to each will more fully explain the situations when 'Cut' or 'Clarity 
              may trade places."), 
            
            h4("Size in Carats"),
            #tags$a(href="http://www.lumeradiamonds.com/diamond-education/diamond-carat-weight", "Learn More"),
            sliderInput('carat', label = "",
                        min= min(dataset[1]), max=max(dataset[1]),
                        value= 1, step= 0.1, round = FALSE),
           
            h4("Cut Quality"),
            #tags$a(href="http://www.lumeradiamonds.com/diamond-education/diamond-cut", "Learn More"),
            selectInput(inputId = "cut", label = "",
                        choices = c("Fair" = 1,
                                    "Good" = 2,
                                    "Very Good" = 3,
                                    "Premium" = 4,
                                    "Ideal" = 5),
                        selected = 4),
            
            h4("Color"),
            #tags$a(href="http://www.lumeradiamonds.com/diamond-education/diamond-color", "Learn More"),
            selectInput(inputId = "color", label = '', 
                        choices = c("D" = 1, 
                                    "E" = 2, 
                                    "F - Colorless" = 3,
                                    "G - Near Colorless" = 4,
                                    "H" = 5,
                                    "I" = 6,
                                    "J" = 7),
                        selected = 4),
            h4("Level of Clarity"),
            #tags$a(href='http://www.lumeradiamonds.com/diamond-education/diamond-clarity', 'Learn More'),
            selectInput(inputId = "clarity", label = '', 
                        choices = c("I1 - Included" = 1,
                                    "SI2 - Slighlty Included" = 2,
                                    "SI1" = 3,
                                    "VS2 - Rarely seen with naked eye" = 4,
                                    "VS1" = 5,
                                    "VVS2 - Under 10x magnification only" = 6,
                                    "VVS1" = 7),
                        selected = "4")
        ),
        
        mainPanel(
            h4("Your 4 C's Selections Would Have an Estimated Price Of:"),
            textOutput('estimate'), 
            plotOutput('histPlot'),
            p("The range of prices reflect additional factors outside of the 4 C's. As well as the changing importance of 'Cut', 'Color' and 'Clarity' as the size increases and decreases from the mean size of 0.75 carats. Below are the correlations of price to the other 3 C's as you cahnge the carat size of your selections."),
            textOutput('Cor2Price'),
            p("A positive corelation would add cost for each choice lower on the selection list. Color has a reducing effect as you go down the list."),
            p("Other influence on price - not included here are 'Shape' and 'Depth'"),
            p("Input Values Check:"),
            textOutput('newdata')
        )
    )
)