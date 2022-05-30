* Replication file for "Voting Technology, Political Responsiveness, and Infant Health: Evidence from Brazil"
* This file generates the estimates in Figures A6-A9
* To generate the figures, rearranged the results in an Excel spreadsheet named "leaveout_table.xlsx" (this file is also provided in these replication files), and run figuresA6_A9_step2.do 
* The unit of observation is a state-electoral term

clear all
set more off
use state.dta, clear

encode uf, gen(cuf)

*Sets folder where all logs will be
 log using leaveout.log, replace
 
 local y util_rate
 local x 
  forvalues cuf=1(1)27 {
 	 qui reg inst delec* reg* duf* `x' if  cuf~=`cuf'
	 predict z , resid
	 qui reg `y' reg* delec* duf* `x' if  cuf~=`cuf'
	 predict y, resid
	 *reg y z if  cuf~=`cuf', cl(uf)
	 cgmwildboot y z if cuf~=`cuf' , cl(uf) bootcluster(uf) seed(1000) reps(1000) 
	drop y z 
 }
  
 local y ag_ssaude
 local x 
  forvalues cuf=1(1)27 {
 	 qui reg inst delec* reg* duf* `x' if  cuf~=`cuf'
	 predict z , resid
	 qui reg `y' reg* delec* duf* `x' if  cuf~=`cuf'
	 predict y, resid
	 *reg y z if  cuf~=`cuf', cl(uf)
	 cgmwildboot y z if cuf~=`cuf' , cl(uf) bootcluster(uf) seed(1000) reps(1000) 
	drop y z 
 }
 
 local y ag_vis7_ined2
 local x ag_vis_ined_cover
  forvalues cuf=1(1)27 {
 	 qui reg inst delec* reg* duf* `x' if  cuf~=`cuf'
	 predict z , resid
	 qui reg `y' reg* delec* duf* `x' if  cuf~=`cuf'
	 predict y, resid
	 *reg y z if  cuf~=`cuf', cl(uf)
	 cgmwildboot y z if cuf~=`cuf' , cl(uf) bootcluster(uf) seed(1000) reps(1000) 
	drop y z 
 }
 
 local y ag_lb_ined
 local x ag_lb_ined_cover 
  forvalues cuf=1(1)27 {
 	 qui reg inst delec* reg* duf* `x' if  cuf~=`cuf'
	 predict z , resid
	 qui reg `y' reg* delec* duf* `x' if  cuf~=`cuf'
	 predict y, resid
	 *reg y z if  cuf~=`cuf', cl(uf)
	 cgmwildboot y z if cuf~=`cuf' , cl(uf) bootcluster(uf) seed(1000) reps(1000) 
	drop y z 
 }
 
 log close
  
