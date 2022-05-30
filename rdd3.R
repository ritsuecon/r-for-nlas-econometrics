
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
  xlab("有権者登録数 - 1996") +
  ylab("有効票率") +
  theme_bw(base_family = "HiraKakuPro-W3") +
  scale_colour_manual(values = c("#00BA38", "#619cff", "#f8766d"),
                      name = "",
                      labels = c("有効票/投票数 - 1994選挙（紙のみ）",
                                 "有効票/投票数 - 1998（4万5000人以上のみ電子投票）",
                                 "有効票/投票数 - 2002（電子投票のみ）")
  ) +
  theme(plot.margin = margin(0.5, 3, 0.5, 2, "cm"),
        legend.position = "bottom",
        legend.direction = "vertical") +
  labs(title = "電子投票制度の導入が有効票率に与えた影響", 
       caption = "（出所）Fujiwara (2015), Figure 2, p.435.")
