## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)
library(knitr)

## ----fig.align = "center", out.width="250px", echo = FALSE---------------
knitr::include_graphics("../inst/FFTrees_Logo.jpg")

## ---- fig.width = 7, fig.height = 7, echo = T, fig.align='center', echo = TRUE----
# Create an FFT from the heartdisease dataset
heart.fft <- FFTrees(formula = diagnosis ~.,
                     data = heartdisease)

# Plot the best training tree
plot(heart.fft,
     main = "Heart Disease",
     decision.names = c("Absent", "Present"))

