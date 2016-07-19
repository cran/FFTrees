## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
head(heartdisease)

## ------------------------------------------------------------------------
set.seed(100)
samples <- sample(c(T, F), size = nrow(heartdisease), replace = T)
heartdisease.train <- heartdisease[samples,]
heartdisease.test <- heartdisease[samples == 0,]

## ------------------------------------------------------------------------
heart.fft <- fft(
  formula = diagnosis ~.,
  data = heartdisease.train,
  data.test = heartdisease.test
  )

## ------------------------------------------------------------------------
class(heart.fft)

## ------------------------------------------------------------------------
names(heart.fft)

## ------------------------------------------------------------------------
heart.fft$cue.accuracies

## ------------------------------------------------------------------------
heart.fft$trees

## ---- eval = F-----------------------------------------------------------
#  summary(heart.fft)

## ------------------------------------------------------------------------
heart.fft$trees[,7:15]   # Training stats are in columns 7:15

## ------------------------------------------------------------------------
heart.fft$trees[,16:24]   # Test stats are in columns 16:24

## ------------------------------------------------------------------------
heart.fft$trees.auc

## ------------------------------------------------------------------------
heart.fft$decision.train[1:5,]

## ------------------------------------------------------------------------
heart.fft$levelout.train[1:5,]

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(heart.fft,
     description = "Heart Disease",
     decision.names = c("Healthy", "Disease")
     )

