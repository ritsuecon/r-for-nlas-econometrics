clear

** データを開く
use "timss.dta", clear
set more off

** ログファイル
log using "chap5_exercise15.log", replace

** (a)

reg mathscore agese_q2 agese_q3 agese_q4, robust

** (c)

reg mathscore i.agese_*##i.gender, robust
testparm agese_*#i.gender

** (d)

reg mathscore agese_q2 agese_q3 agese_q4 comu_* computer numpeople mothereduc_* fathereduc_*, robust

** (e)

reg sciencescore agese_q2 agese_q3 agese_q4, robust

reg sciencescore i.agese_*##i.gender, robust
testparm agese_*#i.gender

reg sciencescore agese_q2 agese_q3 agese_q4 comu_* computer numpeople mothereduc_* fathereduc_*, robust

** ログファイルを閉じる
log close


clear

** データを開く
use "timss.dta", clear
set more off

** ログファイル
log using "chap5_exercise15.log", replace

** (a)

reg mathscore agese_q2 agese_q3 agese_q4, robust

** (c)

reg mathscore i.agese_*##i.gender, robust
testparm agese_*#i.gender

** (d)

reg mathscore agese_q2 agese_q3 agese_q4 comu_* computer  numpeople mothereduc_* fathereduc_*, robust

** (e)

reg sciencescore agese_q2 agese_q3 agese_q4, robust

reg sciencescore i.agese_*##i.gender, robust
testparm agese_*#i.gender

reg sciencescore agese_q2 agese_q3 agese_q4 comu_* computer numpeople mothereduc_* fathereduc_*, robust

** ログファイルを閉じる
log close


