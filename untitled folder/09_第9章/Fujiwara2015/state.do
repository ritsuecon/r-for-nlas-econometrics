* Replication file for "Voting Technology, Political Responsiveness, and Infant Health: Evidence from Brazil"
* This file generates all tables based on state-level data in the paper, except Tables 6, A6, and A7, generated in separate do-files.
* The unit of observation is a state-electoral term.

clear all
set more off
use state.dta, clear

gen x1 = d.inst
gen x2 = l.inst
gen rest_inst = inst
replace rest_inst = (x2-x1) if year==2002

#delimit ;
local list "util_rate right 
ag_ltotal ag_ssaude ag_lsaude 
ag_munic_ssaude ag_gini ag_lpop ag_lgdp ag_poverty ag_ssaude_placebo1 ag_ssaude_placebo2
ag_sadm ag_seduc ag_sassist  ag_ssegur ag_sjudic ag_stransp ag_slegis ag_small_other 
share_PCdoB share_PT share_PSB share_PPS share_PDT share_PSDB share_PMDB share_PTB share_PL	share_PFL share_other
ag_pcdesp_saude ag_pcdesp_total ag_pcrev_nom ag_pcnet_int"; 
#delimit cr

sum `list'

*Column 1 of Tables 4, 5, A2, A3, and A4
 log using cgm_1994_1998.log, replace
qui reg d.inst98e reg* delec* if year==1998 
 predict z, resid
foreach var in `list' {
 local y `var'
qui reg d.`y' reg* delec* if year==1998 
 predict y_`var', resid
reg y_`var' z if year==1998, cl(uf)
cgmwildboot y_`var' z if year==1998, cl(uf) bootcluster(uf) seed(1000) reps(1000)
}
drop y_*
drop z
log close
*****

*Column 2 of Tables 4, 5, A2, A3, and A4
set more off
 log using cgm_1998_2002.log, replace
qui reg d.inst02e reg* delec* if year==2002
 predict z, resid
foreach var in  `list' {
 local y `var'
qui reg d.`y' reg* delec* if year==2002
 predict y_`var', resid
reg y_`var' z if year==2002, cl(uf)
cgmwildboot y_`var' z if year==2002, cl(uf) bootcluster(uf) seed(1000) reps(1000)
}
drop y_*
drop z
log close
*****

*Column 3 of Tables 4, 5, A2, A3, and A4
set more off
 log using cgm_pooled.log, replace
qui reg inst delec* reg* duf*
 predict z, resid
foreach var in  `list' {
 local y `var'
qui reg `y' reg* delec* duf*
 predict y_`var', resid
reg y_`var' z , cl(uf)
cgmwildboot y_`var' z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
}
drop y_*
drop z
log close
*****

*Column 4 of Tables 4, 5, A2, A3, and A4
set more off
 log using cgm_pooled_col4test.log, replace
qui reg rest_inst delec* reg* duf*
 predict z, resid
foreach var in `list' {
 local y `var'
qui reg `y' reg* delec* duf*
 predict y_`var', resid
reg y_`var' z , cl(uf)
cgmwildboot y_`var' z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
}
drop y_*
drop z
log close
*****

*Results for pre-natal visits, uneducated mothers (Panel C, Table 4)
set more off
 log using cgm_visits_uned.log, replace
 local y ag_vis7_ined2
 local x ag_vis_ined_cover
 qui reg d.`y' `x' reg* delec* if year==1998
  predict y_1, resid
 qui reg d.`y' `x' reg* delec* if year==2002
  predict y_2, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_3, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_4, resid
 qui reg d.inst98e `x' reg* delec* if year==1998
  predict z_1, resid
 qui reg d.inst02e `x' reg* delec* if year==2002
  predict z_2, resid
 qui reg inst `x' delec* reg* duf*
  predict z_3, resid
 qui reg rest_inst `x'  delec* reg* duf*
  predict z_4, resid
reg y_1 z_1 if year==1998 , cl(uf) 
reg y_2 z_2 if year==2002 , cl(uf) 
reg y_3 z_3 , cl(uf) 
reg y_4 z_4 , cl(uf) 
cgmwildboot y_1 z_1 if year==1998 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_2 z_2 if year==2002 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_3 z_3 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_4 z_4 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
drop y_*
drop z_*
log close
*******************************

*Results for birthweight, uneducated mothers (Panel C, Table 4)
set more off
 log using cgm_bw_uned.log, replace
local y ag_lb_ined
local x ag_lb_ined_cover
 qui reg d.`y' `x' reg* delec* if year==1998
  predict y_1, resid
 qui reg d.`y' `x' reg* delec* if year==2002
  predict y_2, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_3, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_4, resid
 qui reg d.inst98e `x' reg* delec* if year==1998
  predict z_1, resid
 qui reg d.inst02e `x' reg* delec* if year==2002
  predict z_2, resid
 qui reg inst `x' delec* reg* duf*
  predict z_3, resid
 qui reg rest_inst `x'  delec* reg* duf*
  predict z_4, resid
