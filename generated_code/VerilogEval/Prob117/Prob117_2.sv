
module TopModule (
    input  wire clk,
    input  wire a,
    output reg [2:0] q
);

    // Internal state
    reg [2:0] next_state;

    always @(posedge clk) begin
        // Transition to the next state
        q <= next_state;
    end

    always @* begin
        // Default next state
        next_state = q;

        case (next_state)        
            3'b100: begin  // State 4
                if (a == 1'b1)
                    next_state = 3'b100; // Remain in state 4
                else
                    next_state = 3'b100; // Stay in state 4 for at least one cycle
            end
            3'b000: begin // State 0
                if (a == 1'b1)
                    next_state = 3'b100; // Goes to state 4 when a is 1
                else
                    next_state = 3'b000; // Remain in state 0
            end
            // Handle other states based on transitioning logic derived from the observed waveform
            default: begin
                if (a == 1'b1) 
                    next_state = 3'b100; // Go to state 4
                else
                    next_state = next_state + 1'b1; // Increment state 
            end
        endcase
    end

    initial begin
        q = 3'b000; // Initialize output
    end
endmodule