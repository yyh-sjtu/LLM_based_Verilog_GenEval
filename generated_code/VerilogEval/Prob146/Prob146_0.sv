module TopModule (
    input  logic clk,
    input  logic in,
    input  logic reset,
    output logic [7:0] out_byte,
    output logic done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE         = 3'b000,
        STARTBIT     = 3'b001,
        DATA         = 3'b010,
        STOPBIT      = 3'b011
    } state_t;

    // State registers
    state_t current_state, next_state;
    logic [3:0] bit_count; // To count data bits received

    // Sequential logic to update the current state
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            bit_count <= 4'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (next_state == DATA) begin
                out_byte[bit_count] <= in; // Capture data bit
                bit_count <= bit_count + 1;
                done <= 1'b0; // Reset done while receiving data
            end else if (next_state == STOPBIT) begin
                done <= 1'b1; // Stop bit received, set done
                if (in == 1'b1) begin
                    // If stop bit is valid, reset counters for next byte
                    bit_count <= 4'b0; 
                end
            end else if (next_state == IDLE) begin
                if (in == 1'b0) begin
                    // Reset done when entering idle
                    done <= 1'b0;
                end
            end
        end
    end

    // Combinational logic to determine the next state
    always_comb begin
        // Default state transitions
        next_state = current_state;
        
        case (current_state)
            IDLE: begin
                // Wait for a start bit (0)
                if (in == 1'b0) 
                    next_state = STARTBIT;
            end

            STARTBIT: begin
                // Move to data when detecting start bit
                next_state = DATA;
            end

            DATA: begin
                // Check if we have received all 8 data bits
                if (bit_count == 4'd7) 
                    next_state = STOPBIT; // Expecting stop bit next
            end

            STOPBIT: begin
                // Check if stop bit is valid (1)
                if (in == 1'b1) begin
                    // Transition back to IDLE after a successful stop bit
                    next_state = IDLE; 
                end else begin
                    // Stay in STOPBIT if received incorrect stop bit
                    next_state = STOPBIT; 
                end
            end

            default: begin
                // Fallback, should not happen
                next_state = IDLE;
            end
        endcase
    end

endmodule

