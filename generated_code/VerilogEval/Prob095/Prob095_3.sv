
module TopModule (
    input  clk,
    input  reset,
    output reg shift_ena
);

    // State declaration
    typedef enum reg [1:0] {
        IDLE     = 2'b00,
        ENABLE   = 2'b01,
        COUNT    = 2'b10,
        DONE     = 2'b11
    } state_t;

    // State variable
    state_t current_state, next_state;
    reg [1:0] counter; // 2-bits counter to count from 0 to 3

    // Sequential logic for state transition and counter
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            counter <= 2'd0;
            shift_ena <= 1'b1; // Enable shift for the initial 4 cycles
        end else begin
            current_state <= next_state;

            // Count only while in ENABLE state
            if (current_state == ENABLE) begin
                counter <= counter + 1'b1;
            end else if (current_state == DONE) begin
                shift_ena <= 1'b0; // Disable shift after 4 cycles
            end
        end
    end

    // Combinational logic for state transitions
    always @* begin
        // Default values
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (reset) begin
                    // Move to ENABLE state when reset is asserted
                    next_state = ENABLE;
                end
            end

            ENABLE: begin
                shift_ena = 1'b1; // Enable shift register
                if (counter == 2'd3) begin
                    // After 4 cycles, transition to DONE state
                    next_state = DONE;
                end
            end

            DONE: begin
                // Stay in DONE state, can transition back to IDLE based on reset
                if (reset) begin
                    next_state = IDLE; // Go back to IDLE on a new reset
                end
            end

            default: begin
                next_state = IDLE; // Default case, should never happen
            end
        endcase
    end

endmodule