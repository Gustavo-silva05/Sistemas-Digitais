onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /tb_sirene/alarme/clock
add wave -noupdate -radix binary /tb_sirene/alarme/reset
add wave -noupdate -radix binary /tb_sirene/alarme/eneble_siren
add wave -noupdate -radix binary /tb_sirene/alarme/two_hz_enable
add wave -noupdate -radix binary /tb_sirene/alarme/siren
add wave -noupdate -radix binary /tb_sirene/alarme/sirene
add wave -noupdate -radix binary /tb_sirene/alarme/cor
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {168 ns}
