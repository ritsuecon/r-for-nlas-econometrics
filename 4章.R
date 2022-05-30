
### (1) {-}

```{r collapse=T}
model2 <- lm(log_gdp2013 ~ log_pop2013, data = mydata2)
vcov <- vcovHC(model2, type = "HC1")
result2 <- coeftest(model2, vcov. = vcov)
result2
```

### (2) {-}

```{r collapse=T}
beta1_2 <- result2["log_pop2013", "Estimate"]
se1_2 <- result2["log_pop2013", "Std. Error"]

t1_2 <- (beta1_2 - 1) / se1_2
```

### (3) {-}
```