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

## ----load-pkg-0, echo = FALSE, message = FALSE, results = 'hide'--------------
library(FFTrees)

## ----image-mushrooms, fig.align = "center", out.width = "225px", echo = FALSE----
knitr::include_graphics("../inst/mushrooms.jpg")

## ----data-mushrooms, echo = FALSE---------------------------------------------
# names(mushrooms)

# Select subset:
mushrooms_sub <- mushrooms[1:6, c(1:6, 18:23)]

knitr::kable(head(mushrooms_sub))

## ----fft-mushrooms-1, message = FALSE, results = 'hide', warning = FALSE------
# Create FFTs from the mushrooms data: 
set.seed(1) # for replicability of the training / test data split

mushrooms_fft <- FFTrees(formula = poisonous ~.,
                         data = mushrooms,
                         train.p = .50,   # split data into 50:50 training/test subsets
                         main = "Mushrooms",
                         decision.labels = c("Safe", "Poison"),
                         do.comp = FALSE)

## ----fft-mushrooms-1-print----------------------------------------------------
# Print information about the best tree (during training):
print(mushrooms_fft)

## ----fft-mushrooms-1-plot-cues, fig.width = 6.0, fig.height = 6.0, out.width = "450px"----
# Plot the cue accuracies of an FFTrees object:
plot(mushrooms_fft, what = "cues")

## ----fft-mushrooms-1-plot-----------------------------------------------------
# Plot the best FFT (for test data): 
plot(mushrooms_fft, data = "test")

## ----fft-mushrooms-2-seed, include = FALSE------------------------------------
set.seed(200)

## ----fft-mushrooms-2, message = FALSE, results = 'hide', warning = FALSE------
# Create trees using only the ringtype and ringnum cues: 
mushrooms_ring_fft <- FFTrees(formula = poisonous ~ ringtype + ringnum,
                              data = mushrooms,
                              train.p = .50,
                              main = "Mushrooms (ring cues)",
                              decision.labels = c("Safe", "Poison"),
                              do.comp = FALSE)

## ----fft-mushrooms-2-plot-----------------------------------------------------
# Plotting the best training FFT (for test data): 
plot(mushrooms_ring_fft, data = "test")

## ----iris-image, fig.align = "center", out.width = "225px", echo = FALSE------
knitr::include_graphics("../inst/virginica.jpg")

## ----iris-fft, message = FALSE, results = 'hide'------------------------------
# Create FFTrees object for iris data:
iris_fft <- FFTrees(formula = virginica ~.,
                    data = iris.v,
                    main = "Iris",
                    decision.labels = c("Not-V", "V"))

## ----iris-fft-print, echo = TRUE, eval = FALSE, results = 'hide'--------------
#  # Inspect resulting FFTs:
#  print(iris_fft)    # summarize best training tree
#  plot(iris_fft)     # visualize best training tree
#  summary(iris_fft)  # summarize FFTrees object

## ----iris-plot-cues, fig.width = 6.0, fig.height = 6.0, out.width = "450px"----
# Plot cue values: 
plot(iris_fft, what = "cues")

## ----iris-plot-fft------------------------------------------------------------
# Plot best FFT: 
plot(iris_fft)

## ----iris-plot-fft-2----------------------------------------------------------
# Plot FFT #2: 
plot(iris_fft, tree = 2)

