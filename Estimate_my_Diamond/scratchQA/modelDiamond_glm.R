## model_Diamond.R

library('ggplot2')
library('stats')

# Import only 5 columns and non- size utlyers dataset
data4model <- subset(diamonds, subset = carat < 2.7, select = c(carat:clarity, price))

### Train at least three models and choose one.  See Model testing for full code used to test and compare.
## Choosen Model -- 
# 2) Fit Model using factor -> numeric coefficient approach with 4 variables
fitDia_Nglm <- glm(price ~ carat + as.numeric(cut) + as.numeric(color) + 
                    as.numeric(clarity), data = data4model)
modelDia_Nglm <- coef(fitDia_Nglm)

# modelNglmDF <- data.frame(icept = modelDia_Nglm[1],
#                          carat = modelDia_Nglm[2],
#                          cut = modelDia_Nglm[3],
#                          color = modelDia_Nglm[4],
#                          clarity = modelDia_Nglm[5])

# saveRDS(modelDia_Nglm, file="modelDia.rds")
# modelDia <- readRDS("modelDia.rds")

## 3) Fit Model using factor -> numeric coefficient approach with 7 variables
# fitDia_Nglm2 <- glm(price ~ carat + as.numeric(cut) + as.numeric(color) + 
#                      as.numeric(clarity) + depth + table + x, data = data4model)
# 
# modelDia_Nglm2 <- fitDia_Nglm$coefficients

## 1) Fit Model using ordered factor polynomial approach
# fitDia_glm <- glm(price ~ carat + cut + color + clarity, data = data4model)
# modelDia_glm <- fitDia_glm$coefficients
