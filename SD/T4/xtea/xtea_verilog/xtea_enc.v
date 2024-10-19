module xtea_enc (
    input clk, 
    input reset,
    input start,
    input [127:0] data_i, 
    input [127:0] key,
    output [127:0] data_o  
);
/* '00' = IDLE / '01' = INV / '10' = ENCRIP */
reg [1:0] EA , PE; 
reg [127:0] data_temp;

always @(posedge clk, reset) begin
    if (reset) begin
        EA <= 2'd0;
    else
        EA <= PE;
    end
end

always @* begin
    case (EA)
        2'b00:  (start = 1'b1) ? PE <= 2'b01 : 2'b00;
        2'b01:  data_temp <= {data_i[31:0], data_i[63:32], data_i[95:64], data_i[127:96]};
                PE <= 2'b10;
        2'b10:  PE <= 2'b00;  
        default: PE <= 2'b00;
    endcase
end 

assign data_o = data_temp;

endmodule