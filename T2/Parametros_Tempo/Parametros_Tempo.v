module Parametros_Tempo(
    input [1:0] time_param_sel, 
    input [1:0] interval,
    input [3:0] time_value,
    input reprogram, 
    input clock, 
    input reset,
    output [4:0] value
);
reg [4:0] T_ARM_DELAY;
reg [4:0] T_DRIVER_DELAY;
reg [4:0] T_PASSAGER_DELAY;
reg [4:0] T_ALARM_ON;
reg [4:0] valor;


always @(posedge clock) begin
    if (reset) begin
        T_ARM_DELAY <= 5'b00110;
        T_DRIVER_DELAY <= 5'b01000;
        T_PASSAGER_DELAY <= 5'b01111;
        T_ALARM_ON <= 5'b01010;
    end
    case (interval)
        2'b00: valor <= T_ARM_DELAY;
        2'b01: valor <= T_DRIVER_DELAY;
        2'b10: valor <= T_PASSAGER_DELAY;
        2'b11: valor <= T_ALARM_ON;
    endcase
end

always @* begin
    if (reprogram) begin
        case (time_param_sel)
            2'b00: T_ARM_DELAY <= time_value;
            2'b01: T_DRIVER_DELAY <= time_value;
            2'b10: T_PASSAGER_DELAY <= time_value;
            2'b11: T_ALARM_ON <= time_value;
        endcase 
    end
end

assign value = valor;



endmodule