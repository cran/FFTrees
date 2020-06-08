## ---- echo = FALSE-------------------------------------------------------
options(digits = 3)
knitr::opts_chunk$set(echo = TRUE, fig.width = 7.5, fig.height = 7.5, dpi = 100, out.width = "600px", fig.align='center', message = FALSE)

## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ----fig.align = "center", out.width="250px", echo = FALSE---------------
knitr::include_graphics("../inst/CoronaryArtery.jpg")

## ------------------------------------------------------------------------
# Training data
head(heartdisease)

# Test data
head(heartdisease)

## ---- message = FALSE----------------------------------------------------
# Create an FFTrees object called heart.fft predicting diagnosis
heart.fft <- FFTrees(formula = diagnosis ~.,
                    data = heart.train,
                    data.test = heart.test)

## ------------------------------------------------------------------------
# Print the names of the elements of an FFTrees object
names(heart.fft)

## ------------------------------------------------------------------------
# Print the object, with details about the tree with the best training wacc values
heart.fft

## ------------------------------------------------------------------------
# Show decision thresholds and marginal classification training accuracies for each cue
heart.fft$cues$stats$train

## ----fig.width = 6.5, fig.height = 6.5, dpi = 400, out.width = "600px", fig.align='center'----
# Visualize individual cue accuracies
plot(heart.fft, 
     main = "Heartdisease Cue Accuracy",
     what = "cues")

## ------------------------------------------------------------------------
# Print the definitions of all trees
heart.fft$trees$definitions

## ------------------------------------------------------------------------
# Describe the best training tree

inwords(heart.fft, tree = 1)

## ------------------------------------------------------------------------
# Print training statistics for all trees
heart.fft$trees$stats$train

## ------------------------------------------------------------------------
# Look at the tree decisisions
heart.fft$trees$decisions$train$tree_1

## ------------------------------------------------------------------------
# Predict classes for new data from the best training tree
predict(heart.fft,
        newdata = heartdisease[1:10,])

## ------------------------------------------------------------------------
# Predict class probabilities for new data from the best training tree
predict(heart.fft,
        newdata = heartdisease,
        type = "prob")

## ------------------------------------------------------------------------
# Predict classes and probabilities
predict(heart.fft,
        newdata = heartdisease,
        type = "both")

## ---- fig.width = 7, fig.height = 7--------------------------------------
plot(heart.fft,
     main = "Heart Disease",
     decision.labels = c("Healthy", "Disease"))

## ------------------------------------------------------------------------
# Define a tree manually using the my.tree argument
myheart.fft <- FFTrees(diagnosis ~., 
                       data = heartdisease, 
                       my.tree = "If chol > 300, predict True. If thal = {fd,rd}, predict False. Otherwise, predict True")

# Here is the result
plot(myheart.fft, 
     main = "Specifying an FFT manually")

