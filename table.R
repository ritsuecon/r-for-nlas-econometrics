# Ritsu Kitagawa 20210610
# This R scripit creates a table 

# install.packages("modelsummary", dependencies = T)
library(modelsummary)

piaac_original <- read.csv("piaac.csv") # データの読み込み
piaac <- subset(piaac_original, gender == "Female") # 女性だけにサンプルを制限します．
piaac$emp <- 1 * (piaac$lfs == "Employed") 


ols <- estimatr::lm_robust(emp ~ educ + age + couple + child, 
                              data = piaac,
                              se_type = "stata")

probit <- glm(emp ~ educ + age + couple + child, 
              family = binomial(link = "probit"), 
              data = piaac)

probit_ame <- margins::margins(probit)

models <- list()
models[['OLS']] <- ols
models[['Probit']] <- probit
models[['AME']] <- probit_ame


# Viewerで表示
modelsummary(models, 
             gof_omit = "complete.obs|na.fraction|ncol|nrow|se_type|AIC|BIC|R2|R2Adj.|Log.Lik.",
             title = "Estimation results") 

# Wordファイル
modelsummary(models, 
             gof_omit = "complete.obs|na.fraction|ncol|nrow|se_type|AIC|BIC|R2|R2Adj.|Log.Lik.",
             title = "Estimation results",
             output = "table.docx")