reg y_1 z_1 if year==1998 , cl(uf) 
reg y_2 z_2 if year==2002 , cl(uf) 
reg y_3 z_3 , cl(uf) 
reg y_4 z_4 , cl(uf)
cgmwildboot y_1 z_1 if year==1998 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_2 z_2 if year==2002 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_3 z_3 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_4 z_4 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
drop y_*
drop z_*
log close
*******************************

*Results for pre-natal visits, educated mothers (Panel B, Table 5)
set more off
 log using cgm_visits_ed.log, replace
local y ag_vis7_educ2
local x ag_vis_educ_cover
 qui reg d.`y' `x' reg* delec* if year==1998
  predict y_1, resid
 qui reg d.`y' `x' reg* delec* if year==2002
  predict y_2, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_3, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_4, resid
 qui reg d.inst98e `x' reg* delec* if year==1998
  predict z_1, resid
 qui reg d.inst02e `x' reg* delec* if year==2002
  predict z_2, resid
 qui reg inst `x' delec* reg* duf*
  predict z_3, resid
 qui reg rest_inst `x'  delec* reg* duf*
  predict z_4, resid
reg y_1 z_1 if year==1998 , cl(uf) 
reg y_2 z_2 if year==2002 , cl(uf) 
reg y_3 z_3 , cl(uf) 
reg y_4 z_4 , cl(uf)  
cgmwildboot y_1 z_1 if year==1998 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_2 z_2 if year==2002 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_3 z_3 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_4 z_4 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
drop y_*
drop z_*
log close
*******************************

*Results for birthweight, educated mothers (Panel B, Table 5)
set more off
 log using cgm_bw_ed.log, replace
local y ag_lb_educ
local x ag_lb_educ_cover
 qui reg d.`y' `x' reg* delec* if year==1998
  predict y_1, resid
 qui reg d.`y' `x' reg* delec* if year==2002
  predict y_2, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_3, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_4, resid
 qui reg d.inst98e `x' reg* delec* if year==1998
  predict z_1, resid
 qui reg d.inst02e `x' reg* delec* if year==2002
  predict z_2, resid
 qui reg inst `x' delec* reg* duf*
  predict z_3, resid
 qui reg rest_inst `x'  delec* reg* duf*
  predict z_4, resid
reg y_1 z_1 if year==1998 , cl(uf) 
reg y_2 z_2 if year==2002 , cl(uf) 
reg y_3 z_3 , cl(uf) 
reg y_4 z_4 , cl(uf)  
cgmwildboot y_1 z_1 if year==1998 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_2 z_2 if year==2002 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_3 z_3 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_4 z_4 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
drop y_*
drop z_*
log close
*******************************

*Second row, Table A5
set more off
 log using cgm_visits_uned6.log, replace
 local y ag_vis6_ined2
 local x ag_vis_ined_cover
 qui reg d.`y' `x' reg* delec* if year==1998
  predict y_1, resid
 qui reg d.`y' `x' reg* delec* if year==2002
  predict y_2, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_3, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_4, resid
 qui reg d.inst98e `x' reg* delec* if year==1998
  predict z_1, resid
 qui reg d.inst02e `x' reg* delec* if year==2002
  predict z_2, resid
 qui reg inst `x' delec* reg* duf*
  predict z_3, resid
 qui reg rest_inst `x'  delec* reg* duf*
  predict z_4, resid
reg y_1 z_1 if year==1998 , cl(uf) 
reg y_2 z_2 if year==2002 , cl(uf) 
reg y_3 z_3 , cl(uf) 
reg y_4 z_4 , cl(uf)   
cgmwildboot y_1 z_1 if year==1998 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_2 z_2 if year==2002 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_3 z_3 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_4 z_4 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
drop y_*
drop z_*
log close
*******************************

*First row, Table A5
set more off
 log using cgm_visits_uned0.log, replace
 local y ag_vis0_ined2
 local x ag_vis_ined_cover
 qui reg d.`y' `x' reg* delec* if year==1998
  predict y_1, resid
 qui reg d.`y' `x' reg* delec* if year==2002
  predict y_2, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_3, resid
 qui reg `y' `x' delec* reg* duf*
  predict y_4, resid
 qui reg d.inst98e `x' reg* delec* if year==1998
  predict z_1, resid
 qui reg d.inst02e `x' reg* delec* if year==2002
  predict z_2, resid
 qui reg inst `x' delec* reg* duf*
  predict z_3, resid
 qui reg rest_inst `x'  delec* reg* duf*
  predict z_4, resid
reg y_1 z_1 if year==1998 , cl(uf) 
reg y_2 z_2 if year==2002 , cl(uf) 
reg y_3 z_3 , cl(uf) 
reg y_4 z_4 , cl(uf)   
cgmwildboot y_1 z_1 if year==1998 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_2 z_2 if year==2002 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_3 z_3 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
cgmwildboot y_4 z_4 , cl(uf) bootcluster(uf) seed(1000) reps(1000)
drop y_*
drop z_*
log close
*******************************

