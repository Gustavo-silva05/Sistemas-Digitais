module logica_comb (
    input clock,
    input reset,
    input break,
    input hidden_sw,
    input ignition,
    output fuel_pump
);
reg fuel;

always @(posedge clock ) begin
    if (reset) begin
        fuel <= 1'b0;
    end
    else begin
        if (ignition) begin
            if (break == 1'b1 && hidden_sw == 1'b1) begin
                fuel <= 1'b1;
            end
        end
        else begin
            fuel <= 1'b0;
        end
    end
end

assign fuel_pump = fuel;

endmodule   