## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ----fig.align = "center", out.width="75%", echo = FALSE-----------------
knitr::include_graphics("../inst/titanic.jpg")

## ------------------------------------------------------------------------
head(titanic)

## ---- message = FALSE, results = 'hide'----------------------------------
# Create fast-and-frugal trees from the titanic data

titanic.fft <- FFTrees(formula = survived ~.,
                       data = titanic)       

## ----fig.width = 6, fig.height = 6.5, fig.align = 'center', out.width = "80%"----
plot(titanic.fft,
     main = "Titanic cue accuracy",
     what = 'cues')

## ---- fig.width = 6, fig.height = 6.5, fig.align = 'center'--------------
plot(titanic.fft, 
     main = "Titanic", 
     decision.labels = c("Died", "Survived"))

## ---- fig.align = 'center', fig.height = 6.6, fig.width = 6, out.width = "70%"----
# Show the best training titanic fast-and-frugal tree without statistics
plot(titanic.fft,
     decision.labels = c("Died", "Survived"),
     stats = FALSE)

## ---- message = FALSE, results = 'hide'----------------------------------
set.seed(100) # For replicability of the training/test split
titanic.pred.fft <- FFTrees(formula = survived ~.,
                            data = titanic,
                            train.p = .5)

## ---- fig.width = 6, fig.height = 6.5, fig.align='center'----------------
plot(titanic.pred.fft,
     tree = "best.train", 
     main = "Titanic", 
     decision.labels = c("Died", "Survived"))

## ---- fig.width = 6, fig.height = 6.5, fig.align='center'----------------
plot(titanic.pred.fft,
     tree = "best.train",
     data = "test", 
     main = "Titanic", 
     decision.labels = c("Died", "Survived"))

## ---- fig.width = 6, fig.height = 6.5, fig.align='center'----------------
plot(titanic.pred.fft,
     tree = 4,
     data = "test", 
     main = "Titanic", 
     decision.labels = c("Died", "Survived"))

