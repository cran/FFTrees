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
                      out.width = "580px")

## ----pkgs, echo = FALSE, message = FALSE, results = 'hide'--------------------
library(FFTrees)
library(dplyr)
library(testthat)
library(tidyselect)
library(magrittr)
library(knitr)

## ----urls, echo = FALSE, message = FALSE, results = 'hide'--------------------
# URLs:
url_pkg_CRAN   <- "https://CRAN.R-project.org/package=FFTrees"
url_pkg_GitHub <- "https://github.com/ndphillips/FFTrees"
url_pkg_issues <- "https://github.com/ndphillips/FFTrees/issues"

url_JDM_issue <- "https://journal.sjdm.org/vol12.4.html"
url_JDM_html  <- "https://journal.sjdm.org/17/17217/jdm17217.html"
url_JDM_pdf   <- "https://journal.sjdm.org/17/17217/jdm17217.pdf"

url_JDM_doi <- "https://doi.org/10.1017/S1930297500006239"

email_contact <- "Nathaniel.D.Phillips.is@gmail.com"
url_contact   <- "https://www.linkedin.com/in/nathanieldphillips/"

## ----fft-example, message = FALSE, results = 'hide'---------------------------
# Create a fast-and-frugal tree (FFT) predicting heart disease:
heart.fft <- FFTrees(formula = diagnosis ~.,
                     data = heart.train,
                     data.test = heart.test,
                     main = "Heart Disease",
                     decision.labels = c("Healthy", "Diseased"))

## ----fig-1, fig.width = 6.5, fig.height = 6.0, out.width = "600px", fig.align = 'center', fig.cap = "A fast-and-frugal tree (FFT) to predict heart disease status."----
# Visualize predictive performance:
plot(heart.fft, data = "test")

## ----dataframe for overview data, echo = FALSE--------------------------------
## Preparations for applying the describe_data() function to all data sets
## When new data sets are included, add their info so that they will also be shown in the vignette-table!

# List all data sets: 
data_list <- list(blood, breastcancer, car, contraceptive, creditapproval, fertility, forestfires, 
                  heartdisease, iris.v, mushrooms, sonar, titanic, voting, wine) 

# Vector with all names of the data sets:
data_names <- c("blood", "breastcancer", "car", "contraceptive", "creditapproval", "fertility", "forestfires", 
                "heartdisease", "iris.v", "mushrooms", "sonar", "titanic", "voting", "wine")

# Vector with all criterion names:
criterion_names <- c("donation.crit", "diagnosis", "acceptability", "cont.crit", "crit", 
                     "diagnosis","fire.crit", "diagnosis", "virginica", "poisonous", "mine.crit", "survived", "party.crit", "type") 

# Vector with criterion values of interest: 
baseline_values <- c(1, TRUE, "acc", TRUE, TRUE, TRUE, TRUE, 
                     TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, "red")

# Use combined lists/vectors and apply describe_data() to each:
result_list <- mapply(describe_data, data = data_list, 
                      data_name = data_names, criterion_name = criterion_names, 
                      baseline_value = baseline_values, SIMPLIFY = FALSE)

# Combine results in df:
combined_result <- do.call(rbind, result_list)

# Round baseline and NA pct values for brevity:
combined_result$Baseline_pct<- round(combined_result$Baseline_pct, 1)
combined_result$NAs_pct<- round(combined_result$NAs_pct, 2)

# Rename columns:
colnames(combined_result) <- c("Dataset name", 
                               "Number of cases",
                               "Criterion name", 
                               "Baseline (`TRUE`,\\ in\\ %)",
                               "Number of predictors",
                               "Number of NAs", 
                               "NAs (in\\ %)")

# Render the table from the data frame
# use as many items per page as we have data sets
# redefine column names as we like them:

knitr::kable(combined_result, format = "html") 

## ----bibtex-citation, eval = FALSE, highlight = FALSE-------------------------
#  @article{FFTrees,
#   title = {FFTrees: A toolbox to create, visualize, and evaluate fast-and-frugal decision trees},
#   author = {Phillips, Nathaniel D and Neth, Hansjörg and Woike, Jan K and Gaissmaier, Wolfgang},
#   year = 2017,
#   journal = {Judgment and Decision Making},
#   volume = 12,
#   number = 4,
#   pages = {344--368},
#   url = {https://journal.sjdm.org/17/17217/jdm17217.pdf},
#   doi = {10.1017/S1930297500006239}
#  }

## ----logo, echo = FALSE, fig.align = "center", out.width="40%"----------------
knitr::include_graphics("../inst/FFTrees_Logo.jpg")

