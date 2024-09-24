
module TopModule (
    input clk,
    input reset,
    input data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input ack
);
    // State Definitions
    typedef enum logic [2:0] {
        IDLE,         // Waiting for the start pattern
        CHECK,        // Shifting in bits to check for 1101
        DELAY_SHIFT,  // Shifting in the delay bits
        COUNTING,     // Counting down the timer
        DONE          // Timer completed, waiting for acknowledgment
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;           // The timer delay value (4 bits)
    reg [12:0] countdown;      // 1000 cycles max, 12 bits for counter
    reg [9:0] time_remaining;  // Holds the current time remaining in cycles

    // Synchronous Reset and State Transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            done <= 0;
            counting <= 0;
            count <= 4'b0000;
            countdown <= 0;
            time_remaining <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 0;
                counting = 0;
                // Start searching for the pattern 1101
                if (data) begin
                    next_state = CHECK; // first detection of '1'
                end
            end
            
            CHECK: begin
                // Shift in bits to check for pattern 1101
                // Implementing pattern detection logic here
                static logic [3:0] shift_register = 0;
                shift_register = {shift_register[2:0], data}; // Shift left and include next bit
            
                if (shift_register == 4'b1101) begin
                    next_state = DELAY_SHIFT; // If pattern detected, move to delay shift
                end
            end
            
            DELAY_SHIFT: begin
                // Shift in 4 bits to determine delay
                static logic [3:0] delay_buffer = 0;
                delay_buffer = {delay_buffer[2:0], data}; // Shift newly received delay bits
                delay = delay_buffer;
                
                if (delay_buffer == 4'b1111) begin // Check if we have shifted in 4 bits
                    countdown = (delay + 1) * 1000; // Set countdown cycles
                    time_remaining = delay;         // Set time remaining based on delay
                    next_state = COUNTING;         // Move to counting state
                end
            end
            
            COUNTING: begin
                if (countdown > 0) begin
                    countdown <= countdown - 1; // Decrement countdown
                    count <= time_remaining; // Output remaining time

                    // Handle time remaining logic
                    if (countdown % 1000 == 0 && time_remaining > 0) 
                        time_remaining <= time_remaining - 1; // Decrease remaining time after every 1000 cycles
                    
                end else begin
                    next_state = DONE; // Transition to done when countdown is zero
                end
            end
            
            DONE: begin
                done = 1;  // Signal that counting is done
                // Wait for acknowledgment from user
                if (ack) begin
                    next_state = IDLE; // Reset state machine
                end
            end
            
            default: next_state = IDLE; // Default case to avoid latches
        endcase
    end

endmodule