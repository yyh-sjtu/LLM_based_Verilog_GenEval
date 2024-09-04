
module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output reg [23:0] out_bytes,
    output reg done
);

    // State Declaration
    typedef enum reg [1:0] {
        IDLE,
        COLLECT_BYTE1,
        COLLECT_BYTE2,
        COLLECT_BYTE3
    } state_t;

    state_t current_state, next_state;

    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        done = 0; // Default done is low
        next_state = current_state; // Default to hold the state

        case (current_state)
            IDLE: begin
                if (in[3]) begin // Check if current byte indicates start of new message
                    next_state = COLLECT_BYTE1;
                end
            end
            
            COLLECT_BYTE1: begin
                out_bytes[23:16] = in; // Store first byte
                next_state = COLLECT_BYTE2;
            end
            
            COLLECT_BYTE2: begin
                out_bytes[15:8] = in; // Store second byte
                next_state = COLLECT_BYTE3;
            end
            
            COLLECT_BYTE3: begin
                out_bytes[7:0] = in; // Store third byte
                done = 1; // Signal that message is done at next clock edge
                next_state = IDLE; // Go back to IDLE state
            end
            
            default: begin
                next_state = IDLE; // Fallback to IDLE for other states
            end
        endcase
    end

endmodule