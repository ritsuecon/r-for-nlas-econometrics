** piaac_jpn.dtaのデータを本章の分析用データpiaac.dtaに整形するためのスクリプトファイルです。

clear

** データを読み込む
use piaac_jpn.dta, clear
set more off

** ログファイル
log using "crpiaac", replace

rename AGE_R age
rename A_N01_T gender
rename yrsqual educ
rename B_Q01b field
rename C_D05 lfs

gen hours=.
replace hours=0 if lfs>=2&lfs<=3
replace hours=D_Q10 if lfs==1
rename C_Q07 empstat

gen empstat_edt=1 if empstat==1
replace empstat_edt=2 if empstat==2
replace empstat_edt=3 if empstat>=3&empstat<=10

label define empstat_edt 1 "full" 2 "part" 3 "not employed"
label values empstat_edt empstat_edt
rename D_Q14 js

gen couple=(J_Q02a==1)
replace couple=. if J_Q02a>=6&J_Q02a>=9

gen child=.
replace child=0 if J_Q03a==1
replace child=J_Q03b if J_Q03b~=.

label variable child "number of child"
rename pared peduc
rename earnhrbonus wage

egen lit_temp=rowmean(PVLIT1 PVLIT2 PVLIT3 PVLIT4 PVLIT5 PVLIT6 PVLIT7 PVLIT8 PVLIT9 PVLIT10)
egen lit=std(lit_temp)

drop lit_temp
egen num_temp=rowmean(PVNUM1 PVNUM2 PVNUM3 PVNUM4 PVNUM5 PVNUM6 PVNUM7 PVNUM8 PVNUM9 PVNUM10)

egen num=std(num_temp)
drop num_temp
egen ps_temp=rowmean(PVPSL1 PVPSL2 PVPSL2 PVPSL3 PVPSL4 PVPSL5 PVPSL6 PVPSL7 PVPSL8 PVPSL9 PVPSL10)
egen ps=std(ps_temp)
drop ps_temp
rename D_Q09 contract
keep age gender educ field lfs empstat_edt hours js couple child peduc wage lit num ps 

sum
save piaac, replace

log close


