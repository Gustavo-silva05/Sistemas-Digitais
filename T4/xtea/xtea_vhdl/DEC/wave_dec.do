onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dec/encriptador/clk
add wave -noupdate /tb_dec/encriptador/reset
add wave -noupdate /tb_dec/encriptador/start
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/data_i
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/key
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/data_o
add wave -noupdate /tb_dec/encriptador/EA
add wave -noupdate /tb_dec/encriptador/PE
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/data_temp
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/sum
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/delta
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/temp
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/temp2
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/temp3
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/temp4
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/temp5
add wave -noupdate -radix hexadecimal /tb_dec/encriptador/data_encriptada
add wave -noupdate -radix binary /tb_dec/encriptador/index_key
add wave -noupdate -radix decimal /tb_dec/encriptador/counter
add wave -noupdate -radix decimal /tb_dec/encriptador/op
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9984 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 211
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {10500 ns}
