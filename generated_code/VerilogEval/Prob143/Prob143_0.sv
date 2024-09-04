
module TopModule (
    input wire in,
    input wire [9:0] state,
    output reg [9:0] next_state,
    output reg out1,
    output reg out2
);

// State Definitions
parameter S0 = 10'b0000000001;
parameter S1 = 10'b0000000010;
parameter S2 = 10'b0000000100;
parameter S3 = 10'b0000001000;
parameter S4 = 10'b0000010000;
parameter S5 = 10'b0000100000;
parameter S6 = 10'b0001000000;
parameter S7 = 10'b0010000000;
parameter S8 = 10'b0100000000;
parameter S9 = 10'b1000000000;

always @(*) begin
    // Default outputs
    next_state = 10'b0000000000;
    out1 = 0;
    out2 = 0;
    
    case (state)
        S0: begin
            next_state = (in ? S1 : S0);
            out1 = 0; // Default
            out2 = 0; // Default
        end
        S1: begin
            next_state = (in ? S2 : S0);
            out1 = 0; // Default
            out2 = 0; // Default
        end
        S2: begin
            next_state = (in ? S3 : S0);
            out1 = 0; // Default
            out2 = 0; // Default
        end
        S3: begin
            next_state = (in ? S4 : S0);
            out1 = 0; // Default
            out2 = 0; // Default
        end
        S4: begin
            next_state = (in ? S5 : S0);
            out1 = 0; // Default
            out2 = 0; // Default
        end
        S5: begin
            next_state = (in ? S6 : S8);
            out1 = 0; // Default
            out2 = 0; // Default
        end
        S6: begin
            next_state = (in ? S7 : S9);
            out1 = 0; // Default
            out2 = 0; // Default
        end
        S7: begin
            next_state = (in ? S7 : S0);
            out1 = 0; // Default
            out2 = 1; // Special output
        end
        S8: begin
            next_state = (in ? S1 : S0);
            out1 = 1; // Special output
            out2 = 0; // Default
        end
        S9: begin
            next_state = (in ? S1 : S0);
            out1 = 1; // Special output
            out2 = 1; // Special output
        end
        default: begin
            next_state = S0; // Default state
            out1 = 0; // Default
            out2 = 0; // Default
        end
    endcase
end

endmodule