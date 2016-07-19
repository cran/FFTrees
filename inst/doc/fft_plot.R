## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
titanic.fft <- fft(
  formula = survived ~.,
  data = titanic
  )

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.fft)

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.fft, 
     which.tree = 4)

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(titanic.fft,
     which.tree = 2,
     data = subset(titanic, age == "child")
     )

