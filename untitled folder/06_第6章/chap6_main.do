** ivreg2がインストールされていない場合，ssc install ivreg2として導入してください
** sutex2がインストールされていない場合，ssc install sutex2として導入してください
** eststoがインストールされていない場合，ssc install eststoとして導入してください

clear

** データを読み込む
use "yamaguchi.dta", clear
set more off

** ログファイル
log using "chap6_main.log", replace

** prefecture id
encode pref, gen(pref1)

keep if hhtype == "all"

keep if year > 1999

xtset pref1 year

** 表 6.3 LaTex形式で出力

sutex2 emprate caprate age agehus empratehus urate, minmax

** (6.1)

reg emprate caprate, robust


** 実証例 6.1 6.2

eststo: reg emprate caprate i.pref1, vce(cluster pref1)
display e(r2_a)

** 実証例 6.3

eststo: reg emprate caprate, vce(cluster pref1)
display e(r2_a)

** 実証例 6.4

eststo: reg emprate caprate i.year, vce(cluster pref1)
display e(r2_a)

** 実証例 6.5

eststo: reg emprate caprate i.pref1 i.year, vce(cluster pref1)
display e(r2_a)

** 実証例 6.6

reg emprate caprate i.year i.pref1##c.year, vce(cluster pref1)
display e(r2_a)

** 表 6.5 (5) (6)

eststo: reg emprate caprate i.year age agehus empratehus urate, vce(cluster pref1)
eststo: reg emprate caprate i.year age agehus empratehus urate i.pref1, vce(cluster pref1)

**回帰分析表を，LaTex形式のファイルに出力
 esttab using tabchap6.tex, replace cells(b(star fmt(3)) se(par fmt(3))) stats(r2_a N, fmt(3 0) label("$\bar R^2$")) label                               ///
     title(Specification 1)       ///
     nonumbers mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)")  ///
    addnote("適切な注釈を入れること")

eststo clear

** ログファイルを閉じる
log close
