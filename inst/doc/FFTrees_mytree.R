## ----setup, echo = FALSE------------------------------------------------------
knitr::opts_chunk$set(collapse = FALSE, 
                      comment = "#>", 
                      prompt = FALSE,
                      tidy = FALSE,
                      echo = TRUE, 
                      message = FALSE,
                      warning = FALSE,
                      # Default figure options:
                      dpi = 100,
                      fig.align = 'center',
                      fig.height = 6.0, 
                      fig.width  = 6.5, 
                      out.width = "600px")

## ----pkgs, echo = FALSE, message = FALSE, results = 'hide'--------------------
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

## ----plot-my-tree, fig.cap = "**Figure 1**: An FFT manually constructed using the `my.tree` argument of `FFTrees()`.", fig.show = 'hold'----
# Inspect FFTrees object:
plot(my_fft)

## ----verbal-spec-fft, fig.cap = "**Figure 2**: Another FFT manually constructed using the `my.tree` argument of `FFTrees()`.", fig.show = 'hold'----
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
#  
#  fft_1 <- FFTrees(diagnosis ~.,
#                   data = heartdisease,
#                   my.tree = "If age < 45, predict False.
#                                 If thal = {fd, normal}, predict True.
#                                 Otherwise, predict the opposite.",
#                   main = "My test 1")
#  
#  # inspect:
#  fft_1$trees$definitions
#  plot(fft_1)
#  fft_1
#  inwords(fft_1)
#  
#  # Note 1:
#  # Corrected an error in the direction definition of the final node:
#  # When 1st part of last sentence predicts TRUE,
#  # the final direction must not be negated.
#  
#  
#  # 2. Reverse cue order (i.e, final cue is numeric), but set to True (by reversing cue direction): ------
#  
#  fft_2 <- FFTrees(diagnosis ~.,
#                   data = heartdisease,
#                   my.tree = "If thal = {fd, normal}, predict true!
#                                 If age >= 45, predict TRUE (again)!
#                                 Otherwise, go crazy (but mention 'FALSE' somewhere)...",
#                   main = "My test 2")
#  # inspect:
#  fft_2$trees$definitions
#  plot(fft_2)
#  fft_2
#  inwords(fft_2)
#  
#  # Notes:
#  # - The final sentence always predicts positive (True) instances first.
#  #   When the description predicted False instances first, the cue direction WAS reversed.
#  # - Note improved robustness against lower/uppercase spellings/typos in cue labels.
#  
#  # Comparing my_fft_1 and my_fft_2 shows that cue order matters:
#  # In my_fft_1, the initial age cue causes few misses, but the 2nd thal cue makes more error than correct cases.
#  # In my_fft_2, the initial thal cue causes many false alarms, and the 2nd age cue also is too liberal (on FA).
#  
#  
#  # 3. Example used by Nathaniel (and skipping "otherwise" part of final node): ------
#  
#  fft_3 <- FFTrees(formula = diagnosis ~.,
#                   data = heart.train,
#                   data.test = heart.test,
#                   decision.labels = c("Healthy", "Disease"),
#                   my.tree = "If sex = 1, predict Disease.
#                              If age < 45, predict Healthy.
#                              If thal = {fd, normal}, predict Disease.
#                              (etc.)",
#                   main = "My test 3")
#  
#  fft_3$trees$definitions
#  plot(fft_3)
#  inwords(fft_3)
#  fft_3
#  
#  
#  # 4. The shortest possible my.tree: ------
#  
#  fft_4 <- FFTrees(formula = survived ~.,
#                   data = titanic,
#                   my.tree = "If sex = {female} true.",  # ignore otherwise/else part
#                   main = "My test 4")
#  
#  plot(fft_4)
#  
#  # Note:
#  # - Warning that 'False' does not occur in specification, but FFT is valid and constructed.
#  # - fft_4 shows good specificity (i.e., few false alarms, relative to high number of correct rejections),
#  #   but poor sensitivity (many misses).
#  #   Overall accuracy is 10% above baseline (predicting False for all cases).

