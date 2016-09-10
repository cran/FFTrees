## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
head(heartdisease)

## ------------------------------------------------------------------------
set.seed(100) # For replication
samples <- sample(c(T, F), size = nrow(heartdisease), replace = T)
heartdisease.train <- heartdisease[samples,]
heartdisease.test <- heartdisease[samples == 0,]

## ------------------------------------------------------------------------
heart.fft <- FFTrees(formula = diagnosis ~.,
                    data = heartdisease.train,
                    data.test = heartdisease.test
                    )

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
heart.fft$tree.definitions

## ------------------------------------------------------------------------
heart.fft$tree.stats$train

## ------------------------------------------------------------------------
heart.fft$decision$train[1:5,]

## ------------------------------------------------------------------------
heart.fft$levelout$test[1:5,]

## ------------------------------------------------------------------------
heart.fft <- predict(heart.fft,
                     data.test = heartdisease[1:50,]
                     )

## ------------------------------------------------------------------------
heart.fft

## ---- fig.width = 6, fig.height = 6--------------------------------------
plot(heart.fft,
     main = "Heart Disease",
     decision.names = c("Healthy", "Disease")
     )

## ----fig.width = 5, fig.height = 5---------------------------------------
showcues(heart.fft)

