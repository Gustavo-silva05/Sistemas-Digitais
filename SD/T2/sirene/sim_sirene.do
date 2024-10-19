if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work gerador_sirene.v
vlog -work work tb_sirene.v

vsim -voptargs=+acc=lprn -t ns work.tb_sirene

do wave_sirene.do

run 5000 ns