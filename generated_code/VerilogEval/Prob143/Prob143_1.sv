
module TopModule (
    input wire in,
    input wire [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

// Next state logic
always @(*) begin
    // Default next_state and outputs
    next_state = 10'b0000000000; 
    out1 = 0;
    out2 = 0;
    
    case (1'b1) // This will check which state is currently active
        state[0]: begin // S0
            next_state[0] = (in == 0) ? 1 : 0; // S0 when in=0, S1 when in=1
            next_state[1] = (in == 1) ? 1 : 0; 
        end
        state[1]: begin // S1
            next_state[0] = 1; // S0
            next_state[2] = (in == 1) ? 1 : 0; // S2 
        end
        state[2]: begin // S2
            next_state[0] = 1; // S0
            next_state[3] = (in == 1) ? 1 : 0; // S3 
        end
        state[3]: begin // S3
            next_state[0] = 1; // S0
            next_state[4] = (in == 1) ? 1 : 0; // S4 
        end
        state[4]: begin // S4
            next_state[0] = 1; // S0
            next_state[5] = (in == 1) ? 1 : 0; // S5 
        end
        state[5]: begin // S5
            next_state[8] = 1; // S8 when in = 0
            next_state[6] = (in == 1) ? 1 : 0; // S6 
        end
        state[6]: begin // S6
            next_state[9] = 1; // S9 when in = 0
            next_state[7] = (in == 1) ? 1 : 0; // S7 
        end
        state[7]: begin // S7
            next_state[0] = 1; // S0
            // Stay in S7 when in = 1
            out2 = 1; // Set output: (0, 1) 
        end
        state[8]: begin // S8
            next_state[0] = 1; // S0
            next_state[1] = (in == 1) ? 1 : 0; // S1
            out1 = 1; // Set output: (1, 0)
        end
        state[9]: begin // S9
            next_state[0] = 1; // S0
            next_state[1] = (in == 1) ? 1 : 0; // S1
            out1 = 1; // Set output: (1, 1)
            out2 = 1;
        end
    endcase
end

endmodule