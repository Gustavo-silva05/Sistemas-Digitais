if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work Timer.v
vlog -work work tb_Timer.v

vsim -voptargs=+acc=lprn -t ns work.tb_Timer

do wave_timer.do

run 100000 ns

