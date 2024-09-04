
module TopModule (
    input wire in,
    input wire [1:0] state,
    output reg [1:0] next_state,
    output reg out
);
    
    always @(*) begin
        // Default values
        next_state = state; // Default to stay in the current state
        out = 0;            // Default output
        
        case (state)
            2'b00: begin // State A
                if (in == 0) begin
                    next_state = 2'b00; // Stay in A
                end else begin
                    next_state = 2'b01; // Transition to B
                end
                out = 0; // Output for state A
            end
            
            2'b01: begin // State B
                if (in == 0) begin
                    next_state = 2'b10; // Transition to C
                end else begin
                    next_state = 2'b01; // Stay in B
                end
                out = 0; // Output for state B
            end
            
            2'b10: begin // State C
                if (in == 0) begin
                    next_state = 2'b00; // Transition to A
                end else begin
                    next_state = 2'b11; // Transition to D
                end
                out = 0; // Output for state C
            end
            
            2'b11: begin // State D
                if (in == 0) begin
                    next_state = 2'b10; // Transition to C
                end else begin
                    next_state = 2'b01; // Transition to B
                end
                out = 1; // Output for state D
            end
            
            default: begin
                next_state = 2'b00; // Default case
                out = 0;
            end
        endcase
    end

endmodule