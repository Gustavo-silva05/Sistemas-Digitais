module fibonacci 
(
  input rst, clk, f_en,
  output f_valid,
  output [15:0] f_out
);

reg f_valido;
reg [15:0] f_o;
reg [15:0] n_1, n_2;
reg flag;


always @(posedge clk ) begin
  if (rst) begin
    f_o <= 16'd0;
    n_1 <= 16'd0;
    n_2 <= 16'd0;
  end
  else begin
    if ( f_en) begin
      if( n_1 == 16'd0) begin
        f_o <= 16'd0;
        n_1 <= 16'd1;
        n_2 <= 16'd0;
      end
      else begin
        if ( n_2 == 16'd0) begin
          f_o <= 16'd1;
          n_1 <= 16'd1;
          n_2 <= 16'd1;
        end
        else begin
          n_2 <= n_1;
          f_o <= n_1 + n_2;
          n_1 <= n_1 + n_2;
          
        end
      end
    end
    
  end
end

always @(posedge clk) begin
  if (rst) begin
    f_valido <= 1'b0;
    flag <= 1'b0;
  end
  else begin
    if (f_en) begin
      f_valido <= 1'b1;
      flag <= 1'b0;
    end
    else if (flag) begin
      f_valido <= 1'b0;
    end
    else if (f_o == 16'd0) begin
      f_valido <= 1'b0;
      flag <= 1'b0;
    end
    else begin 
      f_valido <= 1'b1;
      flag <= 1'b1;
    end
  end
end

assign f_out = f_o;
assign f_valid = f_valido;

endmodule