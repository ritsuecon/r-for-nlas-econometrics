piaac_original <- read.csv("piaac.csv")

piaac_female <- subset(piaac_original, gender == "Female")
piaac <-mlogit::mlogit.data(piaac_female, choice = "empstat_edt", shape = "wide") 


library(mlogit)
result <- mlogit(empstat_edt ~ 1 | educ + age + couple + child, 
                 reflevel = "3", 
                 data = piaac)

summary(result)

average_me <- function(x, data) {
  
  coef_names_length <- length(names(x$model))
  coef_names_drop <- coef_names_length - 2
  coef_names <- names(x$model)[c(-1, -coef_names_drop:-coef_names_length)]
  
  marginal_effects <- sapply(coef_names, function(x) 
    stats::effects(result, covariate = x, data = data), 
    simplify = FALSE) 
  
  ame <- t(sapply(marginal_effects, colMeans))
  
  return(ame)
}


(ame <- average_me(result, piaac))

ame[, c(2, 3, 1)] # 見づらいので並び替え


average_me(result, piaac)

x <- result
coef_names_length <- length(names(x$model))
coef_names_drop <- coef_names_length - 2
coef_names <- names(x$model)[c(-1, -coef_names_drop:-coef_names_length)]


AME.fun <- function(betas) {
  tmp <- result
  tmp$coefficients <- betas
  ME.mnl <- sapply(coef_names, function(x) 
    effects(tmp, covariate = x, data = piaac), simplify = FALSE)
  c(sapply(ME.mnl, colMeans))
}

calculate_se <- function(model, data){
  
  coef_names_length <- length(names(model$model))
  coef_names_drop <- coef_names_length - 2
  coef_names <- names(model$model)[c(-1, -coef_names_drop:-coef_names_length)]
  
  AME.fun <- function(betas) {
    tmp <- model
    tmp$coefficients <- betas
    ME.mnl <- sapply(coef_names, function(x) 
      effects(tmp, covariate = x, data = data), simplify = FALSE)
    c(sapply(ME.mnl, colMeans))
  }
  
  grad <- numDeriv::jacobian(AME.fun, model$coef)
  ame_se <- matrix(sqrt(diag(grad %*% vcov(model) %*% t(grad))), nrow = length(coef_names), byrow = TRUE)
  
  return(ame_se)
}

calculate_se(result, piaac)

grad <- numDeriv::jacobian(AME.fun, result$coef)
ame_se <- matrix(sqrt(diag(grad %*% vcov(result) %*% t(grad))), nrow = 4, byrow = TRUE)
z <- average_me(result, piaac) / ame_se

ame <- average_me(result, piaac)
p <- 1 - pnorm(abs(z))
p * 2

ame[1] - qnorm(0.975) * ame_se[1]
ame[1] + qnorm(0.975) * ame_se[1]


