if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work tranca.vhd
vcom -work work tb.vhd

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do

run 1000000 ns
