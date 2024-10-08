`timescale 1ns/1ps

module tb_comb ();
reg clock;
reg reset;
reg break;
reg hidden_sw;
reg ignition;
wire fuel_pump;


logica_comb combustivel (
    .clock(clock),
    .reset(reset),
    .break(break),
    .hidden_sw(hidden_sw),
    .ignition(ignition),
    .fuel_pump(fuel_pump)
);

localparam PERIOD = 10;
always #(PERIOD/2) clock <= ~clock;

initial begin
    clock <= 1'b0;
    reset <= 1'b1;
    #PERIOD;
    reset <= 1'b0;
    #PERIOD;
    ignition <= 1'b1;
    #PERIOD;
    hidden_sw <= 1'b1;
    #PERIOD;
    break <= 1'b1;
    #PERIOD;
    hidden_sw <= 1'b0;
    break <= 1'b0;
    repeat (100) begin
        #PERIOD;
    end
    ignition <= 1'b0;
    repeat (10) begin
        #PERIOD;
    end
end

endmodule