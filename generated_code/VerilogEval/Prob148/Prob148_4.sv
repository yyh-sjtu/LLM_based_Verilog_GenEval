
module TopModule (
    input       clk,
    input       resetn,
    input [2:0] r, // 3-bit request input
    output reg [2:0] g // 3-bit grant output
);
    
    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;
    
    state_t current_state, next_state;
    
    // State Flip-Flops
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A; // reset to state A
        end else begin
            current_state <= next_state; // update state
        end
    end
    
    // Next State Logic
    always_comb begin
        // Default next state
        next_state = current_state;

        // Grant outputs
        g = 3'b000; // Clear grants by default
        case (current_state)
            A: begin
                if (r[0]) begin
                    next_state = B;
                end else if (r[1]) begin
                    next_state = C;
                end else if (r[2]) begin
                    next_state = A; // stays in A as there is no grant
                end
            end
            
            B: begin
                g[0] = 1; // Grant for device 0
                if (!r[0]) begin
                    next_state = A; // go back to A if r[0] is not requested
                end else begin
                    next_state = B; // remain in B if r[0] is still requested
                end
            end
            
            C: begin
                g[1] = 1; // Grant for device 1
                if (!r[1]) begin
                    next_state = A; // go back to A if r[1] is not requested
                end else begin
                    next_state = C; // remain in C if r[1] is still requested
                end
            end
            
            default: begin
                next_state = A; // Fallback to A for safety
            end
        endcase
    end

endmodule