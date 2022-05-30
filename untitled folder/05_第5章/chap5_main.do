** sutex2がインストールされていない場合，ssc install sutex2として導入してください
** eststoがインストールされていない場合，ssc install eststoとして導入してください
** esttabがインストールされていない場合，ssc install esttabとして導入してください

clear


** データセットを読み込む
use "youdou.dta", clear
set more off

** ログファイル
log using "chap5_main.log", replace

** 変数作成

gen lny80=log(y80)

gen lny99=log(y99)

gen lny90=log(y90)

gen growthrate8099=(lny99-lny80)/19

gen growthrate8090=(lny90-lny80)/10

replace growthrate8099 = growthrate8099*100

** 表5.5　LaTex形式で出力

sutex2 growthrate8099 trust80 norm80 education80 lny80, minmax

** 単回帰 (5.1) (5.2)**

reg growthrate8099 trust80, robust
 display(e(r2_a))
 
reg growthrate8099 norm80, robust
 display(e(r2_a))

correlate trust80 lny80 
 
** 重回帰 実証例5.1 5.4 **
 
 reg growthrate8099 lny80 education80 norm80, robust
 display(e(r2_a))
test lny80 norm80 education80 
 
reg growthrate8099 lny80 education80 trust80, robust
 display(e(r2_a))

** FWL 実証例5.2 5.3 **

reg trust80 lny80 education80, robust 
 display(e(r2_a))
	predict trusthat 
	generate trusttilde = trust80 - trusthat 
	reg growthrate8099 trusttilde, noconstant robust
 display(e(r2_a))
 
reg growthrate8099 lny80 education80, robust 
 display(e(r2_a))
	predict ghat 
	generate gtilde = growthrate8099 - ghat 
	reg gtilde trusttilde, noconstant robust
 display(e(r2_a))

	
** 多項式モデル 実証例5.5 5.8**

gen y80q = y80^2

reg growthrate8099 y80 y80q, robust	
 display(e(r2_a))
test (y80) (y80q)
scatter growthrate8099 y80 || qfit growthrate8099 y80	
graph export chap4qreg.pdf, replace

** 交互作用モデル 例題 5.5

reg growthrate8099 c.education80##c.lny80, robust
 display(e(r2_a))

** 交互作用モデル 実証例5.6
gen urban = did > 0.4
reg growthrate8099 i.urban##c.lny80, robust	
 display(e(r2_a))
reg growthrate8099 lny80 if urban ==0, robust	
 display(e(r2_a))
reg growthrate8099 lny80 if urban ==1, robust	
 display(e(r2_a))

** 交互作用モデル 実証例5.7

gen lny80d = lny80 > 1.4
reg growthrate8099 i.urban##i.lny80d, robust
 display(e(r2_a))

** 表5.6 **
 
eststo: reg growthrate8099 trust80, robust
 display(e(r2_a))
 
eststo: reg growthrate8099 norm80, robust
 display(e(r2_a))

  
eststo: reg growthrate8099 trust80 norm80, robust
test trust80 norm80
estadd scalar f1 = r(F)
estadd scalar p1 = r(p)
 display(e(r2_a))


eststo: reg growthrate8099 lny80 education80 trust80, robust
 display(e(r2_a))

eststo: reg growthrate8099 lny80 education80 norm80, robust
 display(e(r2_a))
 
eststo: reg growthrate8099 lny80 education80 trust80 norm80, robust
test trust80 norm80
estadd scalar f1 = r(F)
estadd scalar p1 = r(p)
 display(e(r2_a))

**回帰分析表を，LaTex形式のファイルに出力
 esttab using tabchap4.tex, replace cells(b(star fmt(3)) se(par fmt(3))) stats(f1 p1 r2_a N, fmt(3 3 3 0) label("F" "p" "$\bar R^2$")) label                               ///
     title(Specification 1)       ///
     nonumbers mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)")  ///
    addnote("適切な注釈を入れること")


** ログファイルを閉じる
log close
