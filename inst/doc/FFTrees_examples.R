## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
set.seed(100) # For replicability of the training / test data split

mushrooms.fft <- FFTrees(formula = poisonous ~.,
                     data = mushrooms,
                     train.p = .5)

## ------------------------------------------------------------------------
mushrooms.fft

## ----fig.width = 6, fig.height = 6, fig.align = 'center'-----------------
showcues(mushrooms.fft, main = "Mushrooms")

## ---- fig.width = 6, fig.height = 6, fig.align = 'center'----------------
plot(mushrooms.fft, 
     data = "test", 
     description = "Mushrooms FFT",
     decision.names = c("Safe", "Poisonous")
     )

## ------------------------------------------------------------------------
set.seed(100) # for replicability
mushrooms.ring.fft <- FFTrees(formula = poisonous ~ ringtype + ringnum,
                          data = mushrooms,
                          train.p = .5
                          )

## ---- fig.width = 6, fig.height = 6, fig.align = 'center'----------------
plot(mushrooms.ring.fft, 
     data = "test", 
     description = "Mushrooms (Ring only) FFT",
     decision.names = c("Safe", "Poisonous")
     )

## ------------------------------------------------------------------------
iris.fft <- FFTrees(
  formula = virginica ~.,
  data = iris,
  train.p = .5
  )

## ----fig.width = 6, fig.height = 6, fig.align = 'center'-----------------
showcues(iris.fft)

## ---- fig.width = 6, fig.height = 6, fig.align = 'center'----------------
plot(iris.fft, 
     data = "test", 
     description = "Iris FFT",
     decision.names = c("Not V", "Virginica")
     )

## ---- fig.width = 6, fig.height = 6, fig.align = 'center'----------------
plot(iris.fft, 
     data = "test", 
     description = "Iris FFT",
     decision.names = c("Not V", "Virginica"),
     tree = 6     # Show tree #6
     )

