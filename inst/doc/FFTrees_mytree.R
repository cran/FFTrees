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
                      out.width = "580px")

## ----pkgs, echo = FALSE, message = FALSE, results = 'hide'--------------------
library(FFTrees)

## ----heart-data, echo = FALSE-------------------------------------------------
knitr::kable(head(heartdisease[c("sex", "age", "thal", "cp", "ca", 
                                 "diagnosis")]))

## ----my-tree-describe-fft-1---------------------------------------------------
in_words <- "If sex = 1, predict True.
             If age < 45, predict False. 
             If thal = {fd, normal}, predict True. 
             Otherwise, predict False."

## ----my-tree-create-1, message = FALSE, results = 'hide'----------------------
# Create FFTrees from a verbal FFT description (as my.tree): 
my_fft <- FFTrees(formula = diagnosis ~.,
                  data = heartdisease,
                  main = "My 1st FFT", 
                  my.tree = in_words)

## ----my-tree-plot-1, fig.cap = "**Figure 1**: An FFT manually constructed using the `my.tree` argument of `FFTrees()`.", fig.show = 'hold'----
# Inspect FFTrees object:
plot(my_fft, data = "train")

## ----my-tree-def-1------------------------------------------------------------
# Get FFT definition(s):
get_fft_df(my_fft)  # my_fft$trees$definitions

## ----my-tree-fft-2-create, eval = FALSE, message = FALSE, results = 'hide'----
#  # Create a 2nd FFT from an alternative FFT description (as my.tree):
#  my_fft_2 <- FFTrees(formula = diagnosis ~.,
#                      data = heartdisease,
#                      main = "My 2nd FFT",
#                      my.tree = "If thal = {rd,fd}, predict True.
#                                 If cp != {a}, predict False.
#                                 If ca > 1, predict True.
#                                 Otherwise, predict False.")

