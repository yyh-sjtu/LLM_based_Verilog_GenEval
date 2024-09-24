
module TopModule (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    // FSM states
    typedef enum reg [1:0] {
        STATE_A = 2'b00, // Starting state (reset state)
        STATE_B = 2'b01, // After reset, ready to detect x pattern
        STATE_C = 2'b10, // Detected x pattern 1, 0, 1
        STATE_D = 2'b11  // Monitoring y after detecting g
    } state_t;

    state_t current_state, next_state;

    // Buffer for x inputs
    reg [2:0] x_history; // 3 bits to hold last three x inputs
    reg [1:0] y_count;   // Counter for y input checks

    // State transition logic
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            // Asynchronous reset
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            x_history <= 3'b000;
            y_count <= 0;
        end else begin
            // Sequential logic on clock edge
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        // Default states
        next_state = current_state;
        f = 0; // Default output
        g = g; // Default keep g state

        case (current_state)
            STATE_A: begin
                // Reset state, wait for resetn to be de-asserted
                next_state = STATE_B; // Move to STATE_B after resetn de-asserted
            end
            
            STATE_B: begin
                // Set f to 1 for the next clock cycle
                f = 1; 
                x_history = {x_history[1:0], x}; // Shift input x into history
                if (x_history == 3'b101) begin // Check if x has produced 1, 0, 1
                    next_state = STATE_C;
                end
            end
            
            STATE_C: begin
                // Check y after detecting pattern 1, 0, 1
                next_state = STATE_D;
                g = 0;  // Reset g, will check logic in STATE_D
                y_count = 0; // Reset y counter
            end

            STATE_D: begin
                // Monitor y input
                if (y) begin
                    g = 1; // Set g to 1 permanently
                    next_state = STATE_D; // Stay in this state
                end else if (y_count < 2) begin
                    y_count = y_count + 1; // Increment y count
                    next_state = STATE_D; // Stay in this state
                end else begin
                    g = 0; // Set g to 0 permanently as y did not go high in 2 cycles
                    next_state = STATE_D; // Stay in this state
                end
            end
        endcase
    end

endmodule