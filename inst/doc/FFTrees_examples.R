## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
set.seed(100) # For replicability of the training / test data split
train.samples <- sample(nrow(mushrooms), size = 4000)
mushrooms.train <- mushrooms[train.samples, ]
mushrooms.test <- mushrooms[setdiff(1:nrow(mushrooms), train.samples), ]

mushrooms.fft <- FFTrees(formula = poisonous ~.,
                         data = mushrooms.train,
                         data.test = mushrooms.test
                         )

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
mushrooms.ring.fft <- FFTrees(formula = poisonous ~ ringtype + ringnum,
                              data = mushrooms.train,
                              data.test = mushrooms.test
                              )

## ---- fig.width = 6, fig.height = 6, fig.align = 'center'----------------
plot(mushrooms.ring.fft, 
     data = "test", 
     description = "Mushrooms (Ring only) FFT",
     decision.names = c("Safe", "Poisonous")
     )

## ------------------------------------------------------------------------
iris.fft <- FFTrees(formula = virginica ~.,
                    data = iris
                    )

## ----fig.width = 6, fig.height = 6, fig.align = 'center'-----------------
showcues(iris.fft)

## ---- fig.width = 6, fig.height = 6, fig.align = 'center'----------------
plot(iris.fft, 
     description = "Iris FFT",
     decision.names = c("Not V", "Virginica")
     )

## ---- fig.width = 6, fig.height = 6, fig.align = 'center'----------------
plot(iris.fft, 
     description = "Iris FFT",
     decision.names = c("Not V", "Virginica"),
     tree = 2     # Show tree #6
     )