## ----fft-treedef-01, message = FALSE------------------------------------------
# Create an FFTrees object x:
x <- FFTrees(formula = diagnosis ~ .,           # criterion and (all) predictors
             data = heart.train,                # training data
             data.test = heart.test,            # testing data
             main = "Heart Disease 1",          # initial label
             decision.labels = c("low risk", "high risk"),  # exit labels
             quiet = TRUE)                      # hide user feedback

## ----fft-treedef-02, message = FALSE------------------------------------------
# Tree definitions of x:
# summary(x)$definitions   # from summary()
x$trees$definitions        # from FFTrees object x

## ----fft-treedef-03, message = FALSE------------------------------------------
# 0. Copy and choose some existing FFT definitions:
tree_df <- x$trees$definitions    # get FFT definitions (as df)
tree_df <- tree_df[c(1, 3, 5), ]  # filter 3 particular FFTs

# 1. Add a tree with 1;1;0.5 exit structure (a "rake" tree with Signal bias):
tree_df[4, ] <- tree_df[1, ]        # initialize new FFT #4 (as copy of FFT #1)
tree_df$exits[4] <- c("1; 1; 0.5")  # modify exits of FFT #4

tree_df$tree <- 1:nrow(tree_df)   # adjust tree numbers
# tree_df

## ----fft-treedef-04, message = FALSE------------------------------------------
# 2. Change cue orders:
tree_df[5:8, ] <- tree_df[1:4, ]     # 4 new FFTs (as copiess of existing ones)
tree_df$cues[5:8] <- "cp; thal; ca"       # modify order of cues
tree_df$thresholds[5:8] <- "a; rd,fd; 0"  # modify order of thresholds accordingly

tree_df$tree <- 1:nrow(tree_df)           # adjust tree numbers
# tree_df

## ----fft-treedef-05, message = TRUE-------------------------------------------
# Create a modified FFTrees object y:
y <- FFTrees(object = x,                  # use previous FFTrees object x
             tree.definitions = tree_df,  # but with new tree definitions
             main = "Heart Disease 2"     # revised label
)

## ----fft-treedef-06, message = TRUE-------------------------------------------
y$trees$definitions  # tree definitions
y$trees$stats$train  # training statistics

## ----fft-treedef-07, eval = FALSE---------------------------------------------
#  # Print and plot FFT #6:
#  print(y, tree = 6, data = "test")
#  plot(y,  tree = 6, data = "test")

