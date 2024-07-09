 

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

wire  t_en,t_valid;
wire [15:0] t_out;
timer t (
    .rst(rst), 
    .clk(clk), 
    .t_en(t_en),
    .t_valid(t_valid),
    .t_out (t_out)
);
reg [1:0] modules_fsm;
wire modules;
assign modules = modules_fsm;
wire [15:0] data_2;
dm dm (
  .rst(rst), 
  .clk(clk), 
  .prog(prog),
  .modules(modules),
  .data_2(data_2),
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



reg [2:0] EA, PE;

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
      3'd4:begin                  /*S_WAIT_F*/
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
      3'd5:begin                /*S_WAIT_T*/
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

always @(posedge clk) begin
  if (rst) begin
    modules_fsm <= 2'd0;
  end
  else begin
    if ((EA== 3'd0) || (EA== 3'd1) || (EA== 3'd2)) begin
      if (data_2_valid) begin
        modules_fsm <= EA[1:0];
      end 
      else begin
        modules_fsm <= 2'd0;
      end
    end
  end
end


always @(posedge clk ) begin
  if (rst) begin
    f_en <= 1'b0;
    t_en <= 1'b0;
    data_1 <= 16'd0;
  end
  else begin
    if (!buffer_full) begin
      case (EA)
        3'd0: begin
          f_en <= 1'b0;
          t_en <= 1'b0;
          data_1 <= 16'd0;
        end
        3'd1:begin
          f_en <= 1'b1;
          t_en <= 1'b0;
          data_1 <= f_out;
        end
        3'd2:begin
          t_en <= 1'b1;
          f_en <= 1'b0;
          data_1 <= t_out;
        end
        3'd3:begin
          f_en <= 1'b0;
          t_en <= 1'b0;
        end
        3'd4: begin
          f_en <= 1'b1;
          t_en <= 1'b0;
          data_1 <= f_out;
        end
        3'd5: begin
          t_en <= 1'b1;   
          f_en <= 1'b0;   
          data_1 <= t_out;    
        end
        default: begin
          f_en <= 1'b0;
          t_en <= 1'b0;
          data_1 <= 16'd0;
        end
      endcase
    end
  end
end

assign data_1_en = (f_valid || t_valid);

endmodule