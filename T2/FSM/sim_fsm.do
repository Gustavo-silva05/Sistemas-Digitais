if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work FSM_antifurto.v
vlog -work work tb_fsm.v
vlog -work work gerador_sirene.v
vlog -work work logica_comb.v
vlog -work work Parametros_Tempo.v
vlog -work work Timer.v

vsim -voptargs=+acc=lprn -t ns work.tb_fsm

do wave.do

run 1000000 ns