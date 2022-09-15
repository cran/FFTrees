## ----setup, echo = FALSE, message = FALSE, results = 'hide'-------------------
library(FFTrees)
knitr::opts_chunk$set(echo = TRUE, fig.width = 6, fig.height = 6, dpi = 100, out.width = "600px", fig.align = 'center', message = FALSE)

## ----image-mushrooms, fig.align = "center", out.width="225px", echo = FALSE----
knitr::include_graphics("../inst/mushrooms.jpg")

## ----data-mushrooms, echo = FALSE---------------------------------------------
# Select subset:
mushrooms_sub <- mushrooms[1:6, c(1:6, 18:23)]

knitr::kable(head(mushrooms_sub))

## ----fft-mushrooms-1, message = FALSE, results = 'hide', warning=FALSE--------
# Create FFTs from the mushrooms data: 
set.seed(1) # for replicability of the training / test data split

mushrooms.fft <- FFTrees(formula = poisonous ~.,
                         data = mushrooms,
                         train.p = .50,   # split data into 50:50 training/test subsets
                         main = "Mushrooms",
                         decision.labels = c("Safe", "Poison"))   

## ----fft-mushrooms-1-print----------------------------------------------------
# Print information about the best tree during training:
mushrooms.fft

## ----fft-mushrooms-1-plot-cues------------------------------------------------
# Plot the cue accuracies of an FFTrees object:
plot(mushrooms.fft, what = "cues")

## ----fft-mushrooms-1-plot-----------------------------------------------------
# Plot the best FFT for the mushrooms test data: 
plot(mushrooms.fft, data = "test")

## ----fft-mushrooms-2-seed, include = FALSE------------------------------------
set.seed(200)

## ----fft-mushrooms-2, message = FALSE, results = 'hide', warning = FALSE------
# Create trees using only the ringtype and ringnum cues: 
mushrooms.ring.fft <- FFTrees(formula = poisonous ~ ringtype + ringnum,
                              data = mushrooms,
                              train.p = .50,
                              main = "Mushrooms (ring only)",
                              decision.labels = c("Safe", "Poison"))

## ----fft-mushrooms-2-plot-----------------------------------------------------
# Plotting the best training FFT for test data: 
plot(mushrooms.ring.fft, data = "test")

## ----iris-image, fig.align = "center", out.width = "225px", echo = FALSE------
knitr::include_graphics("../inst/virginica.jpg")

## ----iris-fft, message = FALSE, results = 'hide'------------------------------
# Create FFTrees object for iris data:
iris.fft <- FFTrees(formula = virginica ~.,
                    data = iris.v,
                    main = "Iris",
                    decision.labels = c("Not-V", "V"))

## ----iris-fft-print, eval = FALSE, results = 'hide'---------------------------
#  iris.fft

## ----iris-plot-cues-----------------------------------------------------------
# Plot cue values: 
plot(iris.fft, what = "cues")

## ----iris-plot-fft------------------------------------------------------------
# Plot best FFT (in training): 
plot(iris.fft)

## ----iris-plot-fft-2----------------------------------------------------------
# Plot FFT #2 in iris FFTrees: 
plot(iris.fft, tree = 2)

