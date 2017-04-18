## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ------------------------------------------------------------------------
head(heartdisease)

## ------------------------------------------------------------------------
set.seed(100) # For replication
heart.rand <- heartdisease[sample(nrow(heartdisease)),]
heart.train <- heart.rand[1:150,]
heart.test <- heart.rand[151:303,]

## ------------------------------------------------------------------------
heart.fft <- FFTrees(formula = diagnosis ~.,
                    data = heart.train,
                    data.test = heart.test)

## ------------------------------------------------------------------------
names(heart.fft)

## ------------------------------------------------------------------------
heart.fft

## ------------------------------------------------------------------------
heart.fft$cue.accuracies

## ----fig.width = 8, fig.height = 8---------------------------------------
plot(heart.fft, 
     main = "Heartdisease Cue Accuracy",
     what = "cues")

## ------------------------------------------------------------------------
heart.fft$tree.definitions

## ------------------------------------------------------------------------
heart.fft$tree.stats$train

## ------------------------------------------------------------------------
heart.fft$decision$train[1:5,]

## ------------------------------------------------------------------------
heart.fft$levelout$test[1:5,]

## ------------------------------------------------------------------------
predict(heart.fft,
        data = heartdisease[1:50,])

## ---- fig.width = 7, fig.height = 7--------------------------------------
plot(heart.fft,
     main = "Heart Disease",
     decision.names = c("Healthy", "Disease"))

