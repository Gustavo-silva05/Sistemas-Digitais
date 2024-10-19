`timescale 1ns/1ps

module tb_fib ();
reg rst, clk, f_en;
wire f_valid;
wire [15:0] f_out;

fibonacci fib (
    .rst(rst), 
    .clk(clk), 
    .f_en(f_en),
    .f_valid(f_valid),
    .f_out (f_out)
);

localparam PERIOD = 10;

always #(PERIOD/2) clk <= ~clk; 
    
initial begin
    clk <= 1'b0;
    rst <= 1'b1;
    #PERIOD;
    rst <= 1'b0;
    repeat (5) #PERIOD;
    f_en <= 1'b1;
    repeat (20) #PERIOD;
    f_en <= 1'b0;
end

endmodule