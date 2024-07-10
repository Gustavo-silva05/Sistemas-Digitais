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
      if (buffer_full == 1'd0) begin
        buffer[b_writer] <= data_1;
        b_writer <= b_writer + 3'd1;
      end
    end
    
  end
end

always @(posedge clk_2) begin
  if (rst) begin
    b_reader <= 3'd0;
  end
  else begin
    if (buffer_empty == 1'b0) begin
      d2 <= buffer[b_reader];
      b_reader <= b_reader + 3'd1;
    end
    // else if (buffer_empty && buffer_full) begin
    //   b_reader <= 4'd0;
    //   b_writer <= 4'd0;
    // end
  end
end

always @* begin
  if (rst) begin
    data_v <= 1'b0;
  end
  else begin
    if (buffer_empty) begin
      data_v <= 1'b0;
    end
    else begin
      data_v <= 1'b1;
    end
  end
end

assign buffer_empty = (b_writer == b_reader)? 1'd1 : 1'd0;
assign buffer_full  = (b_writer + 3'd1 == b_reader)    ? 1'd1 : 1'd0;    
assign data_2 = d2;
assign data_2_valid = data_v;
 
endmodule