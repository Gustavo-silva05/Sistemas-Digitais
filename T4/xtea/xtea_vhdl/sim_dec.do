if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work xtea_dec.vhd
vcom -work work tb_dec.vhd

vsim -voptargs=+acc=lprn -t ns work.tb_dec

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave_dec.do

run 10000 ns