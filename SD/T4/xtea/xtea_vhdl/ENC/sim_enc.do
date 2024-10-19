if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work xtea_enc.vhd
vcom -work work tb_enc.vhd

vsim -voptargs=+acc=lprn -t ns work.tb_enc

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave_enc.do

run 10000 ns