## ----design-fft-df, echo = FALSE, eval = FALSE--------------------------------
#  # Modify and use an existing FFT:
#  
#  # Create original FFTs:
#  fft_0 <- FFTrees(formula = diagnosis ~ .,           # Criterion and (all) predictors
#                   data = heart.train,                # Training data
#                   data.test = heart.test,            # Testing data
#                   main = "Heart Disease (org)",      # General label
#                   decision.labels = c("LOW Risk", "HIGH Rrisk"), # Labels for decisions
#                   quiet = FALSE  # enable/suppress user feedback
#                   )
#  
#  # Copy object:
#  fft_1 <- fft_0  # to keep original safe
#  
#  plot(fft_1, tree = 1)
#  
#  # Current FFTs:
#  fft_1$trees$definitions
#  
#  # (1) Modify an existing FFT:
#  
#  # Start from an existing FFT:
#  my_fft <- fft_1$trees$definitions[1, ]  # take a row of df
#  my_fft
#  
#  # Make some changes:
#  # Swap nodes 1 and 2 of Tree 1 (and add leading/trailing spaces):
#  my_fft$cues <- " cp ; thal ; ca "
#  my_fft$thresholds <- " a ; rd,fd ; 0 "  # swap according to cues
#  my_fft$exits <- "0 ; 1 ; 0.5 "         # swap according to cues
#  
#  my_fft$tree <- 8  # signal new tree (with new number)
#  
#  # Add my_fft to FFTrees object:
#  
#  # Add definitions of 8th tree:
#  # fft_1$trees$definitions[8, ] <- my_fft
#  
#  # # OR (combine tree definitions as rows of data frames):
#  my_fft_df <- rbind(fft_1$trees$definitions, my_fft)
#  my_fft_df
#  
#  # (2) Manual replacement: ----
#  
#  # Replace definitions in FFTrees object fft_1:
#  fft_1$trees$definitions <- my_fft_df
#  fft_1$trees$n <- as.integer(nrow(my_fft_df))
#  
#  # HAS fft_1 been changed?
#  fft_1$trees$n
#  fft_1$trees$definitions  # APPEARS to have been swapped (8 trees)
#  fft_1$trees$definitions[8, ]
#  
#  # Apply changed object fft_1 to data:
#  fft_2 <- fftrees_apply(fft_1, mydata = "test", newdata = heart.test)  # WORKS with new/8-th tree...
#  
#  fft_2$trees$definitions  # 8 tree definitions, but:
#  fft_2$trees$stats$train  # "train" parts still only contain 7 trees,
#  fft_2$trees$stats$test   # but "test" parts contain stats for 8 trees
#  
#  # Note: Curious fact:
#  fft_2$trees$best$test  # NEW tree has the best bacc value (for "test" data)!
#  
#  plot(fft_2, data = "test", tree = 8)
#  
#  
#  # (3) Automatic replacement (using FFTrees()): ----
#  
#  # Cover 3 cases:
#  # A. Provide tree.definitions without an `FFTrees` object
#  # B. Provide an `FFTrees` object, but no tree.definitions
#  # C. Provide both an object and tree.definitions
#  
#  # C. Provide both an existing FFTrees object and tree.definitions:
#  fft_3 <- FFTrees(#formula = diagnosis ~ .,            # as before
#                   object = fft_1,                     # some valid FFTrees object
#                   tree.definitions = my_fft_df,       # new tree definitions (as df)
#                   #data = heart.train,                 # training data
#                   #data.test = heart.test,             # testing data
#                   main = "Heart Disease (manual 1)",  # changed label
#                   decision.labels = c("low risk", "high risk")  # changed labels for decisions
#  )
#  
#  # => tree.definitions are being used, tree definitions of object are ignored!
#  # BUT: If formula and data is not specified, those of object are being used.
#  
#  plot(fft_3)
#  
#  fft_3$trees$definitions  # 8 trees: New FFT is now #4
#  
#  fft_3$trees$best  # FFT #4 is best test tree!
#  
#  plot(fft_3, data = "train", tree = "best.train")  # FFT #1
#  plot(fft_3, data = "test", tree = "best.test")    # FFT #4
#  
#  print(fft_3, data = "test", tree = "best.test")
#  
#  # Use new FFT object to predict same / new data:
#  predict(fft_3, newdata = heartdisease, tree = 4)  # WORKS, qed.

## ----design-fft-df-2, echo = FALSE, eval = FALSE------------------------------
#  # Provide tree.definitions but no object:
#  fft_4 <- FFTrees(formula = diagnosis ~ .,            # as before
#                   object = NULL,                      # NO FFTrees object
#                   tree.definitions = my_fft_df,       # new tree definitions (as df)
#                   data = heart.train,                 # training data
#                   data.test = heart.test,             # testing data
#                   main = "Heart Disease (manual 2)",  # changed label
#                   decision.labels = c("low R", "high R")  # changed labels for decisions
#  )
#  fft_4
#  
#  fft_4$trees$definitions  # 8 trees: New FFT is #4
#  
#  fft_4$trees$best  # FFT #4 is best test tree!
#  
#  plot(fft_4, data = "train", tree = "best.train")  # FFT #1
#  plot(fft_4, data = "test", tree = "best.test")    # FFT #4
#  
#  print(fft_4, data = "test", tree = "best.test")
#  

## ----design-fft-df-3, echo = FALSE, eval = FALSE------------------------------
#  # Provide an object, but no tree.definitions:
#  fft_5 <- FFTrees(formula = diagnosis ~ .,            # as before
#                   object = fft_3,                     # an existing FFTrees object
#                   tree.definitions = NULL,            # NO tree definitions (as df)
#                   data = heart.train,                 # training data
#                   data.test = heart.test,             # testing data
#                   main = "Heart Disease (manual 2)",  # changed label
#                   decision.labels = c("low R", "high R")  # changed labels for decisions
#  )
#  
#  fft_5
#  
#  fft_5$trees$definitions  # 8 trees: New FFT is #4
#  
#  fft_5$trees$best  # FFT #4 is best 'test' tree!
#  
#  plot(fft_5, data = "train", tree = "best.train")  # FFT #1
#  plot(fft_5, data = "test", tree = "best.test")    # FFT #4
#  
#  print(fft_5, data = "test", tree = "best.test")

