module Timer(
    input clock,
    input reset,
    input [3:0] value,
    input start_timer,
    output expired,
    output one_hz_enable,
    output half_haz_enable;
)
reg [3:0] count;

always @(posedge clk ) begin
    if (reset) begin
        if (start_timer) begin
            count <= value;
        end
    end
    else begin
        if (one_hz_enable) begin
            count <= count - 4'd1;
        end
    end
end


endmodule