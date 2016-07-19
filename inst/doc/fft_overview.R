## ---- echo = F, message = F, results = 'hide'----------------------------
library(FFTrees)

## ---- fig.width = 6, fig.height = 6, echo = F, fig.align='center'--------
bcancer.fft <- fft(diagnosis ~.,
                   data = breastcancer
                 )

plot(bcancer.fft,
     description = "Breast Cancer",
     decision.names = c("Absent", "Present"))

