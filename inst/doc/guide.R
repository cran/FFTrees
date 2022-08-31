## ----setup, echo = FALSE, message = FALSE, results = 'hide'-------------------
library(FFTrees)

# URLs:
url_pkg_CRAN   <- "https://CRAN.R-project.org/package=FFTrees"
url_pkg_GitHub <- "https://github.com/ndphillips/FFTrees"
url_pkg_issues <- "https://github.com/ndphillips/FFTrees/issues"

url_JDM_issue <- "https://journal.sjdm.org/vol12.4.html"
url_JDM_html  <- "https://journal.sjdm.org/17/17217/jdm17217.html"
url_JDM_pdf   <- "https://journal.sjdm.org/17/17217/jdm17217.pdf"

email_contact <- "Nathaniel.D.Phillips.is@gmail.com"
url_contact   <- "https://www.linkedin.com/in/nathanieldphillips/"

## ----fft-example, message = FALSE---------------------------------------------
# Create a fast-and-frugal tree (FFT) predicting heart disease:
heart.fft <- FFTrees(formula = diagnosis ~.,
                     data = heart.train,
                     data.test = heart.test,
                     main = "Heart Disease",
                     decision.labels = c("Healthy", "Diseased"))

## ----fig-1, fig.width = 7, fig.height = 6.5, fig.align = 'center', fig.cap = "A fast-and-frugal tree (FFT) to predict heart disease status."----
# Visualize predictive performance:
plot(heart.fft, data = "test")

## ----bibtex-citation, eval = FALSE, highlight = FALSE-------------------------
#  @article{FFTrees,
#   title = {FFTrees: A toolbox to create, visualize, and evaluate fast-and-frugal decision trees},
#   author = {Phillips, Nathaniel D and Neth, Hansjörg and Woike, Jan K and Gaissmaier, Wolfgang},
#   year = 2017,
#   journal = {Judgment and Decision Making},
#   volume = 12,
#   number = 4,
#   pages = {344--368},
#   url = {https://journal.sjdm.org/17/17217/jdm17217.pdf}
#  }

## ----logo, echo = FALSE, fig.align = "center", out.width="40%"----------------
knitr::include_graphics("../inst/FFTrees_Logo.jpg")

