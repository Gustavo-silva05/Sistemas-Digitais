`timescale 1ns/1ps

module tb_sirene;

reg clock, reset;
reg eneble_siren, two_hz_enable;
wire siren, color;

gerador_sirene alarme (
    .clock(clock), .reset(reset),
    .eneble_siren(eneble_siren), .two_hz_enable(two_hz_enable),
    .siren(siren), .color(color)
);

localparam PERIOD = 10;

always #(PERIOD/2) clock = ~clock;

initial begin
    clock <= 1'b0;
    reset <= 1'b1;
    #PERIOD;
    reset <= 1'b0;
    eneble_siren <= 1'b1;
    repeat (10) begin
        #PERIOD;
    end
    two_hz_enable <= 1'b1;
    #PERIOD
    two_hz_enable <= 1'b0;
    repeat (10) begin
        #PERIOD;
    end
    two_hz_enable <= 1'b1;
    #PERIOD;
    two_hz_enable <= 1'b0;
    repeat (10) begin
        #PERIOD;
    end
    eneble_siren <= 1'b0;
    #PERIOD;
end

endmodule