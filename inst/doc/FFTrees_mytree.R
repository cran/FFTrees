## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      fig.width = 6.5, 
                      fig.height = 6.5, 
                      dpi = 100, 
                      out.width = "600px", 
                      fig.align='center', 
                      message = FALSE)

## ----load-pkg-0, echo = FALSE, message = FALSE, results = 'hide'--------------
library(FFTrees)

## ----heart-data, echo = FALSE-------------------------------------------------
knitr::kable(head(heartdisease[c("sex", "age", "thal", "cp", "ca", 
                                 "diagnosis")]))

## ----fft-description----------------------------------------------------------
in_words <- "If sex = 1, predict True.
             If age < 45, predict False. 
             If thal = {fd, normal}, predict True. 
             Otherwise, predict False."

## ----create-my-tree, message = FALSE------------------------------------------
# Create FFTrees from a verbal FFT description (as my.tree): 
my_fft <- FFTrees(diagnosis ~.,
                  data = heartdisease,
                  main = "My 1st FFT", 
                  my.tree = in_words)

## ----plot-my-tree, fig.cap="**Figure 1**: An FFT manually constructed using the `my.tree` argument of `FFTrees()`.", fig.show='hold'----
# Inspect FFTrees object:
plot(my_fft)

## ----verbal-spec-fft, fig.cap="**Figure 2**: Another FFT manually constructed using the `my.tree` argument of `FFTrees()`.", fig.show='hold'----
# Create 2nd FFTrees from an alternative FFT description (as my.tree): 
my_fft_2 <- FFTrees(diagnosis ~.,
                    data = heartdisease, 
                    main = "My 2nd FFT", 
                    my.tree = "If thal = {rd,fd}, predict True.
                               If cp != {a}, predict False. 
                               If ca > 1, predict True. 
                               Otherwise, predict False.")

# Inspect FFTrees object:
plot(my_fft_2)

## ----checking-my-tree, echo = FALSE, eval = FALSE-----------------------------
#  # 1. FFT with 2 cues (final cue is categorical): ------
#  fft_1 <- FFTrees(diagnosis ~.,
#                      data = heartdisease, main = "My test 1",
#                      my.tree = "If age < 45, predict False.
#                                 If thal = {fd, normal}, predict True.
#                                 Otherwise, predict the opposite.")
#  
#  # inspect:
#  fft_1$trees$definitions
#  # Note 1:
#  # Corrected an error in the direction definition of the final node:
#  # When 1st part of last sentence predicts TRUE,
#  # the final direction must not be negated.
#  
#  plot(fft_1)
#  fft_1
#  inwords(fft_1)
#  
#  
#  # 2. Reverse cue order (i.e, final cue is numeric), but set to True (by reversing cue direction): ------
#  fft_2 <- FFTrees(diagnosis ~.,
#                      data = heartdisease, main = "My test 2",
#                      my.tree = "If thal = {fd, normal}, predict true!
#                                 If age >= 45, predict TRUE (again)!
#                                 Otherwise, go crazy (but mention 'FALSE' somewhere)...")
#  # inspect:
#  fft_2$trees$definitions
#  # Notes:
#  # - The final sentence always predicts positive (True) instances first.
#  #   When the description predicted False instances first, the cue direction WAS reversed.
#  # - Note improved robustness against lower/uppercase spellings/typos in cue labels.
#  
#  plot(fft_2)
#  inwords(fft_2)
#  fft_2
#  
#  # Comparing my_fft_1 and my_fft_2 shows that cue order matters:
#  # In my_fft_1, the initial age cue causes few misses, but the 2nd thal cue makes more error than correct cases.
#  # In my_fft_2, the initial thal cue causes many false alarms, and the 2nd age cue also is too liberal (on FA).
#  
#  
#  # 3. Example used by Nathaniel (and skipping "otherwise" part of final node): ------
#  fft_3 <- FFTrees(formula = diagnosis ~.,
#                   data = heart.train,
#                   data.test = heart.test, main = "My test 3",
#                   decision.labels = c("Healthy", "Disease"),
#                   my.tree = "If sex = 1, predict Disease.
#                              If age < 45, predict Healthy.
#                              If thal = {fd, normal}, predict Disease.
#                              (etc.)")
#  
#  fft_3$trees$definitions
#  plot(fft_3)
#  inwords(fft_3)
#  fft_3
#  
#  
#  # 4. The shortest possible my.tree: ------
#  fft_4 <- FFTrees(formula = survived ~.,
#                   data = titanic, main = "My test 4",
#                   my.tree = "If sex = {female} true.") # ignore otherwise/else part
#  
#  plot(fft_4)
#  # Note:
#  # - Warning that 'False' does not occur in specification, but FFT is valid and constructed.
#  # - fft_4 shows good specificity (i.e., few false alarms, relative to high number of correct rejections),
#  #   but poor sensitivity (many misses).
#  #   Overall accuracy is 10% above baseline (predicting False for all cases).

## ----design-fft-df, echo = FALSE, eval = FALSE--------------------------------
#  # Modify an existing FFT:
#  heart.fft <- FFTrees(formula = diagnosis ~ .,           # Criterion and (all) predictors
#                       data = heart.train,                # Training data
#                       data.test = heart.test,            # Testing data
#                       main = "Heart Disease",            # General label
#                       decision.labels = c("Low-Risk", "High-Risk"))  # Labels for decisions
#  
#  # Current FFTs:
#  heart.fft$trees$definition
#  
#  # Start from an existing FFT:
#  my.fft <- heart.fft$trees$definitions[1, ]
#  
#  # Make some changes:
#  my.fft["tree"]  <- 8
#  my.fft["exits"] <- c("1;1;0.5")
#  
#  # Add to existing FFTs (as a new / 8th row):
#  heart.fft$trees$definition[8, ] <- my.fft
#  heart.fft$trees$n <- 8
#  
#  # Use new FFT to predict same / new data:
#  predict(heart.fft, newdata = heartdisease, tree = 8)  # yields an ERROR...

