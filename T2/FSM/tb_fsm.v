`timescale 1ns/1ps

module tb_fsm ();
reg clock, reset;
reg ignition, door_driver, door_pass, reprogram, expired, one_hz_enable;
wire [1:0] interval;
wire status, start_timer, enable_siren;
wire [2:0] estado;

reg start;
reg [3:0] value;
wire expired_timer, one_hz_enable_timer, two_hz_enable;
wire [3:0] counter;

reg [1:0] time_param_sel, interval_param;
reg [3:0] time_value;
wire [3:0] value_param;

reg break, hidden_sw;
wire fuel_pump;

reg enable_siren_ger, two_hz_enable_ger;
wire [2:0]siren;


assign one_hz_enable = one_hz_enable_timer;
assign expired = expired_timer;
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
.enable_siren(enable_siren),
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

logica_comb combustivel(
    .clock(clock),
    .reset(reset),
    .break(break),
    .hidden_sw(hidden_sw),
    .ignition(ignition),
    
    .fuel_pump(fuel_pump)
);

assign enable_siren_ger = enable_siren;
assign two_hz_enable_ger = two_hz_enable;

gerador_sirene sirene(
    .clock(clock), 
    .reset(reset),
    .enable_siren(enable_siren_ger), 
    .two_hz_enable(two_hz_enable_ger),
    
    .siren(siren)
);


localparam PERIOD = 10;
always #(PERIOD/2) clock=~clock;

initial begin
    clock <= 1'b0;
    reset <= 1'b1;
    #PERIOD;
    reset <= 1'b0;
    repeat (100) begin
        #PERIOD;
    end
    door_driver <= 1'b1;
    repeat (100) begin
        #PERIOD;
    end
    ignition <= 1'b1;
    repeat (10) begin
        #PERIOD;
    end
    break <= 1'b1;
    hidden_sw <= 1'b1;
    repeat (1000) begin
        #PERIOD;
    end
    door_driver <= 1'b0;
    repeat (1000) begin
        #PERIOD;
    end
    ignition <= 1'b0;
    repeat (1000) begin
        #PERIOD;
    end
    door_driver <= 1'b1;
    repeat (100) begin
        #PERIOD;
    end
    door_driver <= 1'b0;

end

endmodule