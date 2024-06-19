onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider -height 30 FSM
add wave -noupdate -radix binary /tb_fsm/FSM/clock
add wave -noupdate -radix binary /tb_fsm/FSM/reset
add wave -noupdate -radix binary /tb_fsm/FSM/reprogram
add wave -noupdate -radix binary /tb_fsm/FSM/ignition
add wave -noupdate -radix binary /tb_fsm/FSM/door_driver
add wave -noupdate -radix binary /tb_fsm/FSM/expired
add wave -noupdate -radix binary /tb_fsm/FSM/one_hz_enable
add wave -noupdate -radix binary /tb_fsm/FSM/interval
add wave -noupdate -radix binary /tb_fsm/FSM/status
add wave -noupdate -radix binary /tb_fsm/FSM/start_timer
add wave -noupdate -radix binary /tb_fsm/FSM/enable_siren
add wave -noupdate -radix binary /tb_fsm/FSM/estado
add wave -noupdate -radix binary /tb_fsm/FSM/EA
add wave -noupdate -radix binary /tb_fsm/FSM/PE
add wave -noupdate -divider -height 30 PARAMENTROS
add wave -noupdate -radix binary /tb_fsm/parametros/time_param_sel
add wave -noupdate -radix binary /tb_fsm/parametros/interval
add wave -noupdate -radix binary /tb_fsm/parametros/time_value
add wave -noupdate -radix binary /tb_fsm/parametros/reprogram
add wave -noupdate -radix binary /tb_fsm/parametros/clock
add wave -noupdate -radix binary /tb_fsm/parametros/reset
add wave -noupdate -radix binary /tb_fsm/parametros/value
add wave -noupdate -radix binary /tb_fsm/parametros/T_ARM_DELAY
add wave -noupdate -radix binary /tb_fsm/parametros/T_DRIVER_DELAY
add wave -noupdate -radix binary /tb_fsm/parametros/T_PASSAGER_DELAY
add wave -noupdate -radix binary /tb_fsm/parametros/T_ALARM_ON
add wave -noupdate -radix binary /tb_fsm/parametros/valor
add wave -noupdate -divider -height 30 TIMER
add wave -noupdate -radix binary /tb_fsm/relogio/clock
add wave -noupdate -radix binary /tb_fsm/relogio/reset
add wave -noupdate -radix binary /tb_fsm/relogio/value
add wave -noupdate -radix binary /tb_fsm/relogio/start_timer
add wave -noupdate -radix binary /tb_fsm/relogio/expired
add wave -noupdate -radix binary /tb_fsm/relogio/one_hz_enable
add wave -noupdate -radix binary /tb_fsm/relogio/two_hz_enable
add wave -noupdate -radix binary /tb_fsm/relogio/counter
add wave -noupdate -radix binary /tb_fsm/relogio/timer_2sec
add wave -noupdate -divider -height 30 combustivel
add wave -noupdate -radix binary /tb_fsm/combustivel/clock
add wave -noupdate -radix binary /tb_fsm/combustivel/reset
add wave -noupdate -radix binary /tb_fsm/combustivel/break
add wave -noupdate -radix binary /tb_fsm/combustivel/hidden_sw
add wave -noupdate -radix binary /tb_fsm/combustivel/ignition
add wave -noupdate -radix binary /tb_fsm/combustivel/fuel_pump
add wave -noupdate -divider -height 30 SIRENE
add wave -noupdate -radix binary /tb_fsm/sirene/clock
add wave -noupdate -radix binary /tb_fsm/sirene/reset
add wave -noupdate -radix binary /tb_fsm/sirene/enable_siren
add wave -noupdate -radix binary /tb_fsm/sirene/two_hz_enable
add wave -noupdate -radix binary /tb_fsm/sirene/siren
add wave -noupdate -radix binary /tb_fsm/sirene/EA
add wave -noupdate -radix binary /tb_fsm/sirene/PE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {300 ns} 0}
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
WaveRestoreZoom {0 ns} {1 us}
