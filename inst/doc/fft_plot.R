## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
titanic.fft <- fft(
  formula = survived ~.,
  data = titanic
  )

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.fft, 
     description = "Titanic", 
     decision.names = c("Died", "Survived"))

## ------------------------------------------------------------------------
set.seed(100)
train.cases <- sample(c(T, F), size = nrow(titanic), replace = T, prob = c(.05, .95))
titanic.train <- titanic[train.cases,]
titanic.test <- titanic[train.cases == F,]

titanic.pred.fft <- fft(formula = survived ~.,
                        data = titanic.train,
                        data.test = titanic.test)

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.pred.fft,
     which.tree = "best.train", 
     description = "Titanic", 
     decision.names = c("Died", "Survived"))

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.pred.fft,
     which.tree = "best.train",
     data = "test", 
     description = "Titanic", 
     decision.names = c("Died", "Survived"))

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.pred.fft,
     which.tree = 4,
     data = "test", 
     description = "Titanic", 
     decision.names = c("Died", "Survived"))

