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
    input [3:0] estado,
    input [3:0] counter,
    output fuel_pump,
    output siren,
    output status,
    output [7:0] an,
    output [7:0] dec_cat
);

reg [1:0] interval_param;
reg value, start_timer, expired, one_hz_enable, two_hz_enable, noisy, clean, eneble_siren;
reg siren, color, fuel_pump;

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
    .one_hz_enable(one_hz_enable),
    .two_hz_enable(two_hz_enable),
    .counter(counter)    
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
    .d1({2'd0,estado,1'b0}),
    .d2(6'd0),
    .d3(6'd0),
    .d4(6'd0),
    .d5(6'd0),
    .d6(6'd0),
    .d7(6'd0),
    .d8({1'b0,count,1'b0}),
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

FSM_antifurt fsm(
.ignition(ignition), 
.door_driver(door_driver), 
.door_pass(door_pass), 
.reprogram(reprogram), 
.clock(clock), 
.reset(reset), 
.expired(expired), 
.one_hz_enable(one_hz_enable),
.interval(interval),
.status(status),
.start_timer(start_timer), 
.eneble_siren(eneble_siren),
.estado(estado)

);


endmodule
