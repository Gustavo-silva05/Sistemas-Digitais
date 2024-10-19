onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_dcm/dcm/rst
add wave -noupdate -radix binary /tb_dcm/dcm/clk
add wave -noupdate -radix binary /tb_dcm/dcm/update
add wave -noupdate /tb_dcm/dcm/prog_in
add wave -noupdate /tb_dcm/dcm/prog_out
add wave -noupdate -radix binary /tb_dcm/dcm/clk_1
add wave -noupdate -radix binary /tb_dcm/dcm/clk_2
add wave -noupdate /tb_dcm/dcm/prog_o
add wave -noupdate -radix binary /tb_dcm/dcm/c_2
add wave -noupdate -radix decimal /tb_dcm/dcm/timers
add wave -noupdate -radix decimal /tb_dcm/dcm/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2575 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 152
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
WaveRestoreZoom {0 ns} {10500 ns}
