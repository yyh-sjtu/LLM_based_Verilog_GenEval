
module TopModule (
    input clk,
    input reset,
    input in,
    output reg done
);

    // State Encoding
    typedef enum reg [2:0] {
        IDLE        = 3'b000,
        START_BIT   = 3'b001,
        DATA_BITS   = 3'b010,
        STOP_BIT    = 3'b011,
        ERROR       = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    // FSM State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 1'b0;
            bit_count <= 3'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        // Default Output
        done = 1'b0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin  // Start Bit Detected
                    next_state = START_BIT;
                end
            end

            START_BIT: begin
                next_state = DATA_BITS;
                bit_count = 3'b0; // Reset bit counter
            end

            DATA_BITS: begin
                if (bit_count < 3'b111) begin
                    bit_count = bit_count + 1;  // Increment bit counter
                end
                else begin
                    next_state = STOP_BIT; // Move to stop bit state after 8 data bits
                end
            end

            STOP_BIT: begin
                if (in == 1'b1) begin  // Check for Stop Bit
                    done = 1'b1;      // Indicate that valid byte is received
                    next_state = IDLE; // Back to Idle state
                end else begin
                    next_state = ERROR; // Stop bit error, go to error state
                end
            end
            
            ERROR: begin
                if (in == 1'b1) begin  // Wait for a stop bit to end error
                    next_state = IDLE;  // Return to idle after stop
                end
                // Remain in ERROR state until a stop bit is detected
            end
            
            default: next_state = IDLE; // Default case to handle any unexpected states
        endcase
    end

endmodule