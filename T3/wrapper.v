module wrapper 
(
  input rst, clk_1, clk_2, data_1_en,
  input [15:0] data_1,
  output buffer_empty, buffer_full, data_2_valid,
  output [15:0] data_2
);

reg data_v;
reg [15:0]d2;

reg [15:0] buffer [0:7];
reg [2:0] b_reader, b_writer;

always @(posedge clk_1 ) begin
  if (rst) begin
    b_writer <= 3'd0;
  end
  else begin
    if (data_1_en) begin
      while (b_f == 1'd0) begin
        buffer[b_writer] <= data_1;
        b_writer <= b_writer + 3'd1;
      end
    end
    else if (b_e) begin
      b_writer <= 3'd0;
    end
  end
end

always @(posedge clk_2) begin
  if (rst) begin
    b_reader <= 3'd0;
  end
  else begin
    d2 <= buffer[b_reader];
    b_reader <= b_reader + 3'd1;
  end
end

assign buffer_empty = (b_writer == b_reader)? 1'd1 : 1'd0;
assign buffer_full  = (b_writer == 3'd7)? 1'd1 : 1'd0;    
assign data_2 = d2;
// assign data_2_valid

endmodule