## ---- echo = FALSE-------------------------------------------------------
options(digits = 3)
knitr::opts_chunk$set(echo = TRUE, 
                      fig.width = 7.5, 
                      fig.height = 7.5, 
                      dpi = 100, 
                      out.width = "600px", 
                      fig.align='center', 
                      message = FALSE)

## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
head(heartdisease[c("sex", "age", "thal")])

## ---- eval = FALSE-------------------------------------------------------
#  my.tree = "If sex = 1, predict True.
#             If age < 45, predict False.
#             If thal = {fd, normal}, predict True. Otherwise, predict False"

## ------------------------------------------------------------------------
# Pass a verbally defined FFT to FFTrees with the my.tree argument
my.heart.fft <- FFTrees(diagnosis ~.,
                        data = heartdisease,
                        my.tree = "If sex = 1, predict True.
                                   If age < 45, predict False. 
                                   If thal = {fd, normal}, predict True. 
                                   Otherwise, predict False")

## ------------------------------------------------------------------------
# Plot 
plot(my.heart.fft)

## ------------------------------------------------------------------------
# Specify an FFt verbally with the my.tree argument
my.heart.fft <- FFTrees(diagnosis ~.,
                        data = heartdisease,
                        my.tree = "If thal = {rd,fd}, predict True.
                                   If cp != {a}, predict False. 
                                   If ca > 1, predict True. 
                                   Otherwise, predict False")

# Plot 
plot(my.heart.fft)

