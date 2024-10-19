`timescale 1ns/1ps

module tb_timer ();
reg rst, clk, t_en;
wire t_valid;
wire [15:0] t_out;

timer t (
    .rst(rst), 
    .clk(clk), 
    .t_en(t_en),
    .t_valid(t_valid),
    .t_out (t_out)
);

localparam PERIOD = 10;

always #(PERIOD/2) clk <= ~clk; 
    
initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    #PERIOD;
    rst <= 1'b0;
    repeat (5) #PERIOD;
    t_en <= 1'b1;
    repeat (20) #PERIOD;
    t_en <= 1'b0;
end

endmodule