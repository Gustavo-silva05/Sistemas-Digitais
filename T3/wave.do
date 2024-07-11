onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 25 TOP
add wave -noupdate -radix binary /tb/DUT/rst
add wave -noupdate -radix binary /tb/DUT/clk
add wave -noupdate -radix binary /tb/DUT/start_f
add wave -noupdate -radix binary /tb/DUT/start_t
add wave -noupdate -radix binary /tb/DUT/stop_f_t
add wave -noupdate -radix binary /tb/DUT/update
add wave -noupdate -radix decimal /tb/DUT/prog
add wave -noupdate -radix decimal /tb/DUT/led
add wave -noupdate -radix decimal /tb/DUT/an
add wave -noupdate -radix decimal /tb/DUT/dec_ddp
add wave -noupdate -radix binary /tb/DUT/parity
add wave -noupdate -radix binary /tb/DUT/EA
add wave -noupdate -radix binary /tb/DUT/PE
add wave -noupdate -divider -height 25 DCM
add wave -noupdate -radix binary /tb/DUT/dcm/clk_2
add wave -noupdate -divider -height 25 TIMER
add wave -noupdate -radix binary /tb/DUT/t/t_en
add wave -noupdate -radix binary /tb/DUT/t/t_valid
add wave -noupdate -radix decimal /tb/DUT/t/t_out
add wave -noupdate -divider -height 25 FIB
add wave -noupdate -radix binary /tb/DUT/fib/f_en
add wave -noupdate -radix binary /tb/DUT/fib/f_valid
add wave -noupdate -radix decimal /tb/DUT/fib/f_out
add wave -noupdate -divider -height 25 WRAPPER
add wave -noupdate -radix binary /tb/DUT/w/rst
add wave -noupdate -radix binary /tb/DUT/w/clk_1
add wave -noupdate -radix binary /tb/DUT/w/clk_2
add wave -noupdate -radix binary /tb/DUT/w/data_1_en
add wave -noupdate -radix decimal /tb/DUT/w/data_1
add wave -noupdate -radix binary /tb/DUT/w/buffer_empty
add wave -noupdate -radix binary /tb/DUT/w/buffer_full
add wave -noupdate -radix binary /tb/DUT/w/data_2_valid
add wave -noupdate -radix decimal /tb/DUT/w/data_2
add wave -noupdate -radix binary /tb/DUT/w/b_reader
add wave -noupdate -radix binary /tb/DUT/w/b_writer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2335 ns} 0}
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
WaveRestoreZoom {0 ns} {21 us}
