onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /tb_parametros/clock
add wave -noupdate -radix decimal /tb_parametros/reset
add wave -noupdate -radix binary /tb_parametros/interval
add wave -noupdate -radix decimal /tb_parametros/reprogram
add wave -noupdate -radix binary -childformat {{{/tb_parametros/time_param_sel[1]} -radix decimal} {{/tb_parametros/time_param_sel[0]} -radix decimal}} -subitemconfig {{/tb_parametros/time_param_sel[1]} {-height 15 -radix decimal} {/tb_parametros/time_param_sel[0]} {-height 15 -radix decimal}} /tb_parametros/time_param_sel
add wave -noupdate -radix decimal /tb_parametros/time_value
add wave -noupdate -radix decimal /tb_parametros/mux/T_ARM_DELAY
add wave -noupdate -radix decimal /tb_parametros/mux/T_DRIVER_DELAY
add wave -noupdate -radix decimal /tb_parametros/mux/T_PASSAGER_DELAY
add wave -noupdate -radix decimal /tb_parametros/mux/T_ALARM_ON
add wave -noupdate -radix decimal /tb_parametros/value
add wave -noupdate -radix decimal /tb_parametros/mux/valor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4 ns} 0}
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
WaveRestoreZoom {0 ns} {61 ns}
