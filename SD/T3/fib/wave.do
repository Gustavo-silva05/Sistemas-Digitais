onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_fib/fib/rst
add wave -noupdate -radix binary /tb_fib/fib/clk
add wave -noupdate -radix binary /tb_fib/fib/f_en
add wave -noupdate -radix binary /tb_fib/fib/f_valid
add wave -noupdate -radix decimal /tb_fib/fib/f_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {298 ns} 0}
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
WaveRestoreZoom {6 ns} {418 ns}
