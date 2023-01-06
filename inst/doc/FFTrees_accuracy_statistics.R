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
                      fig.width = 7, 
                      fig.height = 7, 
                      out.width = "600px")

## ----pkgs, echo = FALSE, message = FALSE, results = 'hide'--------------------
library(FFTrees)

## ----fft-example, results = "hide"--------------------------------------------
# Create an FFTrees object predicting heart disease: 
heart.fft <- FFTrees(formula = diagnosis ~.,
                     data = heartdisease)

## ----fft-plot-1, fig.cap = "**Figure 1**: Example FFT for the `heartdisease` data."----
plot(heart.fft, tree = "best.train")

## ----confusion-table, fig.align = "center", out.width="50%", echo = FALSE, fig.cap = "**Figure 2**: A 2x2 matrix illustrating the frequency counts of 4 possible outcomes."----
knitr::include_graphics("../inst/confusiontable.jpg")

## ----fft-heart----------------------------------------------------------------
heart.fft

## ----fft-levelout-------------------------------------------------------------
# A vector of levels/nodes at which each case was classified:
heart.fft$trees$decisions$train$tree_1$levelout

## ----fft-mcu------------------------------------------------------------------
# Calculate the mean number or cues used (mcu): 
mean(heart.fft$trees$decisions$train$tree_1$levelout)

## ----fft-pci------------------------------------------------------------------
# Calculate pci (percentage of cues ignored) as 
# (n.cues - mcu) / n.cues):
n.cues <- ncol(heartdisease) 
(n.cues - heart.fft$trees$stats$train$mcu[1]) / n.cues

