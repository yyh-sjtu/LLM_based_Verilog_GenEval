
module TopModule(
    input wire clk,
    input wire reset,
    input wire in,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START_BIT = 3'b001,
        DATA_BITS = 3'b010,
        STOP_BIT = 3'b011
    } state_t;

    state_t current_state, next_state;
    
    // Counter for the number of received data bits
    reg [3:0] data_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            data_counter <= 0;
        end else begin
            current_state <= next_state;
            // Output done signal after receiving a complete byte
            if (current_state == STOP_BIT) begin
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    always @* begin
        // Default next state
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin // Start bit detected
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                // Transition to DATA_BITS after detecting the start bit
                next_state = DATA_BITS;
                data_counter = 0; // Reset data counter
            end
            DATA_BITS: begin
                if (data_counter < 4'd7) begin
                    data_counter = data_counter + 1; // Next data bit
                end else begin
                    // Last data bit received, move to stop bit state
                    next_state = STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1'b1) begin // Check for stop bit
                    next_state = IDLE; // Go back to idle after correct stop bit
                end else begin
                    // Stay in STOP_BIT state until we get a valid stop bit
                    next_state = STOP_BIT;
                end
            end
            default: begin
                next_state = IDLE; // Fallback
            end
        endcase
    end

endmodule