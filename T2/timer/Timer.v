module Timer(
    input clock,
    input reset,
    input [4:0] value,
    input start_timer,
    output expired,
    output one_hz_enable, two_hz_enable
);
reg [4:0] count;
reg [28:0] timer_2sec;
reg expirou;
reg one_hz, two_hz;

always @(posedge clock ) begin
    if (reset) begin
        timer_2sec <= 29'd200_000_000;
        expirou = 1'b0;
    end
    else begin
        if (start_timer) begin
            expirou = 1'b0;
            count <= value;
        end
        else begin
            if (count > 5'd0) begin
                if (timer_2sec > 29'd0) begin
                    if (timer_2sec == 29'd100_000_000) begin
                        one_hz <= 1'b1;
                    end
                    else begin
                        timer_2sec <= timer_2sec - 29'd1;
                        one_hz <= 1'b0;
                    end
                end
                else begin
                    two_hz <= 1'b1;
                end
            end
        end
    end
end

assign expired = expirou;
assign one_hz_enable = one_hz;
assign two_hz_enable = two_hz;

endmodule

