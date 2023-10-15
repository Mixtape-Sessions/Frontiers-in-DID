library(ggplot2)
library(msm)

# draw dose
set.seed(1234)
n <- 1000
p <- 0.9
treated <- sample(c(0,1), size=n, replace=TRUE, prob=c(1-p,p))

dose_type <- "tnorm"
if (dose_type == "exponential") {
  lambda <- 1/15
  dose <- rexp(n, rate=lambda)
} else if (dose_type == "uniform") {
  dose <- runif(n, min=0, max=100)  
} else if (dose_type == "tnorm") {
  dose <- rtnorm(n, mean=0.5, sd=0.16, lower=0, upper=1)
}
dose[treated==0] <- 0

ATT <- -4*(dose-.5)^2 + 1
ATT_deriv <- -8*(dose-.5)
#ATT <- exp(dose/15) - 1
#ATT_deriv <- exp(dose/15)/15

d_capital_labor_ratio <- ATT + rnorm(n,sd=.1)

medicare1 <- data.frame(hospital_id=1:n, d_capital_labor_ratio=d_capital_labor_ratio, medicare_share_1983=dose)

save(medicare1, file="medicare1.RData")
