
module TopModule (
    input wire clk,
    input wire resetn,
    input wire [2:0] r,
    output reg [2:0] g
);

    // State encoding
    typedef enum reg [1:0] {
        S_A = 2'b00, // State A
        S_B = 2'b01, // State B
        S_C = 2'b10  // State C
    } state_t;

    // State and next state variables
    state_t current_state, next_state;

    // FSM next state logic
    always @(*) begin
        case (current_state)
            S_A: begin
                if (r[0])
                    next_state = S_B; // Grant to device 0
                else if (r[1])
                    next_state = S_C; // Grant to device 1
                else
                    next_state = S_A; // Stay in state A
            end
            
            S_B: begin
                if (r[0]) 
                    next_state = S_B; // Stay in state B
                else
                    next_state = S_A; // Go back to state A
            end
            
            S_C: begin
                if (r[1]) 
                    next_state = S_C; // Stay in state C
                else
                    next_state = S_A; // Go back to state A
            end
        
            default: next_state = S_A; // Default to state A
        endcase
    end

    // FSM state flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= S_A; // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic for grant signals
    always @(*) begin
        // Default to no grants
        g = 3'b000; 
        case (current_state)
            S_B: g[0] = 1'b1; // Grant to device 0
            S_C: g[1] = 1'b1; // Grant to device 1
            // In state A, no grants are active
            default: g = 3'b000;
        endcase
    end

endmodule