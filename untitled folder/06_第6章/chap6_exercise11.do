clear

** データを開く
use "timss.dta", clear
set more off

** ログファイル
log using "chap6_exercise11.log", replace

** (1)

reg mathscore agese_q2 agese_q3 agese_q4, cluster(idschool)

** (2)

reg mathscore agese_q2 agese_q3 agese_q4 i.idschool, cluster(idschool)

** (3)

reg mathscore agese_q2 agese_q3 agese_q4 comu_* computer numpeople mothereduc_* fathereduc_*, cluster(idschool)

** (4)

reg mathscore agese_q2 agese_q3 agese_q4 comu_* computer numpeople mothereduc_* fathereduc_* i.idschool, cluster(idschool)

** ログファイルを閉じる
log close


