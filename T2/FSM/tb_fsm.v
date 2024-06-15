`timescale 1ns/1ps

module tb_fsm ();
reg clock, reset;
reg ignition, door_driver, door_pass, reprogram, expired, one_hz_enable;
wire [1:0] interval;
wire status, start_timer, eneble_siren;
wire [2:0] estado;

reg start;
reg [3:0] value;
wire expired_timer, one_hz_enable_timer, two_hz_enable;
wire [3:0] counter;

reg [1:0] time_param_sel, interval_param;
reg [3:0] time_value;
wire [3:0] value_param;



FSM_antifurto FSM(
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

assign interval_param = interval;

Parametros_Tempo parametros(
    .time_param_sel(time_param_sel), 
    .interval(interval_param),
    .time_value(time_value),
    .reprogram(reprogram), 
    .clock(clock), 
    .reset(reset),
    
    .value(value_param)
);


assign start = start_timer;
assign expired_timer = expired;
assign one_hz_enable_timer = one_hz_enable;
assign value = value_param;

Timer relogio(.reset (reset),
    .clock (clock),
    .value(value),
    .start_timer(start),
    
    .expired(expired_timer),
    .one_hz_enable(one_hz_enable_timer),
    .two_hz_enable(two_hz_enable),
    .counter(counter)    
);

// logica_comb combustivel(
//     .clock(clock),
//     .reset(reset),
//     .break(break),
//     .hidden_sw(hidden_sw),
//     .ignition(ignition),
    
//     .fuel_pump(fuel_pump)
// );

// gerador_sirene sirene(
//     .clock(clock), .reset(reset),
//     .eneble_siren(eneble_siren), .two_hz_enable(two_hz_enable),
    
//     .siren(siren), .color(color)
// );


localparam PERIOD = 10;
always #(PERIOD/2) clock=~clock;

initial begin
    clock <= 1'b0;
    reset <= 1'b1;
    #PERIOD;
    reset <= 1'b0;
    repeat (10) begin
        #PERIOD;
    end
    door_driver <= 1'b1;
end

endmodule