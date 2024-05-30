onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/DUT/clk
add wave -noupdate -color Gold /tb/DUT/rst
add wave -noupdate -color {Medium Spring Green} /tb/DUT/configurar
add wave -noupdate -color {Blue Violet} /tb/DUT/valido
add wave -noupdate -radix decimal /tb/DUT/entrada
add wave -noupdate -color {Orange Red} /tb/DUT/tranca
add wave -noupdate -color {Blue Violet} /tb/DUT/configurado
add wave -noupdate -color {Blue Violet} /tb/DUT/alarme
add wave -noupdate -color Turquoise /tb/DUT/EA
add wave -noupdate -color Turquoise /tb/DUT/PE
add wave -noupdate -color {Orange Red} /tb/DUT/control
add wave -noupdate -color {Orange Red} /tb/DUT/vezes
add wave -noupdate -color {Orange Red} /tb/DUT/tentativas
add wave -noupdate -color {Orange Red} /tb/DUT/senha
add wave -noupdate /tb/DUT/alarme_lig
add wave -noupdate -color {Medium Blue} -radix decimal -radixshowbase 0 /tb/DUT/senha1
add wave -noupdate -color {Medium Blue} -radix decimal -radixshowbase 0 /tb/DUT/senha2
add wave -noupdate -color {Medium Blue} -radix decimal -radixshowbase 0 /tb/DUT/senha3
add wave -noupdate -color {Green Yellow} -radix decimal -radixshowbase 0 /tb/DUT/timer_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {361281 ns} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {360661 ns} {361565 ns}