## ----manual-tree-defs, echo = FALSE, eval = FALSE-----------------------------
#  # Create FFTs by algorithm:
#  fft_0 <- FFTrees(formula = diagnosis ~ .,           # criterion and (all) predictors
#                   data = heart.train,                # training data
#                   data.test = heart.test,            # testing data
#                   main = "Heart disease (auto)",     # some label
#                   decision.labels = c("low risk", "high risk"), # labels for decisions
#                   quiet = FALSE  # enable/suppress user feedback
#                   )
#  
#  print(fft_0, tree = "best.train", data = "train")
#  plot(fft_0, tree = "best.train", data = "train")
#  plot(fft_0, tree = "best.test", data = "test")
#  
#  # Inspect trees:
#  fft_0$trees$definitions
#  fft_0$trees$best
#  
#  # FFT #1:
#  fft_0$trees$definitions[1, ]
#  
#  # Re-create FFT #1:
#  my_fft_df <- data.frame(tree = c(1),
#                          nodes = c(3),
#                          classes = c("c; c; n"),
#                          cues = c("thal; cp; ca"),
#                          directions = c("=; =; >"),
#                          thresholds = c("rd,fd; a; 0"),
#                          exits = c("1; 0; 0.5"),
#                          stringsAsFactors = FALSE
#  )
#  
#  
#  
#  # Re-evaluate FFT on same data:
#  fft_1 <- FFTrees(formula = diagnosis ~ .,           # Criterion and (all) predictors
#                   data = heart.train,                # Training data
#                   data.test = heart.test,            # Testing data
#                   tree.definitions = my_fft_df,      # provide definition (as df)
#                   main = "Heart Disease (manual)"   # new label
#                   )
#  fft_1
#  
#  print(fft_1, tree = "best.train", data = "train")
#  plot(fft_1, tree = "best.train", data = "train")
#  plot(fft_1, tree = "best.test", data = "test")
#  
#  # Inspect trees:
#  fft_1$trees$definitions
#  fft_1$trees$best
#  
#  
#  # Re-create FFT #1 and permutations of cue orders:
#  my_fft_df_2 <- data.frame(tree = c(1, 2, 3),
#                            nodes = c(3, 3, 3),
#                            classes = c("c; c; n", "c; n; c", "n; c; c"),
#                            cues = c("thal; cp; ca", "thal; ca; cp", "ca; thal; cp"),
#                            directions = c("=; =; >", "=; >; =", ">; =; ="),
#                            thresholds = c("rd,fd; a; 0", "rd,fd; 0; a", "0; rd,fd; a"),
#                            exits = c("1; 0; 0.5", "1; 1; 0.5", "0; 1; 0.5"),
#                            stringsAsFactors = FALSE
#  )
#  my_fft_df_2
#  
#  # Re-evaluate FFTs on same data:
#  fft_2 <- FFTrees(formula = diagnosis ~ .,           # Criterion and (all) predictors
#                   data = heart.train,                # Training data
#                   data.test = heart.test,            # Testing data
#                   tree.definitions = my_fft_df_2,    # provide definitions (as df)
#                   main = "Heart Disease (manual)"   # new label
#                   )
#  fft_2
#  
#  # Inspect trees:
#  fft_2$trees$definitions  # Note: FFTs #2 and #3 swapped positions!
#  fft_2$trees$best
#  
#  fft_2$trees$stats
#  
#  plot(fft_2, tree = 2, data = "train")
#  plot(fft_2, tree = 2, data = "test")
#  
#  plot(fft_2, tree = 3, data = "train")
#  plot(fft_2, tree = 3, data = "test")

