module timer (
  input rst, clk, t_en,
  output t_valid,
  output [15:0] t_out
);

reg t_valido;
reg [15:0] t_o;
reg flag;


always @(posedge clk ) begin
  if (rst) begin
    t_o <= 16'd0;
  end
  else begin
    if (t_en) begin
      t_o <=  t_o + 16'd1;
      end
  end
end

always @* begin
  if (rst) begin
    t_valido <= 1'b0;
    flag <= 1'b0;
  end
  else begin
        if(t_en) begin
      t_valido <= 1'b1;
      flag <= 1'b0;
    end
    else if (flag) begin
      t_valido <= 1'b0;
    end
    else if (t_o == 16'd0) begin
      t_valido <= 1'b0;
      flag <= 1'b0;
    end
    else begin
      t_valido <= 1'b1;
      flag <= 1'b1;
    end
  end
end
assign t_valid = t_valido;
assign t_out = t_o;

endmodule