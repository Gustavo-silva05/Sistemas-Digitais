onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_top/encriptador/start
add wave -noupdate -radix binary /tb_top/encriptador/clk
add wave -noupdate -radix binary /tb_top/encriptador/reset
add wave -noupdate -radix binary /tb_top/encriptador/config
add wave -noupdate -radix hexadecimal /tb_top/encriptador/data_i
add wave -noupdate -radix hexadecimal /tb_top/encriptador/key
add wave -noupdate -radix binary /tb_top/encriptador/busy
add wave -noupdate -radix binary /tb_top/encriptador/ready
add wave -noupdate -radix hexadecimal /tb_top/encriptador/data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10676 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 206
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
WaveRestoreZoom {0 ns} {136500 ns}
