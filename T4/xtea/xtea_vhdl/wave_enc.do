onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /xtea_enc_tb/clk
add wave -noupdate /xtea_enc_tb/reset
add wave -noupdate /xtea_enc_tb/start
add wave -noupdate /xtea_enc_tb/data_i
add wave -noupdate /xtea_enc_tb/key
add wave -noupdate /xtea_enc_tb/data_o
add wave -noupdate /xtea_enc_tb/clk
add wave -noupdate /xtea_enc_tb/reset
add wave -noupdate /xtea_enc_tb/start
add wave -noupdate /xtea_enc_tb/data_i
add wave -noupdate /xtea_enc_tb/key
add wave -noupdate /xtea_enc_tb/data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5386 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 88
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ns} {17773 ns}
