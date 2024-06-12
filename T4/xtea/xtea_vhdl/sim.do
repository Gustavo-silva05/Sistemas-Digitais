if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work ENC/xtea_enc.vhd
vcom -work work DEC/xtea_dec.vhd
vcom -work work xtea_top.vhd
vcom -work work tb_top.vhd


vsim -voptargs=+acc=lprn -t ns work.tb_top

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1

do wave.do

run 130000 ns