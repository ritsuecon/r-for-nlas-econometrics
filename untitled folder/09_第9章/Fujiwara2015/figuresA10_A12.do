* Replication file for "Voting Technology, Political Responsiveness, and Infant Health: Evidence from Brazil"
* This file generates Figures A10-A12
* The unit of observation is a state-year

clear
set mem 50m
set more off
use yearly.dta

areg ssaude inst1996-inst2006 reg* if year_f>1994 & year_f<2007, rob a(uf)
 gen te_s = 0 if year_f==1995
 forvalues i = 1996(1)2006 {
  replace te_s = _b[inst`i'] if year_f==`i'
 }
areg ssaude inst1997b-inst2005b reg* if year_f>1994 & year_f<2007, rob a(uf)
 gen teb_s = 0 if year_f==1995
 forvalues i = 1997(2)2005 {
  replace teb_s = _b[inst`i'b] if year_f==`i'
 }
 forvalues i = 1996(2)2006 {
  replace teb_s = l.teb_s if year_f==`i'
 }
 areg ssaude inst1999e inst2003e reg* if year_f>1994 & year_f<2007, rob a(uf)
 gen teq_s = 0 if year_f==1995
 forvalues i = 1999(4)2003 {
  replace teq_s = _b[inst`i'e] if year_f==`i'
 }
 forvalues i = 1996(4)2004 {
  replace teq_s = l.teq_s if year_f==`i'
 }
 forvalues i = 1997(4)2005 {
  replace teq_s = l.teq_s if year_f==`i'
 }
 forvalues i = 1998(4)2006 {
  replace teq_s = l.teq_s if year_f==`i'
 }

 
 tsset cuf year_f
areg vis7_ined2 inst1996-inst2006 reg* ag_vis_ined_cover if year_f>1994 & year_f<2007, rob a(uf)
 gen te_v = 0 if year_f==1995
 forvalues i = 1996(1)2006 {
  replace te_v = _b[inst`i'] if year_f==`i'
 }
areg vis7_ined2 inst1997b-inst2005b reg* ag_vis_ined_cover if year_f>1994 & year_f<2007, rob a(uf)
 gen teb_v = 0 if year_f==1995
 forvalues i = 1997(2)2005 {
  replace teb_v = _b[inst`i'b] if year_f==`i'
 }
 forvalues i = 1996(2)2006 {
  replace teb_v = l.teb_v if year_f==`i'
 }
areg vis7_ined2 inst1999e inst2003e reg* ag_vis_ined_cover if year_f>1994 & year_f<2007, rob a(uf)
 gen teq_v = 0 if year_f==1995
 forvalues i = 1999(4)2003 {
  replace teq_v = _b[inst`i'e] if year_f==`i'
 }
 forvalues i = 1996(4)2004 {
  replace teq_v = l.teq_v if year_f==`i'
 }
 forvalues i = 1997(4)2005 {
  replace teq_v = l.teq_v if year_f==`i'
 }
 forvalues i = 1998(4)2006 {
  replace teq_v = l.teq_v if year_f==`i'
 }
 tsset cuf year_f
areg lb_ined  inst1996-inst2006 reg* ag_lb_ined_cover if year_f>1994 & year_f<2007, rob a(uf)
 gen te_b = 0 if year_f==1995
 forvalues i = 1996(1)2006 {
  replace te_b = _b[inst`i'] if year_f==`i'
 }
areg lb_ined  inst1997b-inst2005b reg* ag_lb_ined_cover if year_f>1994 & year_f<2007, rob a(uf)
 gen teb_b = 0 if year_f==1995
 forvalues i = 1997(2)2005 {
  replace teb_b = _b[inst`i'b] if year_f==`i'
 }
 forvalues i = 1996(2)2006 {
  replace teb_b = l.teb_b if year_f==`i'
 }
areg lb_ined  inst1999e inst2003e reg* ag_lb_ined_cover if year_f>1994 & year_f<2007, rob a(uf)
 gen teq_b = 0 if year_f==1995
 forvalues i = 1999(4)2003 {
  replace teq_b = _b[inst`i'e] if year_f==`i'
 }
 forvalues i = 1996(4)2004 {
  replace teq_b = l.teq_b if year_f==`i'
 }
 forvalues i = 1997(4)2005 {
  replace teq_b = l.teq_b if year_f==`i'
 }
 forvalues i = 1998(4)2006 {
  replace teq_b = l.teq_b if year_f==`i'
 }

foreach i in s v b { 
 egen temp_`i' = sum(te_`i'*delec2/108)
 replace te_`i' = te_`i' - temp_`i'
}
gen temp_y = (year_f==1995 | year_f==1996) 
foreach i in s v b { 
 egen temp2_`i' = sum(te_`i'*temp_y/52)
 replace teb_`i' = teb_`i' + temp2_`i'
} 

sort year_f
scatter te_s year_f if year_f>1994 & year_f<2007, connect(l) || line teb_s year_f if year_f>1994 & year_f<2007, connect(l) lcolor(gs8) || line teq_s year_f if year_f>1994 & year_f<2007, connect(l) xline(1998.5) xline(2002.5) legend(off) lcolor(gs10) xlab(1995(1)2006) xtitle("") lpattern(dash) ytitle("Coefficient on S")
 graph export yearly_s.eps, replace
scatter te_v year_f if year_f>1994 & year_f<2007, connect(l) || line teb_v year_f if year_f>1994 & year_f<2007, connect(l) lcolor(gs8) || line teq_v year_f if year_f>1994 & year_f<2007, connect(l) xline(1998.5) xline(2002.5) legend(off) lcolor(gs10) xlab(1995(1)2006) xtitle("") lpattern(dash) ytitle("Coefficient on S")
 graph export yearly_v.eps, replace
scatter te_b year_f if year_f>1994 & year_f<2007, connect(l) || line teb_b year_f if year_f>1994 & year_f<2007, connect(l) lcolor(gs8) || line teq_b year_f if year_f>1994 & year_f<2007, connect(l) xline(1998.5) xline(2002.5) legend(off) lcolor(gs10) xlab(1995(1)2006) xtitle("") lpattern(dash) ytitle("Coefficient on S")
 graph export yearly_b.eps, replace
