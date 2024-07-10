 module top 
(
  input clk, rst, start_f, start_t, stop_f_t, update,
  input [2:0] prog,
  output [5:0] led, 
  output parity,
  output [7:0] an, dec_dpp
);
reg [15:0] data_1_in, data_2_in;
reg [2:0] prog_in;
reg clk_2_in;
reg f_en, f_valid; 
reg t_en,t_valid;
reg [1:0] modules_fsm;

wire [2:0] prog_out; 
wire clk_1, clk_2;
wire [15:0] f_out;
wire [15:0] t_out;
wire modules;
wire [15:0] data_2;
wire data_1_en, buffer_empty, buffer_full, data_2_valid;

assign clk_2_in = clk_2;
assign data_2_in = data_2;


dcm dcm (
    .rst(rst), 
    .clk(clk), 
    .update(update),
    .prog_in(prog_in),
    .prog_out(prog_out),
    .clk_1(clk_1), 
    .clk_2(clk_2)
);

fibonacci fib (
    .rst(rst), 
    .clk(clk_2_in), 
    .f_en(f_en),
    .f_valid(f_valid),
    .f_out (f_out)
);

timer t (
    .rst(rst), 
    .clk(clk_2_in), 
    .t_en(t_en),
    .t_valid(t_valid),
    .t_out (t_out)
);

dm dm (
  .rst(rst), 
  .clk(clk_2), 
  .prog(prog_in),
  .modules(modules),
  .data_2(data_2_in),
  .an(an), 
  .dec_ddp(dec_ddp)

);
wrapper buffering (
    .rst(rst), 
    .clk_1(clk_1), 
    .clk_2(clk_2), 
    .data_1_en(data_1_en),
    .data_1(data_1_in),
    .buffer_empty(buffer_empty), 
    .buffer_full(buffer_full), 
    .data_2_valid(data_2_valid),
    .data_2(data_2)
);

wire start_f_ed;
edge_detector SF(.clock(clk_2),.reset(rst),.din(start_f),.rising(start_f_ed));
wire start_t_ed;
edge_detector ST(.clock(clk_2),.reset(rst),.din(start_t),.rising(start_t_ed));
wire stop_f_t_ed;
edge_detector SFT(.clock(clk_2),.reset(rst),.din(stop_f_t),.rising(stop_f_t_ed));
wire update_ed;
edge_detector UP(.clock(clk_2),.reset(rst),.din(update),.rising(update_ed));


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
        if (start_f_ed) begin
          PE <= 3'd1;
        end  
        else if (start_t_ed) begin
          PE <= 3'd2;
        end
        else begin
          PE <= 3'd0;
        end
      end 
      3'd1:begin                    /*S_COMM_F*/
        if (stop_f_t_ed) begin
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
        if (stop_f_t_ed) begin
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
        if (stop_f_t_ed) begin
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
        if (stop_f_t_ed) begin
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
    if (start_f) begin
      modules_fsm <= 2'd1;
    end
    else if (start_t) begin
      modules_fsm <= 2'd2;
    end
    else if (EA == 3'd0) begin
      modules_fsm <= 2'd0;
    end
  end
end


always @(posedge clk ) begin
  if (rst) begin
    f_en <= 1'b0;
    t_en <= 1'b0;
    data_1_in <= 16'd0;
  end
  else begin
    if (!buffer_full) begin
      case (EA)
        3'd0: begin
          f_en <= 1'b0;
          t_en <= 1'b0;
          data_1_in <= 16'd0;
        end
        3'd1:begin
          f_en <= 1'b1;
          t_en <= 1'b0;
          data_1_in <= f_out;
        end
        3'd2:begin
          t_en <= 1'b1;
          f_en <= 1'b0;
          data_1_in <= t_out;
        end
        3'd3:begin
          f_en <= 1'b0;
          t_en <= 1'b0;
        end
        3'd4: begin
          f_en <= 1'b1;
          t_en <= 1'b0;
          data_1_in <= f_out;
        end
        3'd5: begin
          t_en <= 1'b1;   
          f_en <= 1'b0;   
          data_1_in <= t_out;    
        end
        default: begin
          f_en <= 1'b0;
          t_en <= 1'b0;
          data_1_in <= 16'd0;
        end
      endcase
    end
  end
end
assign led = {3'd0, EA};

assign data_1_en = (f_valid || t_valid);

endmodule
