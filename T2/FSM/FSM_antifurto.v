module FSM_antifurto (
    input ignition, door_driver, door_pass, reprogram, clock, reset, expired, one_hz_enable,
    output [1:0] interval,
    output status,
    output start_timer, eneble_siren,
    output [2:0] estado

);

reg [1:0] intervalo;
reg start, enable, stats;
reg [2:0] EA;
reg [2:0] PE;

always @(posedge clock ) begin
    if (reset) begin
        EA <= 3'd0;
    end
    else begin
        EA <= PE;
    end
end

always @* begin
    case (EA) 
        3'b000:  if (ignition) begin  //Armado
                    PE <= 3'b011;   
                end
                else if (door_driver || door_pass) begin
                    start <= 1'b1;
                    PE <= 3'b001;
                end
                else begin
                    PE <= 3'b000;
                end
        
        3'b001:  if (ignition) begin // Acionado
                    PE <= 3'b011;
                end
                else begin
                    start <= 1'b0;
                    if (expired) begin
                        PE <= 3'b010;
                        start <= 1'b1;
                    end
                    else begin
                        PE <= 3'b001;
                    end
                end

        3'b010: if (expired) begin // Ativar_Alarme
                    PE <= 3'b000;
                end
                else begin
                     start <= 1'b0;
                    if (ignition) begin
                        PE <= 3'b011;
                    end  
                    else begin
                        PE <= 3'b010;
                    end              
                end 

        3'b011: if (ignition) begin
                    PE <= 3'b001;
                end
                else begin
                    PE <= 3'b100;
                end

        3'b100: if (door_driver) begin
                    PE <= 3'b101;
                end
                else begin
                    PE <= 3'b100;
                end

        3'b101: if (door_driver) begin
                    PE <= 3'b101;
                end
                else begin
                    start <= 1'b1;
                    PE <= 3'b110;
                end

        3'b110: if (expired) begin
                    PE <= 3'b000;
                end
                else begin
                    start <= 1'b0;
                    PE <= 3'b110;
                end
    endcase
end
    
always @* begin
    case (EA)
        3'b000:  if (door_driver) begin
                   intervalo <= 2'b01;
                end 
                else if (door_pass) begin
                    intervalo <= 2'b10;
                end

        3'b001:  if (expired) begin
                    intervalo <= 2'b11;   
                end

        3'b010: if (expired) begin
                    intervalo <= 2'b00;
                end
        default: intervalo <= 2'b00;
    endcase
end

assign estado = EA;
assign start_timer = start;
assign interval = intervalo;

endmodule