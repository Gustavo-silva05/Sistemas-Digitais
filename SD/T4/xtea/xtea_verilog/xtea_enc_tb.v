`timescale 1ns/1ps

module xtea_enc_tb ();
/* '00' = IDLE / '01' = INV / '10' = ENCRIP */

reg clk, reset,start;
reg [127:0] data_i, key;
wire [127:0] data_o;

xtea_enc encriptador (
    .clk(clk), .reset(reset), .start(start), .data_i(data_i), .key(key), .data_o(data_o)
);

localparam PERIODO = 10;

always #(PERIODO/2) clk = ~clk;

initial begin
    clk <= 1'b0;
end
    
endmodule