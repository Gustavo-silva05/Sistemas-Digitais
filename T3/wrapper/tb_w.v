`timescale 1ns/1ps
module tb_w();
reg rst, clk_1, clk_2 data_1_en;
reg[15:0] data_1;
wire buffer_empty, buffer_full, data_2_valid;
wire [15:0] data_2;

wrapper buf (
    .rst(rst), 
    .clk_1(clk_1), 
    .clk_2(clk_2), 
    .data_1_en(data_1_en),
    .data_1(data_1),
    .buffer_empty(buffer_empty), 
    .buffer_full(buffer_full), 
    .data_2_valid(data_2_valid),
    .data_2(data_2)
);
dcm dcm (
    .rst(rst), 
    .clk(clk), 
    .update(update),
    .prog_in(prog_in),
    .prog_out(prog_out),
    .clk_1(clk_1), 
    .clk_2(clk_2)
);

localparam PERIOD = 10;

always #(PERIOD/2) clk <= ~clk; 

initial begin
    
end

endmodule