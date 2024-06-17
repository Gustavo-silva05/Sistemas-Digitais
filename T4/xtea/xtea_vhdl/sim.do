if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work xtea_enc.vhd
vcom -work work xtea_dec.vhd
vcom -work work xtea_top.vhd
vcom -work work tb_top.vhd


vsim -voptargs=+acc=lprn -t ns work.tb_top

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1



run 10000 ns