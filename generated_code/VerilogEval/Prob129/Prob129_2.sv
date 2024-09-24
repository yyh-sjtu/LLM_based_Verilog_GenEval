
module TopModule (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    // State encoding
    typedef enum reg [1:0] {
        S0 = 2'b00, // Initial state
        S1 = 2'b01, // First '1' detected
        S2 = 2'b10  // '10' detected
    } state_t;

    // Current and next state registers
    state_t current_state, next_state;

    // Asynchronous reset
    always @(negedge aresetn) begin
        current_state <= S0; // Reset to S0 on aresetn
        z <= 1'b0;           // Output reset to 0
    end

    // State transition on positive edge of clk
    always @(posedge clk) begin
        if (aresetn) begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1; // Move to S1 on x = 1
                end else begin
                    next_state = S0; // Stay in S0 if x = 0
                end
                z = 1'b0; // z is low in S0
            end

            S1: begin
                if (~x) begin
                    next_state = S2; // Move to S2 on x = 0
                end else begin
                    next_state = S1; // Stay in S1 if x = 1
                end
                z = 1'b0; // z is low in S1
            end

            S2: begin
                if (x) begin
                    next_state = S1; // Move back to S1 on x = 1
                    z = 1'b1;        // Output detected '101'
                end else begin
                    next_state = S0; // Move back to S0 on x = 0
                    z = 1'b0;        // z is low in S2 while waiting
                end
            end
            
            default: begin
                next_state = S0; // Default state
                z = 1'b0;        // Default output
            end
        endcase
    end
endmodule