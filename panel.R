
ols <- plm(emp.rate ~ cap.rate + pref,
           data = mydata2,
           index = c("pref", "year"),
           model = "pooling") # 比較のためのOLS



fe1 <- plm(emp.rate ~ cap.rate, 
           data = mydata2,
           index = c("pref", "year"), 
           model = "within", 
           effect = "individual")
fe1


fe1 <- plm(emp.rate ~ cap.rate, 
           data = mydata2,
           index = c("pref", "year"), 
           model = "within", 
           effect = "individual")

sandwich1 <- function(object, ...) sandwich(object) * nobs(object) / (nobs(object) - 1)
coeftest(myfit, vcov = sandwich1)

G <- length(unique(mydata2$pref))
c <- G/(G - 1)
options(scipen = 1)
coeftest(ols, vcov = c * vcovHC(ols, type = "HC1", cluster = "group"))

coeftest(fe1, vcov = c * vcovHC(fe1, type = "HC1", cluster = "group"))
