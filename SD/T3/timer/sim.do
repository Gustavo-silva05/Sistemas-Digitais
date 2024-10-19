if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work timer.v
vlog -work work tb_timer.v

vsim -voptargs=+acc=lprn -t ns work.tb_timer

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do

run 1000 ns