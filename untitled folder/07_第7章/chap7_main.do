** ivreg2がインストールされていない場合，ssc install ivreg2として導入してください
** ranktestがインストールされていない場合，ssc install ranktestとして導入してください
** sutex2がインストールされていない場合，ssc install sutex2として導入してください
** eststoがインストールされていない場合，ssc install eststoとして導入してください
** esttabがインストールされていない場合，ssc install esttabとして導入してください


clear

** データを読み込む
use ipehd_qje2009_master.dta, clear
set more off

** ログファイル
log using "chap7_main", replace

** コントロール変数のグループを作る

global controls "f_young f_jew f_fem f_ortsgeb f_pruss hhsize lnpop gpop f_blind f_deaf f_dumb"

** 表 7.2 LaTex形式で出力

sutex2 f_rw f_prot kmwittenberg $controls f_miss, minmax

** 実証例7.1 (7.5)

eststo: reg f_rw f_prot, robust

** 実証例 7.1 (7.6) 実証例 7.2

eststo: ivreg2 f_rw (f_prot = kmwittenberg), robust

** 表 7.3 (3)

eststo: reg f_rw f_prot $controls f_miss, robust

** 実証例 7.3 

eststo: ivreg2 f_rw (f_prot = kmwittenberg) $controls f_miss , robust

** 実証例 7.5

predict uhat, residual
reg uhat kmwittenberg $controls f_miss
test (kmwittenberg)
drop uhat

** 実証例 7.4

eststo: reg f_prot kmwittenberg $controls f_miss, robust
 display(e(r2_a))

** 追加の操作変数を定義
 
gen klnpop = kmwittenberg*lnpop
gen kgpop = kmwittenberg*gpop
global crossiv "klnpop kgpop"

** 実証例 7.3

eststo: ivreg2 f_rw (f_prot = kmwittenberg $crossiv) $controls f_miss , robust

**実証例 7.5

predict uhat, residual
reg uhat kmwittenberg $crossiv $controls f_miss
test (kmwittenberg) ($crossiv)
 display(e(r2_a))
 
**実証例 7.4

reg f_prot kmwittenberg $crossiv $controls f_miss, robust
test (kmwittenberg) ($crossiv)
 display(e(r2_a))

**回帰分析表を，LaTex形式のファイルに出力
  esttab using tabchap7.tex, replace cells(b(star fmt(3)) se(par fmt(3))) stats(r2_a N, fmt(3 0) label("$\bar R^2$")) label                               ///
     title(Specification 1)       ///
     nonumbers mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)")  ///
    addnote("適切な注釈に変更すること")
 

** ログファイルを閉じる
log close


