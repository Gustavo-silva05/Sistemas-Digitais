`timescale 1ns / 1ps

module top(
    input clock,
    input reset,
    input break, 
    input hidden_sw, 
    input ignition,
    input door_driver,
    input door_pass,
    input reprogram,
    input [1:0] time_param_sel,
    input [3:0] time_value,
    input [2:0] estado,
    input [4:0] count,
    output fuel_pump,
    output siren,
    output status,
    output [7:0] an,
    output [7:0] dec_cat
);

reg [1:0] interval_param;
reg value, start_timer, expired, one_hz_enable, two_hz_enable, noisy, clean, eneble_siren;
reg siren, color, fuel_pump;

always @(posedge clk ) begin
    if (reset) begin
        EA <= 2'b00;
        interval_param <= 1'b0; 
    end
    else begin
        EA <= PE;
    end
end


Parametros_Tempo parametros(
    .time_param_sel(time_param_sel), 
    .interval(interval_param),
    .time_value(time_value),
    .reprogram(reprogram), 
    .clock(clock), 
    .reset(reset),
    .value(value)
);

Timer relogio(.reset (reset),
    .clock (clock),
    .value(value),
    .start_timer(start_timer),
    .expired(expired),
    .one_hz_enable(one_hz_enable)
    .two_hz_enable(two_hz_enable)    
);

debouncer deb (
    .reset(reset), 
    .clock(clock), 
    .noisy(noisy), 
    .clean(clean) 
);

dspl_drv_NexysA7 display(
    .reset(reset),
    .clock(clock),
    .d1(),
    .d2(),
    .d3(),
    .d4(),
    .d5(),
    .d6(),
    .d7(),
    .d8(),
    .dec_cat(dec_cat),
    .an(an)
);

logica_comb combustivel(
    .clock(clock),
    .reset(reset),
    .break(break),
    .hidden_sw(hidden_sw),
    .ignition(ignition),
    .fuel_pump(fuel_pump)
);

gerador_sirene sirene(
    .clock(clock), .reset(reset),
    .eneble_siren(eneble_siren), .two_hz_enable(two_hz_enable),
    .siren(siren), .color(color)
);



endmodule
