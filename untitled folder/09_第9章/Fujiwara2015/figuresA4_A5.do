* Replication file for "Voting Technology, Political Responsiveness, and Infant Health: Evidence from Brazil"
* This file generates Figures A4 amd A5
* The unit of observation is a state-electoral term

clear all
set more off
use state.dta, clear

gen inst_g=inst98e if year==1998
replace inst_g=1-inst02e if year==2002

reg d.inst98e reg* if year==1998 
  predict inst98e_ort, resid 
reg d.inst02e reg* if year==2002 
  predict inst02e_ort, resid  
quietly reg inst_g reg* if year<=2002 & year>=1998 
  predict inst_g_ort, resid  
  
reg d.util_rate reg* if year<=2002 & year>=1998 
  predict d_ag_util_rate_ort, resid
reg d.ag_ssaude reg* if year<=2002 & year>=1998 
  predict d_ag_ssaude_ort, resid  

quietly reg d.ag_lb_ined d.ag_lb_ined_cover reg* if year<=2002 & year>=1998 
  predict d_ag_lb_ined_ort, resid  
quietly reg d.ag_vis7_ined2 d.ag_vis_ined_cover  reg* if year<=2002 & year>=1998 
  predict d_ag_vis7_ined_ort, resid

quietly reg d.ag_lb_ined d.ag_lb_ined_cover reg* if year==1998 
  predict d_ag_lb_ined_ort1, resid 
quietly reg d.ag_lb_ined d.ag_lb_ined_cover reg* if year==2002 
  predict d_ag_lb_ined_ort2, resid 
quietly reg d.ag_lb_ined d.ag_lb_ined_cover reg*  if year<=2002 & year>=1998 
  predict d_ag_lb_ined_ort3, resid  
  
quietly reg d.inst98e d.ag_lb_ined_cover reg* if year==1998 
  predict inst98e_ort2, resid 
quietly reg d.inst02e d.ag_lb_ined_cover reg* if year==2002 
  predict inst02e_ort2, resid 
quietly reg inst_g d.ag_lb_ined_cover reg*  if year<=2002 & year>=1998 
  predict inst_g_ort2, resid  

quietly reg d.inst98e d.ag_vis_ined_cover reg* if year==1998 
  predict inst98e_ort3, resid 
quietly reg d.inst02e d.ag_vis_ined_cover reg* if year==2002 
  predict inst02e_ort3, resid 
quietly reg inst_g d.ag_vis_ined_cover reg*  if year<=2002 & year>=1998 
  predict inst_g_ort3, resid   
  
quietly reg d.ag_vis7_ined2 d.ag_vis_ined_cover reg* if year==1998 
  predict d_ag_vis7_ined_ort1, resid
quietly reg d.ag_vis7_ined2 d.ag_vis_ined_cover reg* if year==2002 
  predict d_ag_vis7_ined_ort2, resid
quietly reg d.ag_vis7_ined2 d.ag_vis_ined_cover reg*  if year<=2002 & year>=1998 
  predict d_ag_vis7_ined_ort3, resid
  
 
 
