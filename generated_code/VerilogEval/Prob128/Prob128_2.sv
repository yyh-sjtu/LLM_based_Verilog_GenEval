
module TopModule (
    input     clk,
    input     reset,
    input     [7:0] in,
    output reg done
);

    // Define states for the FSM
    typedef enum reg [1:0] {
        IDLE        = 2'b00,
        BYTE1       = 2'b01,
        BYTE2       = 2'b10,
        BYTE3       = 2'b11
    } state_t;

    state_t current_state, next_state;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // FSM logic
    always @(*) begin
        // Default output and next state
        done = 0;
        next_state = current_state;

        case (current_state)
            IDLE: begin
                if (in[3] == 1) begin
                    next_state = BYTE1; // Found start of message
                end
            end
            
            BYTE1: begin
                next_state = BYTE2; // Received first byte, move to second
            end
            
            BYTE2: begin
                next_state = BYTE3; // Received second byte, move to third
            end
            
            BYTE3: begin
                done = 1;           // Message completed
                next_state = IDLE;  // Go back to IDLE to wait for the next message
            end
            
            default: begin
                next_state = IDLE; // In case of an undefined state
            end
        endcase
    end

endmodule