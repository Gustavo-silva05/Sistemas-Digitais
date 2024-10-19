if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work Parametros_Tempo.v
vlog -work work tb_parametros.v

vsim -voptargs=+acc=lprn -t ns work.tb_parametros

do wave_param.do

run 1000 ns