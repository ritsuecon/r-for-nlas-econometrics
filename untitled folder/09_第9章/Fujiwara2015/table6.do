* Replication file for "Voting Technology, Political Responsiveness, and Infant Health: Evidence from Brazil"
* This file generates results in Table 6
* The unit of observation is a state-electoral term

clear all
set more off
use state.dta, clear

 log using robust.log, replace

foreach var of varlist none ag_lgdp ag_lpop ag_gini ag_poverty illiter area ag_munic_percapita{
 gen intcont98_`var' = l.`var'
 replace intcont98_`var' = 0 if year ~=1998
}

foreach var of varlist none ag_lgdp ag_lpop ag_gini ag_poverty illiter area ag_munic_percapita{
 gen intcont02_`var' = l2.`var'
 replace intcont02_`var' = 0 if year ~=2002
}

* Correlation matrix of controls
corr inst ag_lgdp ag_lpop ag_gini ag_poverty illiter area ag_munic_percapita if year==1998

* First row, columns 2-8
local y util_rate
  foreach control in none ag_lgdp ag_lpop ag_gini ag_poverty illiter area ag_munic_percapita {
  local x intcont98_`control' intcont02_`control'
 qui reg inst delec* reg* duf* `x'
  predict z , resid
 qui reg `y' reg* delec* duf* `x'
  predict y, resid
 sum `control'
 reg y z , cl(uf)
  scalar `control'_a_1=_b[z]
  scalar `control'_a_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
 drop y z
} 

* Second row, columns 2-8
local y ag_ssaude
 foreach control in ag_lgdp ag_lpop ag_gini ag_poverty illiter area ag_munic_percapita {
  local x intcont98_`control' intcont02_`control'
 qui reg inst delec* reg* duf* `x'
  predict z , resid
 qui reg `y' reg* delec* duf* `x'
  predict y, resid
 sum `control'
 reg y z , cl(uf)
  scalar `control'_b_1=_b[z]
  scalar `control'_b_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
 drop y z
 } 
 
* Third row, columns 2-8
local y ag_vis7_ined2
 foreach control in ag_lgdp ag_lpop ag_gini ag_poverty illiter area ag_munic_percapita {
  local x intcont98_`control' intcont02_`control'
 qui reg inst delec* reg* duf* `x' ag_vis_ined_cover
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_vis_ined_cover
  predict y, resid
 sum `control'
 reg y z , cl(uf)
  scalar `control'_c_1=_b[z]
  scalar `control'_c_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
 drop y z
}  

* Fourth row, columns 2-8
local y ag_lb_ined
 foreach control in ag_lgdp ag_lpop ag_gini ag_poverty illiter area ag_munic_percapita  {
  local x intcont98_`control' intcont02_`control' 
 qui reg inst delec* reg* duf* `x' ag_lb_ined_cover 
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_lb_ined_cover  
  predict y, resid
 sum `control'
 reg y z , cl(uf)
  scalar `control'_d_1=_b[z]
  scalar `control'_d_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
 drop y z
}  

* Column 1 (all rows)
local y util_rate 
  local x  ag_lgdp ag_lpop ag_gini ag_poverty
 qui reg inst delec* reg* duf* `x' 
  predict z , resid
 qui reg `y' reg* delec* duf* `x' 
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar control_a_1=_b[z]
  scalar control_a_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_ssaude
  local x  ag_lgdp ag_lpop ag_gini ag_poverty
 qui reg inst delec* reg* duf* `x' 
  predict z , resid
 qui reg `y' reg* delec* duf* `x' 
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar control_b_1=_b[z]
  scalar control_b_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_vis7_ined2
  local x  ag_lgdp ag_lpop ag_gini ag_poverty
 qui reg inst delec* reg* duf* `x' ag_vis_ined_cover  
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_vis_ined_cover  
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar control_c_1=_b[z]
  scalar control_c_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_lb_ined
  local x ag_lgdp ag_lpop ag_gini ag_poverty
 qui reg inst delec* reg* duf* `x' ag_lb_ined_cover  
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_lb_ined_cover  
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar control_d_1=_b[z]
  scalar control_d_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
 ************************************************* 

