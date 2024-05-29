module gerador_sirene(
    input clock, reset,
    input eneble_siren, two_hz_enable,
    output siren, color
);
reg sirene;
reg cor;

always @(posedge clock ) begin
    if (reset) begin
        sirene <= 1'b0;
        cor <= 1'b0;
    end
end
always@* begin
    if (eneble_siren) begin
        sirene <= 1'b1;
    end
    if (two_hz_enable) begin
        cor <= ~cor;
    end
end


assign siren = sirene;
assign color = cor;

endmodule