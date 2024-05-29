`timescale 1ns / 1ps 

module tb_Timer;
reg clock;
reg reset;
reg [4:0] value;
reg start_timer;
wire expired;
wire one_hz_enable;

Timer temp(
    .reset (reset),
    .clock (clock),
    .value(value),
    .start_timer(start_timer),
    .expired(expired),
    .one_hz_enable(one_hz_enable)
);

localparam PERIOD = 10;
always #(PERIOD/2) clock=~clock;

initial begin
    clock <= 1'b0;
    reset <= 1'b1;
    #PERIOD;
    reset <= 1'b0;
    value <= 5'b01010;
    start_timer <= 1'b1;
    #PERIOD;
    start_timer <= 1'b0;

end

endmodule
