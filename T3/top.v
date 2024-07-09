 

module top 
(
  input clk, rst, start_f, start_t, stop_f_t, update,
  input [2:0] prog,
  output [5:0] led, 
  output parity,
  output [7:0] an, dec_dpp
);
wire [2:0] prog_out; 
wire clk_1, clk_2;
dcm dcm (
    .rst(rst), 
    .clk(clk), 
    .update(update),
    .prog_in(prog),
    .prog_out(prog_out),
    .clk_1(clk_1), 
    .clk_2(clk_2)
);

wire f_en, f_valid; 
wire [15:0] f_out;
fibonacci fib (
    .rst(rst), 
    .clk(clk), 
    .f_en(f_en),
    .f_valid(f_valid),
    .f_out (f_out)
);

wire t_en, t_valid;
wire [15:0] t_out;
timer t (
    .rst(rst), 
    .clk(clk), 
    .t_en(t_en),
    .t_valid(t_valid),
    .t_out (t_out)
);
wire [1:0] modules;
wire [15:0] data_2;
dm dm (
  .rst(rst), 
  .clk(clk), 
  .prog(prog_out),
  .modules(modules),
  .data_2(),
  .an(an), 
  .dec_ddp(dec_ddp)

);
wire data_1_en, buffer_empty, buffer_full, data_2_valid;
wire data_1;
wrapper buffering (
    .rst(rst), 
    .clk_1(clk_1), 
    .clk_2(clk_2), 
    .data_1_en(data_1_en),
    .data_1(data_1),
    .buffer_empty(buffer_empty), 
    .buffer_full(buffer_full), 
    .data_2_valid(data_2_valid),
    .data_2(data_2)
);



wire [2:0] EA, PE;

always @(posedge clk ) begin
  if (rst) begin
    EA <= 3'd0;
  end
  else begin
    EA <= PE;
  end
end

always @(posedge clk, EA ) begin
  if (rst) begin
    PE <= 3'd0;
  end
  else begin
    case (EA)
      3'd0: begin                       /*IDLE*/
        if (start_f) begin
          PE <= 3'd1;
        end  
        else if (start_t) begin
          PE <= 3'd2;
        end
        else begin
          PE <= 3'd0;
        end
      end 
      3'd1:begin                    /*S_COMM_F*/
        if (stop_f_t) begin
          PE <= 3'd3;
        end
        else if (buffer_full) begin
          PE <= 3'd4;
        end
        else begin
          PE <= 3'd1;
        end
      end
      3'd2:begin                    /*S_COMM_T*/
        if (stop_f_t) begin
          PE <= 3'd3;
        end
        else if (buffer_full) begin
          PE <= 3'd5;
        end
        else begin
          PE <= 3'd2;
        end
      end
      3'd3:begin                  /*s_BUF_EMPTY*/
        if (buffer_empty && (data_2_valid == 1'd0)) begin
          PE <= 3'd0;
        end
        else begin
          PE <= 3'd3;
        end
      end
      3'd4:begin
        if (stop_f_t) begin
          PE <= 3'd3;
        end
        else if (buffer_full == 1'b0) begin
          PE <= 3'd1;
        end
        else begin
          PE <= 3'd4;
        end
      end
      3'd5:begin
        if (stop_f_t) begin
          PE <= 3'd3;
        end
        else if (buffer_full == 1'b0) begin
          PE <= 3'd2;
        end
        else begin
          PE <= 3'd5;
        end
      end
      default: PE <= 3'd0;
    endcase
  end
end

always @(posedge clk , EA) begin
  if (rst) begin
    t_en <= 1'b0;
    f_en <= 1'b0;
  end
  else begin
    case (EA)
      3'd0: begin
        t_en <= 1'b0;
        f_en <= 1'b0;
      end
      3'd1:begin
        f_en <= 1'b1;
        t_en <= 1'b0;
        data_1 <= f_out;
        data_1_en <= f_valid;
      end
      3'd2:begin
        f_en <= 1'b0;
        t_en <= 1'b1;
        data_1 <= t_out;
        data_1_en <= t_valid;
      end
      3'd3:begin
        
      end
      3'd4:begin
      end
      3'd5 :begin
      end
      default: begin
        t_en <= 1'b0;
        f_en <= 1'b0;
      end
    endcase
  end
end


endmodule