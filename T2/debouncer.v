///////////////////////////////////////////////////////////////////////////////
//
// Pushbutton Syncronizer and Debounce Module
//
///////////////////////////////////////////////////////////////////////////////

module debounce ( 
    inout reset, 
    inout clock, 
    inout noisy, 
    output reg clean 
    );

    

    // debouncer
    reg [19:0] count;
    reg new_input;

    // debouncer
    always @(posedge clock)
    begin
        if (reset) begin 
            new_input <= noisy; 
            clean <= noisy; 
            count <= 20'd0;
        end
        else // clock rising edge
        begin 
            if (noisy != new_input) begin
                new_input <= noisy; 
                count <= 0;
            end
            else if (count == 20'd1_000_000) // 10 ms
                clean <= new_input;
            else 
                count <= count + 20'd1;
        end
    end

endmodule
