module FSM_antifurto (
    input ignition, door_driver, door_pass, reprogram, clock, reset, expired, one_hz_enable,
    output [1:0] interval, status,
    output start_timer, eneble_siren
);

// Timer temporizador (
//     .clock(clock),
//     .reset(reset),
//     .value(),
//     .start_timer(start_timer),
//     .expired(expired),
//     .one_hz_enable(one_hz_enable)
// );
// Parametros_Tempo param ( 
//     .time_param_sel(), 
//     .interval(interval),
//     .time_value(),
//     .reprogram(reprogram), 
//     .clock(clock), 
//     .reset(reset),
//     .value()
// );
// gerador_sirene generator (
//     .clock(clock), 
//     .reset(reset),
//     .eneble_siren(eneble_siren), 
//     .two_hz_enable(),
//     .siren(), 
//     .color()
// );


reg [1:0] intervalo;
reg start, enable, stats;
reg [1:0] EA;
reg [1:0] PE;

always @(posedge clock ) begin
    if (reset) begin
        state <= 2'b00;
    end
    else begin
        EA <= PE;
    end
end

always @* begin
    case (EA)
        2'b00:  if (ignition) begin  //Armado
                    PE <= 2'b11;   
                end
                else if (expired) begin
                    PE <= 2'b01;
                end
                else begin
                    start <= 1'b1;
                end
        2'b01:  if (ignition) begin // Acionado
                    PE <= 2'b11;
                else
                    if (expired) begin
                        PE <= 2'b10;
                    end
                end

        2'b10:  if (expired) begin// Ativar_Alarme
                    PE <= 2'b00;
                else
                    if (ignition) begin
                        PE <= 2'b11;
                    end                
                end 

        2'b11:  if (ignition = 1'b0) begin// Desarmado
                    
                else
                    PE <= 2'b11;
                end
    endcase
end
    
always @* begin
    case (EA)
        2'b00: intervalo <= 2'b00;
        2'b01:  if (door_driver) begin
                    intervalo <= 2'b01;
                else
                    intervalo <= 2'b00;
                end 
        2'b10: intervalo <= 2'b11;
        2'b11: 
    endcase
end

endmodule
