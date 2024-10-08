if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work timer.v
vlog -work work fibonacci.v
vlog -work work dcm_sintese.v
vlog -work work dm.v
vlog -work work wrapper.v
vlog -work work top_sintese.v
vlog -work work dspl_drv_NexysA7.v
vlog -work work edge_detector_sintese.v
vlog -work work tb.v

vsim -voptargs=+acc=lprn -t ns work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do

run 30000 ns
