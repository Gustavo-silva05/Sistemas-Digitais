module top 
(
  input clk, rst, start_f, start_t, stop_f_t, opdate,
  input [2:0] prog,
  output [5:0] led, 
  output parity,
  output [7:0] an, dec_dpp
);

wire f_valid;
wire [15:0] f_out;

wire t_valid;
wire t_out;

wire [2:0] prog_out;
wire clk_2, clk_1;

endmodule