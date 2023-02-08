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

## ----pkgs, echo = FALSE, message = FALSE, results = 'hide'--------------------
library(FFTrees)

## ----install-pkg, eval = FALSE------------------------------------------------
#  # Install the package from CRAN:
#  install.packages("FFTrees")

## ----load-pkg-2, eval = TRUE, message = TRUE----------------------------------
# Load the package:
library(FFTrees)

## ----load-guide, eval = FALSE-------------------------------------------------
#  # Open the main package guide:
#  FFTrees.guide()

## ----fft-create, message = FALSE----------------------------------------------
# Create an FFTrees object:
heart.fft <- FFTrees(formula = diagnosis ~ .,           # Criterion and (all) predictors
                     data = heart.train,                # Training data
                     data.test = heart.test,            # Testing data
                     main = "Heart Disease",            # General label
                     decision.labels = c("Low-Risk", "High-Risk")  # Decision labels (False/True)
                     )

## ----fft-print----------------------------------------------------------------
# Print an FFTrees object:
heart.fft

## ----fft-confusion-table, out.width="50%", echo = FALSE, fig.cap = "**Table 1**: A 2x2 confusion table illustrating the types of frequency counts for 4 possible outcomes."----
knitr::include_graphics("../inst/confusiontable.jpg")

## ----fft-plot, fig.width = 6.5, fig.height = 6--------------------------------
# Plot predictions of the best FFT when applied to test data:
plot(heart.fft,      # An FFTrees object
     data = "test")  # data to use (i.e., either "train" or "test")?

## ----fft-no-stats, fig.width = 8, fig.height = 4, out.width = "500px"---------
# Plot only the tree, without accuracy statistics:
plot(heart.fft, what = "tree")
# plot(heart.fft, stats = FALSE)  #  The 'stats' argument has been deprecated.

## ----fft-cues, fig.width = 6, fig.height = 6, out.width = "500px"-------------
# Plot cue accuracies (for training data) in ROC space:
plot(heart.fft, what = "cues")

## ----fft-names----------------------------------------------------------------
# Show the names of all of the outputs in heart.fft:
names(heart.fft)

## ----fft-predict, eval = FALSE------------------------------------------------
#  # Predict classifications for a new dataset:
#  predict(heart.fft,
#          newdata = heartdisease)

## ----fft-my-tree, results = 'hide'--------------------------------------------
# Create an FFT manually (from description):
my.heart.fft <- FFTrees(formula = diagnosis ~.,
                        data = heart.train,
                        data.test = heart.test,
                        main = "My Heart FFT",
                        my.tree = "If chol > 350, predict True. 
                                   If cp != {a}, predict False. 
                                   If age <= 35, predict False, otherwise, predict True.")

## ----plot-my-fft, fig.width = 6.5, fig.height = 6-----------------------------
plot(my.heart.fft, data = "train")

