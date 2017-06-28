## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)
library(knitr)

## ----fig1, fig.width = 7, fig.height = 6.5, echo = TRUE, fig.align='center', echo = TRUE, message = FALSE, fig.cap="A fast-and-frugal tree (FFT) to predict heart disease risk. Read the Heart Disease Tutorial vignette to learn more about how to create this FFT."----
# Create a fast-and-frugal tree (FFT) predicting heart disease
heart.fft <- FFTrees(formula = diagnosis ~.,
                     data = heart.train,
                     data.test = heart.test,
                     main = "Heart Disease",
                     decision.labels = c("Low-Risk", "High-Risk"))

# Visualize the best training tree applied to the test data
plot(heart.fft, data = "test")

## ------------------------------------------------------------------------
# Cite the package
citation("FFTrees")

## ---- eval = FALSE-------------------------------------------------------
#  # Cite the article
#  @article{phillips2017FFTrees,
#    title={FFTrees: A toolbox to create, visualize, and evaluate fast-and-frugal decision trees},
#    author={Phillips, Nathaniel D. and Neth, Hansjoerg and Woike, Jan and Wolfgang, Gaissmaier},
#    journal={Judgment and Decision Making},
#    year={2017}
#  }

## ----fig.align = "center", out.width="50%", echo = FALSE-----------------
knitr::include_graphics("../inst/FFTrees_Logo.jpg")

