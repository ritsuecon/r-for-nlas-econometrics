clear

** データを開く
import delimited "chap4_wage.csv", delimiter(comma), clear
set more off

** 実証例4.1
reg wage productivity, robust
