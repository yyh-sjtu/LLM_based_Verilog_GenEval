
module TopModule (
    input  wire clk,
    input  wire reset,
    input  wire [7:0] in,
    output reg done
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and done signal
    always @(*) begin
        // Default values
        done = 0;
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                // Wait for the first byte with in[3] = 1
                if (in[3] == 1) begin
                    next_state = BYTE1;
                end
            end
            
            BYTE1: begin
                // Move to the next state once we receive the first byte
                next_state = BYTE2;
            end
            
            BYTE2: begin
                // Move to the next state after the second byte
                next_state = BYTE3;
            end
            
            BYTE3: begin
                // Signal done for one cycle, then return to the idle state
                done = 1;
                next_state = IDLE;  
            end
            
            default: begin
                next_state = IDLE; // Default case to avoid latches
            end
        endcase
    end

endmodule