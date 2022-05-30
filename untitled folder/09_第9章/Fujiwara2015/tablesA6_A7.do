* Replication file for "Voting Technology, Political Responsiveness, and Infant Health: Evidence from Brazil"
* This file generates results in Tables A6 and A7
* The unit of observation is a state-electoral term

clear all
set more off
cd "C:\Users\tfuji\Dropbox\Electronic Voting\Replication Files"
use state.dta, clear

*Sets folder where all logs will be
cd "C:\Users\tfuji\Dropbox\Electronic Voting\Replication Files\logs"
 log using iv_regs_full.log, replace

*scalar drop _all
local dep ag_lb_ined
local x2 ag_lb_ined_cover
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* `x2'
  predict z , resid
 qui reg `dep' reg* delec* duf* `x2'
  predict y, resid
 qui reg inst reg* delec* duf* `x2'
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep ag_vis7_ined2
local x2 ag_vis_ined_cover
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* `x2'
  predict z , resid
 qui reg `dep' reg* delec* duf* `x2'
  predict y, resid
 qui reg inst reg* delec* duf* `x2'
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep ag_ssaude
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf*
  predict z , resid
 qui reg `dep' reg* delec* duf* 
  predict y, resid
 qui reg inst reg* delec* duf* 
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep util_rate
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* 
  predict z , resid
 qui reg `dep' reg* delec* duf* 
  predict y, resid
 qui reg inst reg* delec* duf* 
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep inst
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000  {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* 
  predict z , resid
 qui reg inst reg* delec* duf* 
  predict x1, resid
 reg x1 z, cl(uf) 
  scalar e_`dep'_`i'se=_se[z]
  scalar e_`dep'_`i'b=_b[z]
 cgmwildboot x1 z, cl(uf) bootcluster(uf) seed(1000) reps(1000)   
 drop x1 z 
}
scalar list

	log close

log using iv_regs_restricted.log, replace

drop if uf == "RJ" 
drop if uf == "AL"
drop if uf == "AP"
drop if uf == "RR"


*scalar drop _all
local dep ag_lb_ined
local x2 ag_lb_ined_cover
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* `x2'
  predict z , resid
 qui reg `dep' reg* delec* duf* `x2'
  predict y, resid
 qui reg inst reg* delec* duf* `x2'
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep ag_vis7_ined2
local x2 ag_vis_ined_cover
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* `x2'
  predict z , resid
 qui reg `dep' reg* delec* duf* `x2'
  predict y, resid
 qui reg inst reg* delec* duf* `x2'
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep ag_ssaude
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf*
  predict z , resid
 qui reg `dep' reg* delec* duf* 
  predict y, resid
 qui reg inst reg* delec* duf* 
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep util_rate
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000 {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* 
  predict z , resid
 qui reg `dep' reg* delec* duf* 
  predict y, resid
 qui reg inst reg* delec* duf* 
  predict x1, resid
 ivreg y (x1 = z), cl(uf) 
  scalar e_`dep'_`i'se=_se[x1]
  scalar e_`dep'_`i'b=_b[x1]
 qui reg x1 z
  predict x1_hat, xb
 cgmwildboot y x1_hat , cl(uf) bootcluster(uf) seed(1000) reps(1000)  
  drop y x1 z x1_hat
}
*scalar list

*scalar drop _all
local dep inst
foreach i in 500000 200000 100000 50000 40000 30000 20000 10000 5000  {
 replace inst`i'=0 if year~=1998 & inst`i'~=.
 qui reg inst`i' delec* reg* duf* 
  predict z , resid
 qui reg inst reg* delec* duf* 
  predict x1, resid
 reg x1 z, cl(uf) 
  scalar e_`dep'_`i'se=_se[z]
  scalar e_`dep'_`i'b=_b[z]
 cgmwildboot x1 z, cl(uf) bootcluster(uf) seed(1000) reps(1000)   
 drop x1 z 
}
scalar list

	log close





