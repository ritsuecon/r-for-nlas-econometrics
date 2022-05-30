
import excel leaveout_table.xlsx, sheet("leaveout") cellrange(B1:R28) firstrow clear
 
 encode uf, gen(cuf)
scatter b_u cuf, xlabel(1(1)27, labsize(small)valuelabel)  || rcap chi_u clow_u cuf, legend(off) xtitle("") ysc(r(0)) ylabel(#5) lcolor(navy) yline(.102)
 graph export leaveout_u.eps, replace
scatter b_s cuf, xlabel(1(1)27, labsize(small)valuelabel)  || rcap chi_s clow_s cuf, legend(off) xtitle("") ysc(r(0)) ylabel(#5) lcolor(navy) yline(.034)
 graph export leaveout_s.eps, replace
scatter b_v cuf, xlabel(1(1)27, labsize(small)valuelabel)  || rcap chi_v clow_v cuf, legend(off) xtitle("") ysc(r(0)) ylabel(#5) lcolor(navy) yline(.069)
 graph export leaveout_v.eps, replace
scatter b_b cuf, xlabel(1(1)27, labsize(small)valuelabel)  || rcap chi_b clow_b cuf, legend(off) xtitle("") ysc(r(0)) ylabel(#5) lcolor(navy) yline(-.00529)
 graph export leaveout_b.eps, replace

