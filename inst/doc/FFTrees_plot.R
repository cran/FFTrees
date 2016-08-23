## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
titanic.fft <- FFTrees(
  formula = survived ~.,
  data = titanic
  )

## ----fig.width = 6, fig.height = 6, fig.align = 'center'-----------------
showcues(titanic.fft,
         main = "Titanic cue accuracy")

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.fft, 
     main = "Titanic", 
     decision.names = c("Died", "Survived"))

## ------------------------------------------------------------------------
set.seed(100)
titanic.pred.fft <- FFTrees(formula = survived ~.,
                        data = titanic,
                        train.p = .5)

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.pred.fft,
     tree = "best.train", 
     main = "Titanic", 
     decision.names = c("Died", "Survived"))

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.pred.fft,
     tree = "best.train",
     data = "test", 
     main = "Titanic", 
     decision.names = c("Died", "Survived"))

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.pred.fft,
     tree = 4,
     data = "test", 
     main = "Titanic", 
     decision.names = c("Died", "Survived"))

