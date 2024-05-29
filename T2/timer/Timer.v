module Timer(
    input clock,
    input reset,
    input [4:0] value,
    input start_timer,
    output expired,
    output one_hz_enable
);
reg [4:0] count;
reg [27:0] timer_1sec;
reg expirou;
reg one_hz;

always @(posedge clock ) begin
    if (reset) begin
        timer_1sec <= 28'd100_000_000;
        expirou = 1'b0;
    end
    else begin
        if (start_timer) begin
            count <= value;
            expirou = 1'b0;
        end
        else if (timer_1sec > 28'd0) begin
            timer_1sec <= timer_1sec - 28'd1;
        end
        else begin
            one_hz = 1'b1;
        end
    end
end

always @* begin
    if ( count == 5'd0 ) begin
        expirou = 1'b1;
    end
    else if (one_hz_enable) begin
        count <= count - 5'd1;
        timer_1sec <= 28'd100_000_000;
        one_hz = 1'b0;
    end
end

assign expired = expirou;
assign one_hz_enable = one_hz;

endmodule

