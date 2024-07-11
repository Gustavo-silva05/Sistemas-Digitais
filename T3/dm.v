module dm 
(
  input rst, clk,
  input [2:0] prog,
  input [1:0] modules,
  input [15:0] data_2,
  output [7:0] an, dec_ddp
);

dspl_drv_NexysA7 display (
  .clock(clk), 
  .reset(rst),
  // .d1(6'd0),
  // .d2(6'd0),
  // .d3(6'd0),
  // .d4(6'd0),
  .d1({1'd1, data_2[3:0], 1'd0}), 
  .d2({1'd1, data_2[7:4], 1'd0}), 
  .d3({1'd1, data_2[11:8], 1'd0}), 
  .d4({1'd1, data_2[15:12], 1'd0}), 
  .d5({1'd1, 2'd0, modules, 1'd0}), 
  .d6(6'd0), 
  .d7(6'd0), 
  .d8({2'b10, prog, 1'b0}),
  .an(an), 
  .dec_cat(dec_ddp)
);

// {1'd1, 2'd0, modules, 1'd0}
endmodule
