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
heart.fft <- FFTrees(
  formula = diagnosis ~.,
  data = heartdisease.train,
  data.test = heartdisease.test
  )

## ------------------------------------------------------------------------
class(heart.fft)

## ------------------------------------------------------------------------
names(heart.fft)

## ------------------------------------------------------------------------
heart.fft

## ------------------------------------------------------------------------
heart.fft$cue.accuracies

## ----fig.width = 8, fig.height = 8---------------------------------------
showcues(heart.fft, 
         main = "Heartdisease Cue Accuracy")

## ------------------------------------------------------------------------
heart.fft$fft.stats

## ---- eval = F-----------------------------------------------------------
#  summary(heart.fft)  # Same thing as heart.fft$fft.stats

## ------------------------------------------------------------------------
heart.fft$auc

## ------------------------------------------------------------------------
heart.fft$decision.train[1:5,]

## ------------------------------------------------------------------------
heart.fft$levelout.train[1:5,]

## ------------------------------------------------------------------------
heart.as.fft <- FFTrees(formula = diagnosis ~ age + sex,
                    data = heartdisease
                    )

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(heart.fft,
     main = "Heart Disease",
     decision.names = c("Healthy", "Disease")
     )