* Column 9 (all rows)
local y util_rate
  local x  intcont98_area intcont02_area  intcont98_ag_lpop intcont02_ag_lpop 
 qui reg inst delec* reg* duf* `x' 
  predict z , resid
 qui reg `y' reg* delec* duf* `x' 
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar popdens_a_1=_b[z]
  scalar popdens_a_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_ssaude
  local x  intcont98_area intcont02_area  intcont98_ag_lpop intcont02_ag_lpop 
 qui reg inst delec* reg* duf* `x' 
  predict z , resid
 qui reg `y' reg* delec* duf* `x' 
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar popdens_b_1=_b[z]
  scalar popdens_b_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_vis7_ined2
  local x  intcont98_area intcont02_area  intcont98_ag_lpop intcont02_ag_lpop 
 qui reg inst delec* reg* duf* `x' ag_vis_ined_cover  
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_vis_ined_cover  
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar popdens_c_1=_b[z]
  scalar popdens_c_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_lb_ined
  local x  intcont98_area intcont02_area  intcont98_ag_lpop intcont02_ag_lpop 
 qui reg inst delec* reg* duf* `x' ag_lb_ined_cover  
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_lb_ined_cover  
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar popdens_d_1=_b[z]
  scalar popdens_d_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
 ************************************************* 

 gen restsamp=0
 replace restsamp=1 if uf~="AL" & uf~="AP" & uf~="RJ" & uf~="RR"
 
* Column 10, all rows
local x 
local y util_rate
 qui reg inst delec* reg* duf* if restsamp==1
  predict z , resid
 qui reg `y' reg* delec* duf* if restsamp==1
  predict y, resid
 *sum `control'
 reg y z if restsamp==1, cl(uf) 
  scalar rest_a_1=_b[z]
  scalar rest_a_2=_se[z]
 cgmwildboot y z if restsamp==1, cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_ssaude
 qui reg inst delec* reg* duf* if restsamp==1
  predict z , resid
 qui reg `y' reg* delec* duf* if restsamp==1
  predict y, resid
 *sum `control'
 reg y z if restsamp==1, cl(uf)
  scalar rest_b_1=_b[z]
  scalar rest_b_2=_se[z]
 cgmwildboot y z if restsamp==1, cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_vis7_ined2
 qui reg inst delec* reg* duf* ag_vis_ined_cover  if restsamp==1
  predict z , resid
 qui reg `y' reg* delec* duf* ag_vis_ined_cover  if restsamp==1
  predict y, resid
 *sum `control'
 reg y z if restsamp==1, cl(uf)
  scalar rest_c_1=_b[z]
  scalar rest_c_2=_se[z]
 cgmwildboot y z if restsamp==1, cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_lb_ined
 qui reg inst delec* reg* duf* ag_lb_ined_cover  if restsamp==1
  predict z , resid
 qui reg `y' reg* delec* duf*  ag_lb_ined_cover  if restsamp==1
  predict y, resid
 *sum `control'
 reg y z if restsamp==1, cl(uf)
  scalar rest_d_1=_b[z]
  scalar rest_d_2=_se[z]
 cgmwildboot y z if restsamp==1, cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
 ************************************************* 
 
* Column 11, all rows
local x  dtrend_elec*
local y util_rate
 qui reg inst delec* reg* duf* `x' 
  predict z , resid
 qui reg `y' reg* delec* duf* `x' 
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar trend_a_1=_b[z]
  scalar trend_a_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_ssaude
 qui reg inst delec* reg* duf* `x' 
  predict z , resid
 qui reg `y' reg* delec* duf* `x' 
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar trend_b_1=_b[z]
  scalar trend_b_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_vis7_ined2
 qui reg inst delec* reg* duf* `x' ag_vis_ined_cover  
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_vis_ined_cover  
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar trend_c_1=_b[z]
  scalar trend_c_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
local y ag_lb_ined
 qui reg inst delec* reg* duf* `x' ag_lb_ined_cover  
  predict z , resid
 qui reg `y' reg* delec* duf* `x' ag_lb_ined_cover  
  predict y, resid
 *sum `control'
 reg y z , cl(uf)
  scalar trend_d_1=_b[z]
  scalar trend_d_2=_se[z]
 cgmwildboot y z , cl(uf) bootcluster(uf) seed(1000) reps(1000)
  drop y z
 ************************************************* 
 
scalar list 
 
log close  
