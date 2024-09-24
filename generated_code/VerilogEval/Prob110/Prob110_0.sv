
module TopModule (
    input clk,
    input areset,
    input j,
    input k,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON  = 2'b01
    } state_t;
    
    state_t current_state, next_state;
    
    // Sequential logic for state transition
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF; // Reset to OFF state
        end else begin
            current_state <= next_state; // Transition to next state
        end
    end

    // Combinatorial logic for next state and output logic
    always @(*) begin
        case (current_state)
            OFF: begin
                out = 1'b0; // Output is 0 in OFF state
                if (j == 1'b1) begin
                    next_state = ON; // Transition to ON state if j=1
                end else begin
                    next_state = OFF; // Stay in OFF state if j=0
                end
            end
            
            ON: begin
                out = 1'b1; // Output is 1 in ON state
                if (k == 1'b1) begin
                    next_state = OFF; // Transition to OFF state if k=1
                end else begin
                    next_state = ON; // Stay in ON state if k=0
                end
            end
            
            default: begin
                out = 1'b0; // Default output (should not be reached)
                next_state = OFF; // Default next state
            end
        endcase
    end

endmodule