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
  .d1({1'd1, 1'd0, prog, 1'd0}), 
  .d2({1'd1, 2'd0, modules, 1'd0}), 
  .d3(), 
  .d4(), 
  .d5({1'd1, [15:12]data_2, 1'd0}), 
  .d6({1'd1, [11:8]data_2, 1'd0}), 
  .d7({1'd1, [7:4]data_2, 1'd0}), 
  .d8({1'd1, [3:0]data_2, 1'd0}),
  .an(an), 
  .dec_cat(dec_ddp)
);





endmodule