*******1998*************
#delimit ;
local y d_ag_util_rate_ort;
local rangex "-.4 .6";
local rangey "-0.05 .12";
twoway scatter `y' inst98e_ort if year==1998 ,  ms()  ||
lfit `y' inst98e_ort if year==1998 ,
saving(util1, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Change in Valid Votes/Turnout, 94-98", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel A: Paper (1994) to Discont. (1998) ", size(medium));
#delimit cr
******2002**********
#delimit ;
local y d_ag_util_rate_ort;
local rangex "-.4 .6";
local rangey "-0.1 .07";
twoway scatter `y' inst02e_ort if year==2002 ,  ms()  ||
lfit `y' inst02e_ort if year==2002 ,
saving(util2, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Change in Valid Votes/Turnout, 98-02", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel B: Discont. (1998) to Electr. (2002) ", size(medium));
#delimit cr
******************
******Pooled************
#delimit ;
local y d_ag_util_rate_ort;
local rangex "-.4 .6";
local rangey "-0.05 .12";
twoway scatter `y' inst_g_ort if year<=2002 & year>=1998 ,  ms()  ||
lfit `y' inst_g_ort if year<=2002 & year>=1998 ,
saving(util3, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Change in Valid Votes/Turnout", size(medium)) l1title("(Residuals)", size(medium))
xtitle("Change in Use of Electronic Voting (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel C: Pooled 1994 - 2002 ", size(medium));
#delimit cr
******************

*******1998*************
#delimit ;
local y d_ag_ssaude_ort;
local rangex "-.4 .6";
local rangey "-0.05 .05";
twoway scatter `y' inst98e_ort if year==1998 ,  ms()  ||
lfit `y' inst98e_ort if year==1998 ,
saving(`y'1, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Change in Spending Share in Health, 94-98", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel A: Paper (1994) to Discont. (1998) ", size(medium));
#delimit cr
******2002**********
#delimit ;
local y d_ag_ssaude_ort;
local rangex "-.4 .6";
local rangey "-0.05 .05";
twoway scatter `y' inst02e_ort if year==2002 ,  ms()  ||
lfit `y' inst02e_ort if year==2002 ,
saving(`y'2, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Change in Spending Share in Health, 98-02", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel B: Discont. (1998) to Electr. (2002) ", size(medium));
#delimit cr
******************
******Pooled************
#delimit ;
local y d_ag_ssaude_ort;
local rangex "-.4 .6";
local rangey "-0.05 .05";
twoway scatter `y' inst_g_ort if year<=2002 & year>=1998 ,  ms()  ||
lfit `y' inst_g_ort if year<=2002 & year>=1998 ,
saving(`y'3, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Change in Spending Share in Health, 94-98", size(medium)) l1title("(Residuals)", size(medium))
xtitle("Change in Use of Electronic Voting (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel C: Pooled 1994 - 2002 ", size(medium));
#delimit cr
******************

*******1998*************
#delimit ;
local y d_ag_lb_ined_ort;
local rangex "-.4 .6";
local rangey "-0.01 .01";
twoway scatter `y' inst98e_ort2 if year==1998 ,  ms()  ||
lfit `y'1 inst98e_ort2 if year==1998 ,
saving(`y'1, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Share of Low-Weight Births, 94-98", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel A: Paper (1994) to Discont. (1998) ", size(medium));
#delimit cr
******2002**********
#delimit ;
local y d_ag_lb_ined_ort;
local rangex "-.4 .6";
local rangey "-0.01 .01";
twoway scatter `y' inst02e_ort2 if year==2002 ,  ms()  ||
lfit `y'2 inst02e_ort2 if year==2002 ,
saving(`y'2, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Share of Low-Weight Births, 98-02", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel B: Discont. (1998) to Electr. (2002) ", size(medium));
#delimit cr
******************
******Pooled************
#delimit ;
local y d_ag_lb_ined_ort;
local rangex "-.4 .6";
local rangey "-0.01 .01";
twoway scatter `y' inst_g_ort2 if year<=2002 & year>=1998 ,  ms()  ||
lfit `y'3 inst_g_ort2 if year<=2002 & year>=1998 ,
saving(`y'3, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Share of Low-Weight Births", size(medium)) l1title("(Residuals)", size(medium))
xtitle("Change in Use of Electronic Voting (Residuals)", size(medium)) 
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel C: Pooled 1994 - 2002 ", size(medium));
#delimit cr
******************

*******1998*************
#delimit ;
local y d_ag_vis7_ined_ort;
local rangex "-.4 .6";
local rangey "-0.1 .015";
twoway scatter `y' inst98e_ort3 if year==1998 ,  ms()  ||
lfit `y'1 inst98e_ort3 if year==1998 ,
saving(`y'1, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Share with 7+ Prenatal Visits, 94-98", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel A: Paper (1994) to Discont. (1998) ", size(medium));
#delimit cr
******2002**********
#delimit ;
local y d_ag_vis7_ined_ort;
local rangex "-.4 .6";
local rangey "-0.1 .15";
twoway scatter `y' inst02e_ort3 if year==2002 ,  ms()  ||
lfit `y'2 inst02e_ort3 if year==2002 ,
saving(`y'2, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Share with 7+ Prenatal Visits, 98-02", size(medium)) l1title("(Residuals)", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel B: Discont. (1998) to Electr. (2002) ", size(medium));
#delimit cr
******************
******Pooled************
#delimit ;
local y d_ag_vis7_ined_ort;
local rangex "-.4 .6";
local rangey "-0.1 .15";
twoway scatter `y' inst_g_ort3 if year<=2002 & year>=1998 ,  ms()  ||
lfit `y'3 inst_g_ort3 if year<=2002 & year>=1998 ,
saving(`y'3, replace) ysc(r(`rangey')) xsc(r(`rangex')) aspectratio()
l2title("Share with 7+ Prenatal Visits", size(medium))
xtitle("% of Voters Above Cutoff (Residuals)", size(medium)) l1title("(Residuals)", size(medium))
leg(off)  xlab(,labs(medium)) ylab(,labs(medium))
title("Panel C: Pooled 1994 - 2002 ", size(medium));
#delimit cr
******************

#delimit ;
graph combine 
util1.gph util2.gph util3.gph 
d_ag_ssaude_ort1.gph d_ag_ssaude_ort2.gph d_ag_ssaude_ort3.gph
, cols(3) rows(2)  altshrink saving(graph1, replace);
graph2tex, epsfile(seesaw1);


#delimit ;
graph combine 
d_ag_vis7_ined_ort1.gph d_ag_vis7_ined_ort2.gph d_ag_vis7_ined_ort3.gph
d_ag_lb_ined_ort1.gph d_ag_lb_ined_ort2.gph d_ag_lb_ined_ort3.gph
, cols(3) rows(2) altshrink saving(graph2, replace);
graph2tex, epsfile(seesaw2);


