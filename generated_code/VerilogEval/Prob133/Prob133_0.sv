
module TopModule(
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    
    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,  // Reset State
        B = 2'b01   // Counting State
    } state_t;

    state_t current_state, next_state;
    
    // Cycle counter for state B
    reg [1:0] count;     // Counting w = 1 in last three cycles
    reg [1:0] cycle;     // Counts current cycles within state B
    reg [2:0] w_history;  // Shift register to track w's last three values

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            count <= 2'b00;
            cycle <= 2'b00;
            z <= 1'b0;
            w_history <= 3'b000;
        end else begin
            current_state <= next_state;
            // Update z based on the count and cycle
            if (next_state == B && cycle == 3) begin
                z <= (count == 2) ? 1'b1 : 1'b0; // Set z based on count
            end else if (next_state != B) begin
                z <= 1'b0; // Reset z when not in state B
            end
        end
    end

    // Next state logic
    always @* begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B; // Transition to state B when s = 1
                    count = 2'b00;  // Reset count
                    cycle = 2'b00;  // Reset cycle counter
                    w_history = 3'b000;  // Reset history
                end else begin
                    next_state = A; // Stay in state A while s = 0
                end
            end
            B: begin
                if (cycle < 3) begin
                    w_history = {w_history[1:0], w}; // Shift w into the history
                    count = count + w; // Count the number of 1s
                    cycle = cycle + 1;  // Increment cycle
                    next_state = B; // Stay in state B
                end else begin
                    // After 3 cycles, reset count and cycle
                    count = (w_history[0] + w_history[1] + w_history[2]);
                    cycle = 0; // Reset cycle counter
                    next_state = B; // Remain in state B
                end
            end
            default: begin
                next_state = A; // Default to state A
            end
        endcase
    end

endmodule