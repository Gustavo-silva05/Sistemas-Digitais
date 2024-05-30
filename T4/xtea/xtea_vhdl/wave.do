onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_enc/encriptador/clk
add wave -noupdate /tb_enc/encriptador/reset
add wave -noupdate /tb_enc/encriptador/start
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/data_i
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/key
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/data_o
add wave -noupdate /tb_enc/encriptador/EA
add wave -noupdate /tb_enc/encriptador/PE
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/data_temp
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/sum
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/delta
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/temp
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/temp2
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/temp3
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/temp4
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/temp5
add wave -noupdate -radix hexadecimal /tb_enc/encriptador/temp6
add wave -noupdate -radix binary /tb_enc/encriptador/index_key
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {282 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 296
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
WaveRestoreZoom {243 ns} {304 ns}
