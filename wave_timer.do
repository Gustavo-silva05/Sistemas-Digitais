onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb_Timer/clock
add wave -noupdate -radix decimal /tb_Timer/reset
add wave -noupdate -radix decimal /tb_Timer/value
add wave -noupdate -radix decimal /tb_Timer/start_timer
add wave -noupdate -radix decimal /tb_Timer/expired
add wave -noupdate -radix decimal /tb_Timer/one_hz_enable
add wave -noupdate -radix decimal /tb_Timer/temp/count
add wave -noupdate -radix decimal /tb_Timer/temp/timer_1sec
add wave -noupdate -radix decimal /tb_Timer/temp/expirou
add wave -noupdate -radix decimal /tb_Timer/temp/one_hz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {39298965 ns} 0}
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
WaveRestoreZoom {0 ns} {48300404 ns}
