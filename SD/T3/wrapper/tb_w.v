`timescale 1ns/1ps
module tb_w();
reg rst, clk_1, clk_2, data_1_en;
reg[15:0] data_1;
wire buffer_empty, buffer_full, data_2_valid;
wire [15:0] data_2;

wrapper w (
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

localparam PERIOD_c1 = 10;
localparam PERIOD_c2 = 40;

always #(PERIOD_c1/2) clk_1 <= ~clk_1; 
always #(PERIOD_c2/2) clk_2 <= ~clk_2; 

initial begin
    clk_1   <= 1'd0;
    clk_2   <= 1'd0;
    rst     <= 1'd1;
    data_1  <= 16'd0;
    data_1_en <= 1'b1;
    #PERIOD_c2;
    rst     <= 1'd0;
    data_1  <= 16'd1;
    #PERIOD_c1; 
    data_1  <= 16'd2;
    #PERIOD_c1;
    data_1  <= 16'd3;
    #PERIOD_c1;
    data_1  <= 16'd4;
    #PERIOD_c1;
    data_1  <= 16'd5;
    #PERIOD_c1;
    data_1  <= 16'd6;
    #PERIOD_c1;
    data_1  <= 16'd7;
    #PERIOD_c1;
    data_1  <= 16'd8;
    #PERIOD_c1;
    data_1_en <= 1'b0;
end

endmodule