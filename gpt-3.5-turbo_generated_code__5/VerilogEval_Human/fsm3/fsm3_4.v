module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state <= 2'b00; // Reset to state A
        else
            state <= next_state;
    end
    
    always @(state or in)
    begin
        case (state)
            2'b00: // State A
                begin
                    if (in)
                        next_state = 2'b01; // Next state = B
                    else
                        next_state = 2'b00; // Next state = A
                    out = 1'b0; // Output = 0
                end
                
            2'b01: // State B
                begin
                    if (in)
                        next_state = 2'b01; // Next state = B
                    else
                        next_state = 2'b10; // Next state = C
                    out = 1'b0; // Output = 0
                end
                
            2'b10: // State C
                begin
                    if (in)
                        next_state = 2'b11; // Next state = D
                    else
                        next_state = 2'b00; // Next state = A
                    out = 1'b0; // Output = 0
                end
                
            2'b11: // State D
                begin
                    if (in)
                        next_state = 2'b01; // Next state = B
                    else
                        next_state = 2'b10; // Next state = C
                    out = 1'b1; // Output = 1
                end
        endcase
    end
    
endmodule

