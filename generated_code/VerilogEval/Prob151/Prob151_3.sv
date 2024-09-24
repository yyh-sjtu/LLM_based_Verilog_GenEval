
module TopModule (
    input wire clk,
    input wire reset,
    input wire data,
    input wire done_counting,
    input wire ack,
    output reg shift_ena,
    output reg counting,
    output reg done
);

    // State Encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        SEARCH = 3'b001,
        SHIFT = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Shift register to detect the pattern "1101"
    reg [3:0] shift_reg;

    // Sequential block for state transitions and output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            shift_reg <= 4'b0000;
            shift_ena <= 1'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;

            // Manage outputs based on current state
            case (current_state)
                IDLE: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                SEARCH: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
                SHIFT: begin
                    shift_ena <= 1'b1; // Enable shifting
                    counting <= 1'b0;
                end
                COUNTING: begin
                    shift_ena <= 1'b0; // Disable shifting
                    counting <= 1'b1;  // Enable counting
                end
                DONE: begin
                    shift_ena <= 1'b0; // Disable shifting
                    counting <= 1'b0;  // Disable counting
                    done <= 1'b1;      // Indicate done
                end
                default: begin
                    shift_ena <= 1'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end
            endcase
        end
    end

    // Combinatorial block for next state logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                // Look for the start sequence
                if (data) begin
                    shift_reg <= {shift_reg[2:0], data}; // Shift in the new bit
                    if (shift_reg == 4'b1101) begin
                        next_state = SHIFT;
                    end else begin
                        next_state = SEARCH;
                    end
                end else begin
                    shift_reg <= shift_reg; // Don't change
                    next_state = IDLE;
                end
            end
            
            SEARCH: begin
                shift_reg <= {shift_reg[2:0], data}; // Shift in the new bit
                if (shift_reg == 4'b1101) begin
                    next_state = SHIFT;
                end else begin
                    next_state = SEARCH;
                end
            end
            
            SHIFT: begin
                // After 4 cycles go to counting state
                if (shift_ena) begin
                    next_state = COUNTING;
                end else begin
                    next_state = SHIFT; // Stay in SHIFT state until 4 clock cycles are done
                end
            end
            
            COUNTING: begin
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNTING;
                end
            end
            
            DONE: begin
                if (ack) begin
                    next_state = IDLE; // Go back to idle state on acknowledgment
                end else begin
                    next_state = DONE;
                end
            end
            
            default: next_state = IDLE; // Default transition
        endcase
    end

endmodule