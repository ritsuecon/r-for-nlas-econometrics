munic <- haven::read_dta("munic.dta")

munic$dep <- munic$voters96 - 40500
munic$ones <-  1


munic$bin_voters96 <- cut(munic$voters96, 
                          breaks = c(seq(500, 200000, 4000)), 
                          labels = c(seq(2500, 198000, 4000)))

library(tidyverse)


munic %>% 
  select(voters96, bin_voters96, r_util94, r_util98, r_util02)

munic4plot <- munic %>% 
  select(voters96, bin_voters96, r_util94, r_util98, r_util02) %>% 
  group_by(bin_voters96) %>% 
  mutate(bin_util94 = mean(r_util94, na.rm = T), 
         bin_util98 = mean(r_util98, na.rm = T),
         bin_util02 = mean(r_util02, na.rm = T),
  )

munic4plot <- munic4plot %>%
  group_by(bin_voters96) %>% 
  mutate(bin_util94 = mean(r_util94, na.rm = T), 
         bin_util98 = mean(r_util98, na.rm = T),
         bin_util02 = mean(r_util02, na.rm = T),
         bin_attend = mean(attend, na.rm = T),
         bin_regist = mean(regist, na.rm = T),
         bin_obs = sum(ones, na.rm = T)
  )


munic4plot2 <- munic4plot %>% 
  select(r_util94, r_util98, r_util02, voters96, bin_voters96, bin_util94, bin_util98, bin_util02) %>% 
  pivot_longer(!c(r_util94, r_util98, r_util02, voters96, bin_voters96), names_to = "year", values_to = "turnout")


ggplot(munic4plot2, aes(x = as.integer(as.character(bin_voters96)), y = turnout, col = year)) +
  geom_point() + 
  
  geom_smooth(aes(x = voters96, y = r_util94, colour = "bin_util94"), 
              data = subset(munic4plot2, 5000 < voters96 & voters96 < 40500),
                            method = "lm", formula = y ~ x + I(x^2), se = F) +
  geom_smooth(aes(x = voters96, y = r_util94, colour = "bin_util94"), 
              data = subset(munic4plot2, 40500 < voters96 & voters96 < 100000),
              method = "lm", formula = y ~ x + I(x^2), se = F) +
  
  geom_smooth(aes(x = voters96, y = r_util98, colour = "bin_util98"), 
              data = subset(munic4plot2, 5000 < voters96 & voters96 < 40500),
              method = "lm", formula = y ~ x + I(x^2), se = F) +
  geom_smooth(aes(x = voters96, y = r_util98, colour = "bin_util98"), 
              data = subset(munic4plot2, 40500 < voters96 & voters96 < 100000),
              method = "lm", formula = y ~ x + I(x^2), se = F) +
  
  geom_smooth(aes(x = voters96, y = r_util02, colour = "bin_util02"), 
              data = subset(munic4plot2, 5000 < voters96 & voters96 < 40500),
              method = "lm", formula = y ~ x + I(x^2), se = F) +
  geom_smooth(aes(x = voters96, y = r_util02, colour = "bin_util02"), 
              data = subset(munic4plot2, 40500 < voters96 & voters96 < 100000),
              method = "lm", formula = y ~ x + I(x^2), se = F) +

  geom_vline(xintercept =  40500, linetype = "dotted") +
  coord_cartesian(
    xlim = c(8000, 97000),
    ylim = c(0.6, 1)) + 
  theme_bw()
  


ggplot(munic4plot, aes(x = as.integer(as.character(bin_voters96)))) +
  geom_point(aes(y = bin_util94), color = "green") +
  geom_point(aes(y = bin_util98), color = "blue") +
  geom_point(aes(y = bin_util02), color = "red") +
  geom_vline(xintercept =  40500, linetype = "dotted") +
  
  geom_smooth(data = subset(munic4plot, voters96 < 40500 & voters96 > 5000), 
              mapping = aes(x = voters96, y = r_util94), 
              method = "lm", formula = y ~ x + I(x^2), se = F, colour = "green") + 
  geom_smooth(data = subset(munic4plot, voters96 < 100000 & voters96 > 40500), 
              mapping = aes(x = voters96, y = r_util94),
              method = "lm", formula = y ~ x + I(x^2), se = F, colour = "green") + 
  geom_smooth(data = subset(munic4plot, voters96 < 40500 & voters96 > 5000),
              mapping = aes(x = voters96, y = r_util98),
              method = "lm", formula = y ~ x + I(x^2), se = F, colour = "blue") + 
  geom_smooth(data = subset(munic4plot, voters96 < 100000 & voters96 > 40500), 
              mapping = aes(x = voters96, y = r_util98), 
              method = "lm", formula = y ~ x + I(x^2), se = F, colour = "blue") + 
  geom_smooth(data = subset(munic4plot, voters96 < 40500 & voters96 > 5000),
              mapping = aes(x = voters96, y = r_util02),
              method = "lm", formula = y ~ x + I(x^2), se = F, colour = "red") + 
  geom_smooth(data = subset(munic4plot, voters96 < 100000 & voters96 > 40500),
              mapping = aes(x = voters96, y = r_util02),
              method = "lm", formula = y ~ x + I(x^2), se = F, colour = "red") + 
  
  coord_cartesian(
    xlim = c(8000, 97000),
    ylim = c(0.6, 1)) + 
  theme_bw()
