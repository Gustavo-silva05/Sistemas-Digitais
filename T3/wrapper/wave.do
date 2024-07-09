onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_w/w/rst
add wave -noupdate -radix binary /tb_w/w/clk_1
add wave -noupdate -radix binary /tb_w/w/clk_2
add wave -noupdate -radix binary /tb_w/w/data_1_en
add wave -noupdate -radix decimal /tb_w/w/data_1
add wave -noupdate -radix binary /tb_w/w/buffer_empty
add wave -noupdate -radix binary /tb_w/w/buffer_full
add wave -noupdate -radix binary /tb_w/w/data_2_valid
add wave -noupdate -radix decimal /tb_w/w/data_2
add wave -noupdate -radix decimal /tb_w/w/b_reader
add wave -noupdate -radix decimal /tb_w/w/b_writer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {190 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {1050 ns}
