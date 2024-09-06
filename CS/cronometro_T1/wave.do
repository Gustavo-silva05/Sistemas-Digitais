onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clock
add wave -noupdate /tb/reset
add wave -noupdate /tb/stop
add wave -noupdate /tb/split
add wave -noupdate /tb/start
add wave -noupdate /tb/an
add wave -noupdate /tb/dec_ddp
add wave -noupdate -divider -height 20 CONTADOR
add wave -noupdate /tb/DUT/time_counters_inst/clock1cs
add wave -noupdate /tb/DUT/time_counters_inst/reset
add wave -noupdate /tb/DUT/time_counters_inst/enable
add wave -noupdate /tb/DUT/time_counters_inst/do_split
add wave -noupdate -radix decimal /tb/DUT/time_counters_inst/centsec
add wave -noupdate -radix decimal /tb/DUT/time_counters_inst/second
add wave -noupdate -radix decimal /tb/DUT/time_counters_inst/minute
add wave -noupdate -radix decimal -childformat {{/tb/DUT/time_counters_inst/hour(7) -radix decimal} {/tb/DUT/time_counters_inst/hour(6) -radix decimal} {/tb/DUT/time_counters_inst/hour(5) -radix decimal} {/tb/DUT/time_counters_inst/hour(4) -radix decimal} {/tb/DUT/time_counters_inst/hour(3) -radix decimal} {/tb/DUT/time_counters_inst/hour(2) -radix decimal} {/tb/DUT/time_counters_inst/hour(1) -radix decimal} {/tb/DUT/time_counters_inst/hour(0) -radix decimal}} -subitemconfig {/tb/DUT/time_counters_inst/hour(7) {-height 15 -radix decimal} /tb/DUT/time_counters_inst/hour(6) {-height 15 -radix decimal} /tb/DUT/time_counters_inst/hour(5) {-height 15 -radix decimal} /tb/DUT/time_counters_inst/hour(4) {-height 15 -radix decimal} /tb/DUT/time_counters_inst/hour(3) {-height 15 -radix decimal} /tb/DUT/time_counters_inst/hour(2) {-height 15 -radix decimal} /tb/DUT/time_counters_inst/hour(1) {-height 15 -radix decimal} /tb/DUT/time_counters_inst/hour(0) {-height 15 -radix decimal}} /tb/DUT/time_counters_inst/hour
add wave -noupdate /tb/DUT/time_counters_inst/centsec_sig
add wave -noupdate /tb/DUT/time_counters_inst/second_sig
add wave -noupdate /tb/DUT/time_counters_inst/minute_sig
add wave -noupdate /tb/DUT/time_counters_inst/hour_sig
add wave -noupdate -divider -height 20 {DB - STOP}
add wave -noupdate /tb/DUT/debounce_stop/clk_i
add wave -noupdate /tb/DUT/debounce_stop/rstn_i
add wave -noupdate /tb/DUT/debounce_stop/key_i
add wave -noupdate /tb/DUT/debounce_stop/debkey_o
add wave -noupdate /tb/DUT/debounce_stop/state
add wave -noupdate /tb/DUT/debounce_stop/nextstate
add wave -noupdate /tb/DUT/debounce_stop/intclock
add wave -noupdate /tb/DUT/debounce_stop/clockdiv
add wave -noupdate -divider -height 20 {DB - SPLIT}
add wave -noupdate /tb/DUT/debounce_split/key_i
add wave -noupdate /tb/DUT/debounce_split/debkey_o
add wave -noupdate -divider -height 20 {DB - RESET}
add wave -noupdate -divider -height 20 {DB - START}
add wave -noupdate /tb/DUT/debounce_start/key_i
add wave -noupdate /tb/DUT/debounce_start/debkey_o
add wave -noupdate -divider -height 20 {CLOCK - DIV}
add wave -noupdate /tb/DUT/clock_div_inst/clock
add wave -noupdate /tb/DUT/clock_div_inst/reset
add wave -noupdate /tb/DUT/clock_div_inst/clock1cs
add wave -noupdate /tb/DUT/clock_div_inst/out_250ms
add wave -noupdate -divider -height 20 FSM
add wave -noupdate /tb/DUT/fsm_inst/clock
add wave -noupdate /tb/DUT/fsm_inst/reset
add wave -noupdate /tb/DUT/fsm_inst/start
add wave -noupdate /tb/DUT/fsm_inst/stop
add wave -noupdate /tb/DUT/fsm_inst/split
add wave -noupdate /tb/DUT/fsm_inst/enable
add wave -noupdate /tb/DUT/fsm_inst/do_split
add wave -noupdate /tb/DUT/fsm_inst/fsm_state
add wave -noupdate /tb/DUT/fsm_inst/EA
add wave -noupdate /tb/DUT/fsm_inst/PE
add wave -noupdate -divider -height 20 DISPLAY
add wave -noupdate /tb/DUT/dspl_drv_inst/d8
add wave -noupdate /tb/DUT/dspl_drv_inst/d7
add wave -noupdate /tb/DUT/dspl_drv_inst/d6
add wave -noupdate /tb/DUT/dspl_drv_inst/d5
add wave -noupdate /tb/DUT/dspl_drv_inst/d4
add wave -noupdate /tb/DUT/dspl_drv_inst/d3
add wave -noupdate /tb/DUT/dspl_drv_inst/d2
add wave -noupdate /tb/DUT/dspl_drv_inst/d1
add wave -noupdate /tb/DUT/dspl_drv_inst/an
add wave -noupdate /tb/DUT/dspl_drv_inst/dec_ddp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {687118 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 98
configure wave -valuecolwidth 73
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
WaveRestoreZoom {0 ns} {1365 us}
