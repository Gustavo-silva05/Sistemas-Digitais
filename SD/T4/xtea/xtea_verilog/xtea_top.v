module XTEA_TOP (
    input start, conf, reset, clock,
    input [127:0] data_i, key,
    output ready, busy,
    output [127:0] data_o
);
reg ready_r, busy_r;
reg [127:0] data_o_r;

always @(posedge clk ) begin
    if (reset) begin
        start <= 1'b0;
    end
end



    
endmodule