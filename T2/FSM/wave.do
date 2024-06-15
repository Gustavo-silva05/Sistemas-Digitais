onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fsm/FSM/ignition
add wave -noupdate /tb_fsm/FSM/door_driver
add wave -noupdate /tb_fsm/FSM/door_pass
add wave -noupdate /tb_fsm/FSM/reprogram
add wave -noupdate /tb_fsm/FSM/clock
add wave -noupdate /tb_fsm/FSM/reset
add wave -noupdate /tb_fsm/FSM/expired
add wave -noupdate /tb_fsm/FSM/one_hz_enable
add wave -noupdate /tb_fsm/FSM/interval
add wave -noupdate /tb_fsm/FSM/status
add wave -noupdate /tb_fsm/FSM/start_timer
add wave -noupdate /tb_fsm/FSM/eneble_siren
add wave -noupdate /tb_fsm/FSM/estado
add wave -noupdate /tb_fsm/FSM/intervalo
add wave -noupdate /tb_fsm/FSM/start
add wave -noupdate /tb_fsm/FSM/enable
add wave -noupdate /tb_fsm/FSM/stats
add wave -noupdate /tb_fsm/FSM/EA
add wave -noupdate /tb_fsm/FSM/PE
add wave -noupdate /tb_fsm/parametros/time_param_sel
add wave -noupdate /tb_fsm/parametros/interval
add wave -noupdate /tb_fsm/parametros/time_value
add wave -noupdate /tb_fsm/parametros/reprogram
add wave -noupdate /tb_fsm/parametros/clock
add wave -noupdate /tb_fsm/parametros/reset
add wave -noupdate /tb_fsm/parametros/value
add wave -noupdate /tb_fsm/parametros/T_ARM_DELAY
add wave -noupdate /tb_fsm/parametros/T_DRIVER_DELAY
add wave -noupdate /tb_fsm/parametros/T_PASSAGER_DELAY
add wave -noupdate /tb_fsm/parametros/T_ALARM_ON
add wave -noupdate /tb_fsm/parametros/valor
add wave -noupdate /tb_fsm/relogio/clock
add wave -noupdate /tb_fsm/relogio/reset
add wave -noupdate /tb_fsm/relogio/value
add wave -noupdate /tb_fsm/relogio/start_timer
add wave -noupdate /tb_fsm/relogio/expired
add wave -noupdate /tb_fsm/relogio/one_hz_enable
add wave -noupdate /tb_fsm/relogio/two_hz_enable
add wave -noupdate /tb_fsm/relogio/counter
add wave -noupdate /tb_fsm/relogio/count
add wave -noupdate /tb_fsm/relogio/timer_2sec
add wave -noupdate /tb_fsm/relogio/expirou
add wave -noupdate /tb_fsm/relogio/one_hz
add wave -noupdate /tb_fsm/relogio/two_hz
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {112 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 127
configure wave -valuecolwidth 137
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
WaveRestoreZoom {0 ns} {206 ns}
