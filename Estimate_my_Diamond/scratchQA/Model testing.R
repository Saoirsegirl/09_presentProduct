### testing 3 approaches to a GLM fit

# Fit Model using ordered factor polynomial approach - On 4 data predictors
fitDia_glm <- glm(price ~ carat + cut + color + clarity, data = data4model)

modelDia_glm <- fitDia_glm$coefficients

# Fit Model using factor -> numeric coefficient approach - On 4 Predictors
fitDia_Nglm <- glm(price ~ carat + as.numeric(cut) + as.numeric(color) + 
                     as.numeric(clarity), data = Dia)

modelDia_Nglm <- fitDia_Nglm$coefficients

# Fit Model using factor -> numeric coefficient approach - On 7 Predictors
fitDia_Nglm2 <- glm(price ~ carat + as.numeric(cut) + as.numeric(color) + 
                      as.numeric(clarity) + depth + table + x, data = data4model)

modelDia_Nglm2 <- fitDia_Nglm$coefficients

# Test potential factor vs numeric inputs
guess = data.frame(carat = 1.0, cut = "Very Good", color = "F", clarity = "SI1")
guess2 = data.frame(carat = 2.0, cut = "Very Good", color = "F", clarity = "VS2")
guess3 = data.frame(carat = 0.5, cut = "Very Good", color = "F", clarity = "VVS2")

nguess = data.frame(carat = 1.0, cut = 3, color = 3, clarity = 2)
nguess2 = data.frame(carat = 2.0, cut = 3, color = 3, clarity = 4)
nguess3 = data.frame(carat = 0.5, cut = 3, color = 3, clarity = 6)

outDia_glm = predict(fitDia_glm, newdata = guess)
outDia_glm2 = predict(fitDia_glm, newdata = guess2) 
outDia_glm3 = predict(fitDia_glm, newdata = guess3)

outDia_Nglm = predict(fitDia_Nglm, newdata = nguess)
outDia_Nglm2 = predict(fitDia_Nglm, newdata = nguess2) 
outDia_Nglm3 = predict(fitDia_Nglm, newdata = nguess3)

summary(fitDia_glm)
summary(fitDia_Nglm)
summary(fitDia_Nglm2)
predictors <- c("Intercept", "Carat", "Cut.Fair", "Cut.Good", )
var(fitDia_Nglm2$residuals)

# # Plot Residuals for glm on limited data with ordered factor (polynomial) predictors
# resXY_glm <- data.frame(Price = data4model$price, Res = fitDia_glm$residuals)
# resLoess_glm <- loess(Res ~ Price, data = resXY_glm, )
# resPredict_glm <- predict(resLoess_glm)
# i <- order(as.vector(resXY_glm$Price))
# 
# plot(resXY_glm, col = as.numeric(data4model$color))
# legend("bottomleft", legend = LETTERS[4:10], pch = 19, col = 1:7)
# abline(h = 0, lwd = "2")
# lines(resXY_glm$Price[i], resPredict_glm[i], col='red', lwd = 2)

# Plot Residuals for glm on limited data with numeric predictors
resXY_Nglm <- data.frame(Price = Dia$price, Res = fitDia_Nglm$residuals)
resLoess_Nglm <- loess(Res ~ Price, data = resXY_Nglm, )
resPredict_Nglm <- predict(resLoess_Nglm)
i <- order(as.vector(resXY_Nglm$Price))

plot(resXY_Nglm, col = as.numeric(Dia$color, main = "GLM Model Using As.Numeric(Classifiers)"))
legend("bottomleft", legend = LETTERS[4:10], pch = 19, col = 1:7)
abline(h = 0, lwd = "2")
lines(resXY_Nglm$Price[i], resPredict_Nglm[i], col='red', lwd = 2)

# Plot Residuals for glm on limited data with numeric predictors  -- Clarity
plot(resXY_Nglm, col = as.numeric(Dia$clarity, main = "GLM Model Using As.Numeric(Classifiers)"))
legend("bottomleft", legend = LETTERS[4:10], pch = 19, col = 1:5)
abline(h = 0, lwd = "2")
lines(resXY_Nglm$Price[i], resPredict_Nglm[i], col='red', lwd = 2)

# Plot Residuals for glm on limited data with numeric predictors  -- Clarity
plot(resXY_Nglm, col = as.numeric(Dia$cut, main = "GLM Model Using As.Numeric(Classifiers)"))
legend("bottomleft", legend = LETTERS[4:10], pch = 19, col = 1:5)
abline(h = 0, lwd = "2")
lines(resXY_Nglm$Price[i], resPredict_Nglm[i], col='red', lwd = 2)


# # Plot Residuals for glm on all meaningfull data with numeric predictors
# resXY_N2glm <- data.frame(Price = data4model$price, Res = fitDia_Nglm2$residuals)
# resLoess_N2glm <- loess(Res ~ Price, data = resXY_N2glm, )
# resPredict_N2glm <- predict(resLoess_N2glm)
# i <- order(as.vector(resXY_N2glm$Price))
# 
# plot(data4model$price, fitDia_Nglm2$residuals, 
#      main='GLM Model Using as.Numeric(Classifiers) and Numeric Predictors',
#      col = as.numeric(data4model$color))
# legend("bottomleft", legend = LETTERS[4:10], pch = 19, col = 1:7)
# abline(h = 0, lwd = "2")
# lines(resXY_N2glm$Price[i], resPredict_Nglm[i], col='red', lwd = 2)
