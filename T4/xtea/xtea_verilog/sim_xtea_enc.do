if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vcom -work work xtea_enc.v
vcom -work work xtea_enc_tb.v

vsim -voptargs=+acc=lprn -t ns work.xtea_enc_tb

set StdArithNoWarnings 1
set StdVitalGlitchNoWarnings 1



run 300 ns