
module TopModule (
    input clk,
    input reset,
    input in,
    output reg [7:0] out_byte,
    output reg done
);

    // State Encoding
    typedef enum reg [1:0] {
        IDLE       = 2'b00,
        RECEIVE    = 2'b01,
        CHECK_STOP = 2'b10
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count; // Count received bits (0 to 7)

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            out_byte <= 0;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                if (bit_count < 7) begin
                    bit_count <= bit_count + 1;
                end
            end else if (next_state == IDLE) begin
                bit_count <= 0; // Reset bit count when entering IDLE
            end
            // Reset done signal each clock cycle unless it is getting asserted
            if (next_state == CHECK_STOP) begin
                done <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        // Default values
        next_state = current_state;
        done = 0;

        case (current_state)
            IDLE: begin
                if (in == 0) begin // Looking for start bit (0)
                    next_state = RECEIVE;
                end
            end
            
            RECEIVE: begin
                if (bit_count == 7) begin // Received all 8 bits
                    next_state = CHECK_STOP;
                end
                // Parallel load incoming bits into out_byte
                out_byte[bit_count] = in; // Collect bits
            end
            
            CHECK_STOP: begin
                if (in == 1) begin // Check for stop bit (1)
                    done = 1; // Assert done signal
                    next_state = IDLE; // Go back to waiting for start bit
                end else begin
                    // If the stop bit is not received, stay in this state
                    next_state = CHECK_STOP;
                end
            end
            
            default: begin
                next_state = IDLE; // Safe state
            end
        endcase
    end

endmodule