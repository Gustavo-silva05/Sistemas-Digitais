
module top(
  input rst, clk, start_f, start_t, stop_f_t ,update,
  input[2:0] prog,
  output [5:0] led, 
  output [7:0] an , dec_ddp
  //output parity
);

reg f_en, t_en;
wire f_valid, t_valid;
wire [15:0] f_out, t_out;
wire [2:0] prog_out;
wire clk_1, clk_2;
wire data_1_en;
wire [15:0] data_2; 
reg [15:0] data_1;
wire buffer_empty, buffer_full;
wire update_ed, stop_f_t_ed, start_f_ed, start_t_ed;
reg [1:0] modules;
reg [5:0] led_r;

fibonacci fib (
    .rst(rst), 
    .clk(clk_1), 
    .f_en(f_en),
    .f_valid(f_valid),
    .f_out (f_out)
);

timer t (
    .rst(rst), 
    .clk(clk_1), 
    .t_en(t_en),
    .t_valid(t_valid),
    .t_out (t_out)
);

dcm dcm (
    .rst(rst), 
    .clk(clk), 
    .update(update),
    .prog_in(prog),
    .prog_out(prog_out),
    .clk_1(clk_1), 
    .clk_2(clk_2)
);

wrapper w (
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

dm dm(
  .rst(rst), .clk(clk),
  .prog(prog_out),
  .modules(modules),
  .data_2(data_2),
  .an(an), .dec_ddp(dec_ddp)
);

edge_detector SF  (.clock(clk), .reset(rst), .din(start_f), .rising(start_f_ed));
edge_detector ST  (.clock(clk), .reset(rst), .din(start_t), .rising(start_t_ed));
edge_detector SFT (.clock(clk), .reset(rst), .din(stop_f_t), .rising(stop_f_t_ed));
edge_detector U   (.clock(clk), .reset(rst), .din(update), .rising(update_ed));

reg [2:0] EA, PE;

always @(posedge clk ) begin
  if (rst) begin
    EA <= 3'd0;
  end
  else begin
    EA <= PE;
  end
end

always @* begin
  if (rst) begin
    PE <= 3'd0;
  end
  else begin
    case (EA)
      3'd0: begin
        if (start_f_ed) begin
          PE <= 3'd1;
        end
        else if (start_t_ed) begin
          PE <= 3'd4;
        end
        else begin
          PE <= 3'd0;
        end
      end
      3'd1: begin
        if (buffer_full) begin
          PE <= 3'd2;
        end       
        else if (stop_f_t_ed) begin
          PE <= 3'd3;
        end
        else begin
          PE <= 3'd1;
        end
      end
      3'd2:begin
        if (!buffer_full) begin
          PE <= 3'd1;
        end
        else if (stop_f_t_ed) begin
          PE <= 3'd3;
        end
        else begin
          PE <= 3'd2;
        end
      end
      3'd3:begin
        if (buffer_empty && !data_2_valid) begin
          PE <= 3'd0;
        end
        else begin
          PE <=3'd3;
        end
      end
      3'd4:begin
        if (buffer_full) begin
          PE <= 3'd5;
        end       
        else if (stop_f_t_ed) begin
          PE <= 3'd3;
        end
        else begin
          PE <= 3'd4;
        end
      end
      3'd5: begin
        if (!buffer_full) begin
          PE <= 3'd4;
        end
        else if (stop_f_t_ed) begin
          PE <= 3'd3;
        end
        else begin
          PE <= 3'd5;
        end
      end
      default: PE <= 3'd0; 
    endcase
  end
end

always @* begin
  if (rst) begin
    f_en <= 1'b0;
    t_en <= 1'b0;
    data_1 <= 16'd0;
    led_r <= 6'd0;
  end
  else begin
    case (EA)
      3'd0: begin
        f_en <= 1'b0;
        t_en <= 1'b0;
        modules <= 2'd0;
        led_r <= 6'd0;
      end
      3'd1: begin
        f_en <= 1'b1;
        t_en <= 1'b0;
        data_1 <= f_out;
        modules <= 2'd1;
        led_r <= 6'd1;
      end 
      3'd2:begin
        f_en <= 1'b0;
        t_en <= 1'b0;
        modules <= 2'd1;
        led_r <= 6'd2;
      end
      3'd3: begin
        f_en <= 1'b0;
        t_en <= 1'b0;
        led_r <= 6'd4;
      end
      3'd4:begin
        f_en <= 1'b0;
        t_en <= 1'b1;
        data_1 <= t_out;
        modules <= 2'd2;
        led_r <= 6'd8;
      end
      3'd5: begin
        f_en <= 1'b0;
        t_en <= 1'b0;
        modules <= 2'd2;
        led_r <= 6'd16;
      end
      default: begin
        f_en <= 1'b0;
        t_en <= 1'b0;                
        modules <= 2'd1;
        led_r <= 6'd32;
      end
    endcase
  end
end

assign led = led_r;
assign data_1_en = (f_valid || t_valid)? 1'b1 : 1'b0;


endmodule
 