## ----my-tree-fft-2-create-2, eval = TRUE, message = FALSE, results = 'hide'----
# Create a 2nd FFT from an alternative FFT description (as my.tree): 
my_fft_2 <- FFTrees(formula = diagnosis ~.,
                    data = heartdisease, 
                    main = "My 2nd FFT", 
                    my.tree = "If thal equals {rd,fd}, we shall say True.  
                               When Cp differs from {a}, let's predict False. 
                               Whenever CA happens to exceed 1, we will insist on True.
                               Else, we give up and go away.") 

## ----my-tree-fft-2-inwords----------------------------------------------------
inwords(my_fft_2)

## ----my-tree-plot-fft-2, fig.cap = "**Figure 2**: Another FFT manually constructed using the `my.tree` argument of `FFTrees()`.", fig.show = 'hold', collapse = TRUE----
# Visualize FFT:
plot(my_fft_2)

# FFT definition:
get_fft_df(my_fft_2)  # my_fft_2$trees$definitions
# Note the flipped direction value for 2nd cue (exit = '0'):
# 'if (cp  = a), predict 1' in the tree definition corresponds to 
# 'if (cp != a), predict 0' in the my.tree description and plot.  

## ----my-tree-checks-1, echo = FALSE, eval = FALSE-----------------------------
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
#  plot(fft_1)  # Note flipped direction for cue 1: exit = 0.
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
#                   my.tree = "If sex = {male} false.",  # ignore otherwise/else part
#                   main = "My test 4")
#  
#  plot(fft_4, n.per.icon = 50, what = "all", show.iconguide = TRUE)
#  
#  # Note:
#  # - Warning that either 'True' or 'False' label does NOT occur in specification, but FFT is valid and constructed.
#  # - fft_4 shows good specificity (i.e., few false alarms, relative to high number of correct rejections),
#  #   but poor sensitivity (many misses).
#  #   Overall accuracy is 10% above baseline (predicting False for all cases).

## ----fft-gfft, echo = FALSE, out.width = "500px", fig.cap = "**Figure 3**: Overview of 4 tree definition and conversion functions (in yellow)<br>and 6 tree trimming functions (in blue)."----
  knitr::include_graphics("../inst/gFFTs.png")

## ----fft-treedef-01, message = FALSE------------------------------------------
# Create an FFTrees object x:
x <- FFTrees(formula = diagnosis ~ .,           # criterion and (all) predictors
             data = heart.train,                # training data
             data.test = heart.test,            # testing data
             main = "Heart Disease 1",          # initial label
             decision.labels = c("low risk", "high risk"),  # exit labels
             quiet = TRUE)                      # hide user feedback

## ----fft-treedef-01b, echo = FALSE, eval = FALSE, message = FALSE-------------
#  # 3 ways to get tree definitions of x:
#  
#  # Get tree definitions of x:
#  df_1 <- summary(x)$definitions   # using summary()
#  df_2 <- x$trees$definitions      # part of FFTrees object x
#  df_3 <- get_fft_df(x)            # using get_fft_df()
#  
#  # Verify equality:
#  all.equal(df_1, df_2)
#  all.equal(df_2, df_3)

## ----fft-treedef-02, message = FALSE------------------------------------------
# Get tree definitions of x:
(tree_dfs <- get_fft_df(x))

## ----fft-read-fft-------------------------------------------------------------
(fft_1 <- read_fft_df(ffts_df = tree_dfs, tree = 1))

## ----fft-reorder-nodes--------------------------------------------------------
(my_fft_1 <- reorder_nodes(fft = fft_1, order = c(1, 3, 2)))

## ----fft-flip-exits-----------------------------------------------------------
(my_fft_2 <- flip_exits(my_fft_1, nodes = 1))

## ----fft-flip-exits-hide, echo = FALSE, eval = FALSE--------------------------
#  (my_fft_3 <- flip_exits(my_fft_1, nodes = 2))
#  (my_fft_4 <- flip_exits(my_fft_1, nodes = c(1, 2)))

## ----fft-pipe-1, message = FALSE----------------------------------------------
library(magrittr)

(my_fft_3 <- my_fft_1 %>% 
  flip_exits(nodes = 2))

## ----fft-pipe-2, message = FALSE----------------------------------------------
(my_fft_4 <- x %>% 
  get_fft_df() %>%
  read_fft_df(tree = 1) %>%
  reorder_nodes(order = c(1, 3, 2)) %>%
  flip_exits(nodes = c(1, 2)))

## ----write-fft-df-------------------------------------------------------------
(my_tree_dfs <- write_fft_df(my_fft_1, tree = 1))

## ----write-add-pipes----------------------------------------------------------
my_tree_dfs <- my_fft_2 %>%
  write_fft_df(tree = 2) %>%
  add_fft_df(my_tree_dfs)

my_tree_dfs <- my_fft_3 %>%
  write_fft_df(tree = 3) %>%
  add_fft_df(my_tree_dfs)

my_tree_dfs <- my_fft_4 %>%
  write_fft_df(tree = 4) %>%
  add_fft_df(my_tree_dfs)

my_tree_dfs

## ----use-tree-definitions-01--------------------------------------------------
# Evaluate tree.definitions for an existing FFTrees object y:
y <- FFTrees(object = x,                      # an existing FFTrees object
             tree.definitions = my_tree_dfs,  # new set of FFT definitions
             main = "Heart Disease 2"         # new label
             )

## ----eval-FFTs-01, eval = TRUE------------------------------------------------
summary(y)

# Visualize individual FFTs:
# plot(y, tree = 1)

## ----use-tree-definitions-02, eval = FALSE------------------------------------
#  # Create a new FFTrees object z:
#  z <- FFTrees(formula = diagnosis ~ .,
#               data = heartdisease,             # using full dataset
#               tree.definitions = my_tree_dfs,  # new set of FFT definitions
#               main = "Heart Disease 3"         # new label
#               )

## ----eval-FFTs-02, eval = FALSE-----------------------------------------------
#  # Summarize results:
#  summary(z)
#  
#  # Visualize an FFT:
#  plot(z, tree = 1)

## ----eval-FFTs-03, eval = TRUE------------------------------------------------
(all_fft_dfs <- add_fft_df(my_tree_dfs, tree_dfs))

## ----eval-FFTs-04, eval = FALSE-----------------------------------------------
#  # Create a new FFTrees object a:
#  all <- FFTrees(formula = diagnosis ~ .,
#                 data = heartdisease,             # using full dataset
#                 tree.definitions = all_fft_dfs,  # new set of FFT definitions
#                 main = "Heart Disease 4",        # new label
#  )
#  
#  # Summarize results:
#  summary(all)

## ----OLD-my-fft-part-01, echo = FALSE, eval = FALSE---------------------------
#  # To demonstrate creating and evaluating manual FFT definitions, we copy the existing tree definitions
#  # (as a data frame), select three FFTs (rows), and then create a 4th definition (with a different exit structure):
#  
#  # ```{r fft-treedef-03, message = FALSE}
#  # 0. Copy and choose some existing FFT definitions:
#  tree_dfs <- x$trees$definitions     # get FFT definitions (as df)
#  tree_dfs <- tree_dfs[c(1, 3, 5), ]  # filter 3 particular FFTs
#  
#  # 1. Add a tree with 1;1;0.5 exit structure (a "rake" tree with Signal bias):
#  tree_dfs[4, ] <- tree_dfs[1, ]      # initialize new FFT #4 (as copy of FFT #1)
#  
#  my_exits <- paste(get_exit_type(c(1, 1, .5)), collapse = "; ")  # OR:
#  # my_exits <- paste(get_exit_type(c("signal", "signal", "final")), collapse = "; ")
#  tree_dfs$exits[4] <- my_exits       # set exits of FFT #4
#  
#  tree_dfs$tree <- 1:nrow(tree_dfs)   # adjust tree numbers
#  # tree_dfs
#  # ```
#  
#  # Moreover, let's define four additional FFTs that reverse the order of the 1st and 2nd cues.
#  # As both cues are categorical (i.e., of class\ `c`) and have the same direction (i.e., `=`),
#  # we only need to reverse the `thresholds` (so that they correspond to the new cue order):
#  
#  # ```{r fft-treedef-04, message = FALSE}
#  # 2. Change cue orders:
#  tree_dfs[5:8, ] <- tree_dfs[1:4, ]         # add 4 FFTs (as copies of existing ones)
#  tree_dfs$cues[5:8] <- "cp; thal; ca"       # modify order of cues
#  tree_dfs$thresholds[5:8] <- "a; rd,fd; 0"  # modify order of thresholds accordingly
#  
#  tree_dfs$tree <- 1:nrow(tree_dfs)          # adjust tree numbers
#  # tree_dfs
#  # ```
#  
#  # The resulting data frame `tree_dfs` contains the definitions of eight FFTs.
#  # The first three are copies of trees in\ `x`, but the other five are new.

## ----OLD-my-fft-part-02, echo = FALSE, eval = FALSE---------------------------
#  
#  # We can evaluate this set by running the `FFTrees()` function with
#  # the previous `FFTrees` object\ `x` (i.e., with its `formula` and `data` settings) and
#  # specifying `tree_dfs` in the `tree.definitions` argument:
#  
#  # ```{r fft-treedef-05, message = FALSE, results = 'hide'}
#  # Create a modified FFTrees object y:
#  y <- FFTrees(object = x,                   # use previous FFTrees object x
#               tree.definitions = tree_dfs,  # but with new tree definitions
#               main = "Heart Disease 2"      # revised label
#  )
#  # ```
#  
#  # The resulting `FFTrees` object\ `y` contains the decisions and summary statistics of all eight FFTs for the data specified in\ `x`.
#  # Although it is unlikely that one of the newly created trees beats the automatically created FFTs, we find that reversing the order of the first cues has only minimal effects on training accuracy (as measured by `bacc`):
#  
#  # ```{r fft-treedef-06, message = TRUE}
#  y$trees$definitions  # tree definitions
#  y$trees$stats$train  # training statistics
#  # ```
#  
#  # Note that the trees in\ `y` were sorted by their performance on the current `goal` (here `bacc`).
#  # For instance, the new rake tree with cue order `cp; thal; ca` and exits `1; 1; 0.5` is now FFT\ #6.
#  # When examining its performance on `"test"` data (i.e., for prediction):
#  
#  # ```{r fft-treedef-07, eval = FALSE}
#  # Print and plot FFT #6:
#  print(y, tree = 6, data = "test")
#  plot(y,  tree = 6, data = "test")
#  # ```
#  
#  # we see that it has a balanced accuracy\ `bacc` of\ 70%.
#  # More precisely, its bias for predicting `disease` (i.e., signal or True) yields near-perfect sensitivity (96%), but very poor specificity (44%).
#  
#  # If we wanted to change more aspects of\ `x` (e.g., use different `data` or `goal` settings),
#  # we could create a new `FFTrees` object without supplying the previous object\ `x`,
#  # as long as the FFTs defined in `tree.definitions` correspond to the settings of `formula` and `data`.

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
#  fft_1 <- FFTrees(formula = diagnosis ~ .,          # Criterion and (all) predictors
#                   data = heart.train,               # Training data
#                   data.test = heart.test,           # Testing data
#                   tree.definitions = my_fft_df,     # provide definition (as df)
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

