## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(collapse = FALSE, 
                      comment = "#>", 
                      prompt = FALSE,
                      tidy = FALSE,
                      echo = TRUE, 
                      message = FALSE,
                      warning = FALSE,
                      # Default figure options:
                      dpi = 100,
                      fig.align = 'center',
                      fig.height = 6.0,
                      fig.width  = 6.5, 
                      out.width = "600px")

## ----load-pkg, echo = FALSE, message = FALSE, results = 'hide'----------------
library(FFTrees)

## ----image, fig.align = "center", out.width="250px", echo = FALSE-------------
knitr::include_graphics("../inst/CoronaryArtery.jpg")

## ----heart-data---------------------------------------------------------------
# Training data: 
head(heart.train)

# Testing data:
head(heart.test)

## ----heart-fft, message = FALSE-----------------------------------------------
# Create an FFTrees object called heart.fft predicting diagnosis: 
heart.fft <- FFTrees(formula = diagnosis ~.,
                     data = heart.train,
                     data.test = heart.test)

## ----print-names--------------------------------------------------------------
# See the elements of an FFTrees object:
names(heart.fft)

## ----print-fftrees-object-data-train------------------------------------------
# Training performance of the best tree (on "train" data, given current goal):
heart.fft  # same as: print(heart.fft, data = "train")

## ----print-fftrees-object-data-test, eval = FALSE-----------------------------
#  # Prediction performance of the best training tree (on "test" data):
#  print(heart.fft, data = "test")

## ----print-fftrees-object-else, eval = FALSE----------------------------------
#  # Performance of alternative FFTs (Tree 3) in an FFTrees object:
#  print(heart.fft, tree = 3, data = "test")

## ----fft-cues-stats-train-----------------------------------------------------
# Decision thresholds and marginal classification training accuracies for each cue: 
heart.fft$cues$stats$train

## ----fft-plot-cues, fig.width = 6, fig.height = 6, out.width = "500px", fig.align = 'center'----
# Visualize individual cue accuracies: 
plot(heart.fft, what = "cues", 
     main = "Cue accuracy for heartdisease")

## ----fft-definitions----------------------------------------------------------
# See the definitions of all trees:
heart.fft$trees$definitions

## ----fft-inwords--------------------------------------------------------------
# Describe the best training tree (i.e., Tree #1):
inwords(heart.fft, tree = 1)

## ----fft-stats-train----------------------------------------------------------
# Training statistics for all trees:
heart.fft$trees$stats$train

## ----fft-stats-test-----------------------------------------------------------
# Testing statistics for all trees:
heart.fft$trees$stats$test

## ----fft-decisions------------------------------------------------------------
# Inspect the decisions of Tree 1:
heart.fft$trees$decisions$train$tree_1

## ----fft-predict-class--------------------------------------------------------
# Predict classes for new data from the best training tree: 
predict(heart.fft,
        newdata = heartdisease[1:10, ])

## ----fft-predict-prob---------------------------------------------------------
# Predict class probabilities for new data from the best training tree:
predict(heart.fft,
        newdata = heartdisease,
        type = "prob")

## ----fft-predict-both---------------------------------------------------------
# Predict both classes and probabilities:
predict(heart.fft,
        newdata = heartdisease,
        type = "both")

## ----fft-plot, fig.width = 7, fig.height = 7----------------------------------
plot(heart.fft,
     main = "Heart Disease",
     decision.labels = c("Healthy", "Disease"))

## ----fft-my-tree-def----------------------------------------------------------
# Manually define a tree using the my.tree argument:
myheart.fft <- FFTrees(diagnosis ~., 
                       data = heartdisease, 
                       my.tree = "If chol > 300, predict True. 
                                  If thal = {fd,rd}, predict False. 
                                  Otherwise, predict True")

## ----fft-my-tree-plot---------------------------------------------------------
plot(myheart.fft, 
     main = "Specifying an FFT manually")

