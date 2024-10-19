module gerador_sirene(
    input clock, reset,
    input enable_siren, two_hz_enable,
    output [2:0]siren
);
reg [2:0]sirene;
reg [1:0]EA, PE;

always @(posedge clock) begin
    if (reset) begin
        EA <= 2'd0;
    end
    else begin
       EA <= PE;
    end
end

always @(posedge clock ) begin
    if (reset) begin
        sirene <= 3'd0;
    end
    else begin
        case (EA)
            2'b00:  if(enable_siren) begin
                        PE <= 2'b01;
                        sirene <= 3'd1;
                    end
                    else begin
                        PE <= 3'd0;
                    end
            
            2'b01:  if (enable_siren) begin
                        if (two_hz_enable) begin
                            PE <= 2'b10;
                            sirene <= 3'd4;
                        end
                    end
                    else begin
                        PE <= 2'd0;
                        sirene <= 3'd0;
                    end
            
            2'b10: if (enable_siren) begin
                        if (two_hz_enable) begin
                            PE <= 2'b01;
                            sirene <= 3'd1;
                        end
                    end
                    else begin
                        PE <= 2'd0;
                        sirene <= 3'd0;
                    end
            default: begin
                        sirene <= 3'd0;
                        PE <= 2'b00;
                    end
        endcase
    end
end

assign siren = sirene;


endmodule