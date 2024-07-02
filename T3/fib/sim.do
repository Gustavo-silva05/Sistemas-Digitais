if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work fibonacci.v
vlog -work work tb_fib.v

vsim -voptargs=+acc=lprn -t ns work.tb_fib

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do

run 1000 ns