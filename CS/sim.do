if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work debounce.vhd
vcom -work work counters_converter.vhd
vcom -work work time_counters.vhd
vcom -work work dspl_drv_NexysA7.vhd
vcom -work work clock_divider.vhd
vcom -work work fsm.vhd
vcom -work work top_tb.vhd
vcom -work work tb.vhd


vsim -voptargs=+acc=lprn -t ns work.tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do

run 1300000 ns