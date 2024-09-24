
module TopModule (
    input clk,
    input reset,
    input data,
    input done_counting,
    input ack,
    output reg shift_ena,
    output reg counting,
    output reg done
);
    
    // State encoding
    typedef enum reg [2:0] {
        IDLE,        // Waiting for pattern 1101
        SHIFTING,    // Shifting in 4 bits
        COUNTING,    // Waiting for done counting
        DONE         // Timer timed out
    } state_t;

    state_t current_state, next_state;
    reg [3:0] shift_counter; // Counter to manage shift operation

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @ (*) begin
        // Default assignments for outputs
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = current_state; // Default to hold current state
        
        case (current_state)
            IDLE: begin
                // Wait for the sequence 1101 
                if (shift_counter == 3) begin
                    // After receiving 1101
                    next_state = SHIFTING;
                    shift_counter = 0; // Reset for post pattern shifting
                end else if (data) begin
                    shift_counter = shift_counter + 1; // Increment for each bit
                end else begin
                    shift_counter = 0; // Reset on mismatch
                end
            end
            
            SHIFTING: begin
                // Shift for 4 clock cycles
                shift_ena = 1;
                if (shift_counter < 3) begin
                    shift_counter = shift_counter + 1;
                end else begin
                    next_state = COUNTING;
                    counting = 1; // Indicate that we are counting
                end
            end
            
            COUNTING: begin
                if (done_counting) begin
                    next_state = DONE; // Move to done state
                end
            end

            DONE: begin
                done = 1; // Notify user timer has timed out
                if (ack) begin
                    next_state = IDLE; // Reset to wait for the next pattern
                end
            end
            
            default: next_state = IDLE; // Default state
        endcase
    end

endmodule