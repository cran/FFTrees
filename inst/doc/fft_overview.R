## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ---- fig.width = 6, fig.height = 6, echo = T, fig.align='center', echo = F----
bcancer.fft <- fft(formula = diagnosis ~.,
                   data = breastcancer
                 )

plot(bcancer.fft,
     main = "Breast Cancer",
     decision.names = c("Absent", "Present"))

