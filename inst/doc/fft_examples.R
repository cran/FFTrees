## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
set.seed(100)
train.cases <- sample(c(T, F), size = nrow(mushrooms), replace = T)
mushrooms.train <- mushrooms[train.cases,]
mushrooms.test <- mushrooms[train.cases == F,]

## ------------------------------------------------------------------------
mushrooms.fft <- fft(formula = poisonous ~.,
                     data = mushrooms.train,
                     data.test = mushrooms.test)

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(mushrooms.fft, data = "test")

## ------------------------------------------------------------------------
head(iris)

## ------------------------------------------------------------------------
iris.fft <- fft(
  formula = virginica ~.,
  data = iris
  )

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(iris.fft)

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(iris.fft, which.tree = 2)

