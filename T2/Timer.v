module Timer(
    input clock,
    input reset,
    input [3:0] value,
    input start_timer,
    output expired,
    output one_hz_enable, two_hz_enable,
    output [3:0] counter
);
reg [3:0] count;
reg [28:0] timer_1sec;
reg expirou;
reg one_hz, two_hz;

always @(posedge clock ) begin
    if (reset) begin
        timer_1sec <= 29'd100_000_000;
        expirou = 1'b0;
        count <= 4'd0;
    end
    else begin
        if (start_timer) begin
            expirou = 1'b0;
            count <= value;
            timer_1sec <= 29'd200_000_000;
        end
        else begin
            if (count > 4'd0) begin
                expirou <= 1'b0;
                if (timer_1sec > 29'd0) begin
                    two_hz <= 1'b0;
                    one_hz <= 1'b0;
                    if (timer_1sec == 29'd50_000_000) begin
                        one_hz <= 1'b1;
                        count <= count - 5'd1;
                        timer_1sec <= timer_1sec - 29'd1;
                    end
                    else begin
                        timer_1sec <= timer_1sec - 29'd1;
                        one_hz <= 1'b0;
                    end
                end
                else begin
                    timer_1sec <= 29'd200_000_000;
                    two_hz <= 1'b1;
                    one_hz <= 1'b1;
                    count <= count - 5'd1;
                end
            end
            else begin
                expirou <= 1'b1;
                one_hz <= 1'b0;
                two_hz <= 1'b0;
            end
        end
    end
end

assign expired = expirou;
assign one_hz_enable = one_hz;
assign two_hz_enable = two_hz;
assign counter = count;

endmodule

