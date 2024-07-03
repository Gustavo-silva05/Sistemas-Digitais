module dcm(
  input rst, clk, update,
  input [2:0] prog_in,
  output [2:0] prog_out,
  output clk_1, clk_2
);

reg [2:0] prog_o;
reg c_2;
reg [8:0] timers, counter;


always @(posedge clk ) begin
  if (rst) begin
    c_2 <= 1'b0;
  end
  else begin
    if (update) begin
      counter <= timers;
    end
    else if (counter == 9'd0) begin
      c_2 <= ~c_2;
      counter <= timers;
    end
    else if (counter == (counter/2)) begin
      c_2 <= ~c_2;
    end
    else begin
      counter <= counter - 9'd1;
    end
  end
end



always @(posedge clk ) begin
  if (rst) begin
    timers <= 9'd1;
  end
  else begin
    if (update) begin
      case (prog_in)
        3'd0: timers <= 9'd1; 
        3'd1: timers <= 9'd2;
        3'd2: timers <= 9'd4;
        3'd3: timers <= 9'd10;
        3'd4: timers <= 9'd16;
        3'd5: timers <= 9'd32;
        3'd6: timers <= 9'd64;
        3'd7: timers <= 9'd128;
        default: timers <= 9'd1; 
      endcase
    end
  end
end

assign clk_1 = clk;
assign clk_2 = c_2;

endmodule