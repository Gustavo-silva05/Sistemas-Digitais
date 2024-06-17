`timescale 1ns/1ps

module tb_parametros;
reg [1:0] time_param_sel;
reg [1:0] interval;
reg [3:0] time_value;
reg reprogram;
reg clock;
reg reset;
wire [4:0] value;

Parametros_Tempo mux (
    .time_param_sel(time_param_sel), 
    .interval(interval),
    .time_value(time_value),
    .reprogram(reprogram), 
    .clock(clock), 
    .reset(reset),
    .value(value)
);

localparam PERIOD = 10;
always #(PERIOD/2) clock=~clock;

initial begin
    clock <= 1'b0;
    reset <= 1'b1;
    #PERIOD;
    reset <= 1'b0;
    interval <= 2'b11;
    repeat(10) begin
        #PERIOD;
    end
    reprogram <= 1'b1;
    time_param_sel <= 2'b01;
    time_value <= 5'b00101;
    #PERIOD;
    reprogram <= 1'b0;
    interval <= 2'b01; 
    repeat (10) begin
        #PERIOD;
    end
    reset <= 1'b1;
    #PERIOD;
    reset <= 1'b0;
end




endmodule