if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work logica_comb.v
vlog -work work tb_comb.v

vsim -voptargs=+acc=lprn -t ns work.tb_comb



run 100 ns