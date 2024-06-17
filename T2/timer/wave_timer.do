onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_Timer/clock
add wave -noupdate -radix binary /tb_Timer/reset
add wave -noupdate -radix decimal /tb_Timer/value
add wave -noupdate -radix decimal /tb_Timer/start_timer
add wave -noupdate -radix decimal /tb_Timer/expired
add wave -noupdate -radix decimal /tb_Timer/one_hz_enable
add wave -noupdate -radix decimal -childformat {{{/tb_Timer/temp/count[4]} -radix decimal} {{/tb_Timer/temp/count[3]} -radix decimal} {{/tb_Timer/temp/count[2]} -radix decimal} {{/tb_Timer/temp/count[1]} -radix decimal} {{/tb_Timer/temp/count[0]} -radix decimal}} -subitemconfig {{/tb_Timer/temp/count[4]} {-height 15 -radix decimal} {/tb_Timer/temp/count[3]} {-height 15 -radix decimal} {/tb_Timer/temp/count[2]} {-height 15 -radix decimal} {/tb_Timer/temp/count[1]} {-height 15 -radix decimal} {/tb_Timer/temp/count[0]} {-height 15 -radix decimal}} /tb_Timer/temp/count
add wave -noupdate -radix decimal /tb_Timer/temp/expirou
add wave -noupdate -radix decimal /tb_Timer/temp/one_hz
add wave -noupdate /tb_Timer/temp/two_hz_enable
add wave -noupdate -radix decimal /tb_Timer/temp/timer_2sec
add wave -noupdate /tb_Timer/temp/two_hz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {245 ns} 0}
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
WaveRestoreZoom {0 ns} {6564 ns}
