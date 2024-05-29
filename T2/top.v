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
    output fuel_pump,
    output siren,
    output status
);
reg pump;
reg sirene,
reg stats;

Parametros_Tempo parametros();

debouncer deb ();

dspl_drv_NexysA7 display();

assign fuel_pump = pump;
assign siren = sirene;
assign status = stats;


endmodule
