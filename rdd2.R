munic <- haven::read_dta("munic.dta")

munic$bin_voters96 <- cut(munic$voters96, 
                          breaks = c(seq(500, 200000, 4000)), 
                          labels = c(seq(2500, 198000, 4000)))
library(tidyverse)

munic4plot <- munic %>% 
  select(voters96, bin_voters96, r_util94, r_util98, r_util02) %>% 
  group_by(bin_voters96) %>% 
  mutate(bin_util94 = mean(r_util94, na.rm = T), 
         bin_util98 = mean(r_util98, na.rm = T),
         bin_util02 = mean(r_util02, na.rm = T),
  )



munic4plot2 <- munic4plot %>% 
  select(r_util94, r_util98, r_util02, voters96, bin_voters96, bin_util94, bin_util98, bin_util02) %>% 
  pivot_longer(!c(r_util94, r_util98, r_util02, voters96, bin_voters96), names_to = "year", values_to = "turnout")
munic4plot2$year <- factor(munic4plot2$year, levels = c("bin_util94", "bin_util98", "bin_util02"))

ggplot(munic4plot2, aes(x = as.integer(as.character(bin_voters96)), y = turnout, colour = year)) +
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
  ggtitle("電子投票制度の導入が有効票率に与えた影響") +
  xlab("有権者登録数-1996") +
  ylab("有効票率") +
  theme_bw(base_family = "HiraKakuPro-W3") +
  scale_colour_manual(values = c("#00BA38", "#619cff", "#f8766d"),
                      name = "",
                      labels = c("1994選挙（紙のみ）", "1998（4万5000人以上のみ電子投票）", "2002（電子投票のみ）")
                      ) +
  theme(plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "bottom",
        legend.direction = "vertical")

