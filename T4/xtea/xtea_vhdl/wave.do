onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/encriptador/start
add wave -noupdate /tb_top/encriptador/clk
add wave -noupdate /tb_top/encriptador/reset
add wave -noupdate /tb_top/encriptador/config
add wave -noupdate -radix hexadecimal /tb_top/encriptador/data_i
add wave -noupdate -radix hexadecimal /tb_top/encriptador/key
add wave -noupdate /tb_top/encriptador/busy
add wave -noupdate /tb_top/encriptador/ready
add wave -noupdate -radix hexadecimal /tb_top/encriptador/data_o
add wave -noupdate /tb_top/encriptador/encrip/config
add wave -noupdate /tb_top/encriptador/encrip/EA
add wave -noupdate /tb_top/encriptador/encrip/PE
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/data_temp
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/sum
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/delta
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/temp
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/temp2
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/temp3
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/temp4
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/temp5
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/data_encriptada
add wave -noupdate /tb_top/encriptador/encrip/index_key
add wave -noupdate -radix hexadecimal /tb_top/encriptador/encrip/counter
add wave -noupdate /tb_top/encriptador/encrip/op
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12655 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 234
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
WaveRestoreZoom {0 ns} {15750 ns}
