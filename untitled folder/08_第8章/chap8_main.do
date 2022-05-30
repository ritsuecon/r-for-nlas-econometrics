** outregがインストールされていない場合，ssc install outregとして導入してください

clear

** データを読み込む
use piaac.dta, clear
set more off

** ログファイル
log using "chap8_main", replace

sum

*employment equation for female
keep if gender == 2
gen emp=(lfs==1)
sum

reg emp educ age couple child, robust
outreg using emp_lp, bdec(3) tdec(3) se starlevels(10 5 1) replace

probit emp educ age couple child
outreg using emp_nl, bdec(3) tdec(3) se starlevels(10 5 1) replace
margins, dydx(educ age couple child)

outreg using emp_nl, stat(b_dfdx se_dfdx) bdec(3) tdec(3) starlevels(10 5 1) merge

logit emp educ age couple child
outreg using emp_nl, bdec(3) tdec(3) starlevels(10 5 1) merge
margins, dydx(educ age couple child)

outreg using emp_nl, stat(b_dfdx se_dfdx) bdec(3) tdec(3) starlevels(10 5 1) merge

*job satisfaction
clear
use piaac.dta, clear

keep  if gender == 1
gen jsrev=6-js
label define jsrev 1 "Extremely dissatisfied" 2 "Dissatisfied" 3 "Neither satisfied nor dissatisfied" 4 "Satisfied" 5 "Extremely satisfied"
label values jsrev jsrev

keep if jsrev~=.&educ~=.&age~=.&couple~=.&child~=.
sum
tab jsrev

oprobit jsrev educ age couple child
outreg using js_ml, bdec(3) tdec(3) se starlevels(10 5 1) replace
margins, dydx(educ age couple child)

outreg using js_marginal, stat(b_dfdx se_dfdx) bdec(6) tdec(6) starlevels(10 5 1) replace

*employment type selection by females
clear
use piaac.dta, clear

keep if gender == 2
keep if empstat_edt~=.&educ~=.&age~=.&couple~=.&child~=.

sum
tab empstat_edt

mlogit empstat_edt educ age couple child, baseoutcome(3)
outreg using emptype, bdec(3) tdec(3) se starlevels(10 5 1) replace

margins, dydx(educ age couple child)
outreg using emptype, stat(b_dfdx se_dfdx) bdec(3) tdec(3) starlevels(10 5 1) merge

*hours choice by females
clear
use piaac.dta, clear

keep if gender == 2
sum
reg hours educ age couple child
outreg using hour_l, bdec(3) tdec(3) se starlevels(10 5 1) replace

tobit hours educ age couple child, ll(0)
outreg using hour_nl, bdec(3) tdec(3) se starlevels(10 5 1) replace

*sample selection correction for female wage equation
clear
use piaac.dta, clear

keep if gender == 2
gen lwage=ln(wage)
gen exp=age-educ-6
gen exp2=exp^2/100

keep if educ~=.&age~=.&couple~=.&child~=.
sum

reg lwage educ exp exp2
outreg using heckit_l, bdec(3) tdec(3) se starlevels(10 5 1) replace

heckman lwage educ exp exp2, select(educ exp exp2 couple child) twostep
outreg using heckit_nl, bdec(3) tdec(3) se starlevels(10 5 1) replace

heckman lwage educ exp exp2, select(educ exp exp2 couple child)
outreg using heckit_nl, bdec(3) tdec(3) se starlevels(10 5 1) merge

log close
