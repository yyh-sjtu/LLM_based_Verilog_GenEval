
module TopModule (
    input  wire clk,
    input  wire in,
    input  wire reset,
    output reg  [7:0] out_byte,
    output reg  done
);

    // State Declaration
    typedef enum reg [2:0] {
        IDLE,         // Waiting for start bit
        START_BIT,    // Start bit detected
        DATA_BITS,    // Receiving data bits
        STOP_BIT,     // Checking stop bit
        ERROR         // Error state, if any
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_count;  // Count of received data bits

    // Synchronous Reset and State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 0;
            bit_count <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // State Logic
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 0;

        case (current_state)
            IDLE: begin
                if (in == 0) begin // Start bit detected
                    next_state = START_BIT;
                end
            end

            START_BIT: begin
                next_state = DATA_BITS; // Move to receive data bits
                bit_count = 0; // Reset bit count
            end

            DATA_BITS: begin
                if (bit_count < 8) begin
                    out_byte[bit_count] = in; // Store received bit
                    bit_count = bit_count + 1; // Move to the next bit
                end else begin
                    next_state = STOP_BIT; // Move to check stop bit after 8 data bits
                end
            end

            STOP_BIT: begin
                if (in == 1) begin // Stop bit checked
                    done = 1; // Signal that data byte is valid
                    next_state = IDLE; // Return to idle state to wait for next byte
                end else begin
                    next_state = ERROR; // Transition to error state if stop bit not found
                end
            end
            
            ERROR: begin
                if (in == 1) begin // If stop bit appears regardless of the state
                    next_state = IDLE; // Return to idle state to reset
                end else begin
                    next_state = ERROR; // Stay in error
                end
            end
            
            default: begin
                next_state = IDLE; // Default case
            end
        endcase
    end

endmodule