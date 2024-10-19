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
reg [2:0] buffer_rd, buffer_wr;

always @(posedge clk_1 ) begin
  if (rst) begin
    buffer_wr <= 3'd0;
  end
  else begin
    if (data_1_en) begin
      if (!buffer_full ) begin
        buffer[buffer_wr] <= data_1;
        buffer_wr <= buffer_wr + 3'd1;
      end
    end
    else if (buffer_empty )begin
        buffer_wr <= 3'd0;
    end
  end
end

always @(posedge clk_2) begin
  if (rst) begin
    buffer_rd <= 3'd0;
    d2 <= 16'd0;
  end
  else begin
      if (!buffer_empty)begin
        d2 <= buffer[buffer_rd];
        buffer_rd <= buffer_rd + 3'd1;
      end
      else if (buffer_full)begin
        buffer_rd <= 3'd0;
      end
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

assign buffer_empty = (buffer_wr == buffer_rd)? 1'd1 : 1'd0;
assign buffer_full = (buffer_wr == 3'b111) ? 1'b1 : 1'b0;
assign data_2 = d2;
assign data_2_valid = data_v;
 
endmodule

