
module TopModule (
    input clk,
    input reset,
    input [7:0] in,
    output reg [23:0] out_bytes,
    output reg done
);

    // State definitions
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        BYTE1 = 2'b01,
        BYTE2 = 2'b10,
        BYTE3 = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [2:0] byte_counter;  // Counter for bytes received

    // Synchronous reset and state updates
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
            byte_counter <= 3'b000;
            out_bytes <= 24'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            
            // Update out_bytes and byte_counter
            if (next_state == BYTE1) begin
                out_bytes[23:16] <= in;
                byte_counter <= byte_counter + 1;
            end else if (next_state == BYTE2) begin
                out_bytes[15:8] <= in;
                byte_counter <= byte_counter + 1;   
            end else if (next_state == BYTE3) begin
                out_bytes[7:0] <= in;
                byte_counter <= byte_counter + 1;   
                done <= 1'b1;  // Signal that we received all 3 bytes
            end else begin
                done <= 1'b0;  // Reset done signal
            end
            
            // If we're done receiving, reset the byte counter
            if (done) begin
                byte_counter <= 3'b000;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in[3]) begin  // Message start detected
                    next_state = BYTE1;
                end else begin
                    next_state = IDLE;
                end
            end
            BYTE1: begin
                next_state = BYTE2;
            end
            BYTE2: begin
                next_state = BYTE3;
            end
            BYTE3: begin
                next_state = IDLE;  // Back to IDLE after receiving all bytes
            end
            default: next_state = IDLE;  // Default case
        endcase
    end

endmodule