`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module tb;

  reg clk, reset, start_f, start_t, update, stop_f_t;
  reg [2:0] prog;
  wire [5:0] led;
  wire [7:0] an, dec_cat;
  wire parity;

  localparam PERIOD_100MHZ = 10;  

  initial
  begin
    clk = 1'b1;
    forever #(PERIOD_100MHZ/2) clk = ~clk;
  end

  initial
  begin
    reset = 1'b1;
    #30;
    reset = 1'b0;
    start_f  = 1'b0;
    start_t  = 1'b0;
    stop_f_t = 1'b0;
    update   = 1'b0;
    prog     = 3'd0;
    #80;
    update   = 1'b1;
    prog     = 3'b011;
    #10;
    update   = 1'b0;
    prog     = 3'd0;
    #100;
    start_f  = 1'b1;
    #10;
    start_f  = 1'b0;
    #1000;
    stop_f_t  = 1'b1;
    #10;
    stop_f_t  = 1'b0;
    #4000;
    start_t  = 1'b1;
    #10;
    start_t  = 1'b0;
    #400;
    stop_f_t  = 1'b1;
    #10;
    stop_f_t  = 1'b0;
    #4000;
    update   = 1'b1;
    prog     = 3'b101;
    #10;
    update   = 1'b0;
    prog     = 3'd0;
    #300;
    start_f  = 1'b1;
    #10;
    start_f  = 1'b0;
    #300;
    stop_f_t  = 1'b1;
    #10;
    stop_f_t  = 1'b0;
	  #8000;
    update   = 1'b1;
    prog     = 3'b000;
    #10;
    update   = 1'b0;
    prog     = 3'b000;
    #200;
    start_t  = 1'b1;
    #10;
    start_t  = 1'b0;
    #1000;
    stop_f_t  = 1'b1;
    #10;
    stop_f_t  = 1'b0;
  end

  top DUT(.rst(reset), .clk(clk), /*.parity(parity),*/ .start_f(start_f), .start_t(start_t), .update(update), .stop_f_t(stop_f_t), .prog(prog), .led(led), .an(an), .dec_ddp(dec_cat));

endmodule 