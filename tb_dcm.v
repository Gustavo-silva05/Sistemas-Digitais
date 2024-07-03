`timescale 1ns/1ps

module tb_dcm();

reg rst, clk, update;
reg [2:0] prog_in;
wire [2:0] prog_out;
wire clk_1, clk_2;

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
    clk <= 1'b0;
    rst <= 1'b1;
    #PERIOD;
    rst <= 1'b0;
    prog_in <= 3'd2;
    update <= 1'b1;
    #PERIOD;
    update <= 1'b0;
    repeat (250) #PERIOD;
    prog_in <= 3'd5;
    update <= 1'b1;
    #PERIOD;
    update <= 1'b0;
    repeat (180) #PERIOD;
    prog_in <= 3'd7;
    update <= 1'b1;
    #PERIOD;
    update <= 1'b0;
    repeat (250) #PERIOD;
    prog_in <= 3'd0;
    update <= 1'b1;
    #PERIOD;
    update <= 1'b0;
    repeat (220) #PERIOD;

end

endmodule