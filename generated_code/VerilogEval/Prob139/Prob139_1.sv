
module TopModule (
    input  clk,
    input  resetn,
    input  x,
    input  y,
    output reg f,
    output reg g
);

    // State declaration
    typedef enum reg [2:0] {
        STATE_A,       // Initial reset state
        STATE_F_ON,    // f is set to 1 for one clock cycle
        STATE_X_CHECK, // Monitor x for 1, 0, 1 pattern
        STATE_G_ON,    // g is set to 1, monitoring y
        STATE_G_OFF    // g is set to 0
    } state_t;

    state_t current_state, next_state;

    // Counter for y monitoring
    reg [1:0] y_counter; // 2-bit counter to detect y within two clock cycles

    // Sequential Logic: State Transition
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f <= 0;
            g <= 0;
            y_counter <= 0;
        end
        else begin
            current_state <= next_state;
            if (current_state == STATE_F_ON) begin
                f <= 0; // Reset f after one cycle
            end
            else if (next_state == STATE_G_ON) begin
                g <= 1; // Set g when going to STATE_G_ON
            end
            else if (next_state == STATE_G_OFF) begin
                g <= 0; // Set g to 0 if y condition fails
            end
        end
    end

    // Combinational Logic: Next State Logic
    always @* begin
        next_state = current_state; // Default next state is the current state
        
        case (current_state)
            STATE_A: begin
                next_state = STATE_F_ON; // Move from reset state to f on state
            end
            STATE_F_ON: begin
                next_state = STATE_X_CHECK; // After f is set, check x
                f = 1; // Set f to 1 for one cycle
            end
            STATE_X_CHECK: begin
                if(x) begin
                    // Check for 1, 0, 1 pattern        
                    if (y_counter == 2'b01) begin
                        y_counter <= 0; // Reset counter for 1, 0, 1 pattern
                        next_state = STATE_G_ON; // Move to g On state
                    end
                    else begin
                        y_counter <= y_counter + 1; // Increment the counter for the first '1'
                    end
                end
                else begin
                    y_counter <= 2'b00; // Reset if x = 0
                end
            end
            STATE_G_ON: begin
                if (y) begin
                    y_counter <= 0; // Reset if y is 1, maintain g = 1
                end
                else if (y_counter < 2) begin
                    y_counter <= y_counter + 1; // Increment counter for y
                end
                if (y_counter == 2) begin
                    next_state = STATE_G_OFF; // If y is not 1 within two cycles
                end
            end
            STATE_G_OFF: begin
                // Remain in this state, g is set to 0 until reset
            end
        endcase
    end

endmodule