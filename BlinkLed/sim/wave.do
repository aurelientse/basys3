onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 25 /BlinkLed_tb/BlinkLed_Inst0/rst_n
add wave -noupdate -height 25 /BlinkLed_tb/BlinkLed_Inst0/clk_sys
add wave -noupdate -height 25 /BlinkLed_tb/BlinkLed_Inst0/ClockGen_inst0/i
add wave -noupdate -height 25 /BlinkLed_tb/BlinkLed_Inst0/clk_1H
add wave -noupdate -height 25 /BlinkLed_tb/BlinkLed_Inst0/Led
add wave -noupdate -height 25 /BlinkLed_tb/BlinkLed_Inst0/led_on
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {57434 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 374
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {3490432 ps}
