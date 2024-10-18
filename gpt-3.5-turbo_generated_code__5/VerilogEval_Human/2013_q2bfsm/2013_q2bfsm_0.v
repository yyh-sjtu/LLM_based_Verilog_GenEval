module fsm_control (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
    
    // Declare the states of the FSM
    typedef enum logic [1:0] {
        STATE_A,
        STATE_B,
        STATE_C,
        STATE_D,
        STATE_E
    } state_t;

    // Declare the registers for storing state and output values
    reg state_t current_state, next_state;
    reg f_reg, g_reg;
    
    // Initialize the registers
    initial begin
        current_state = STATE_A;
        next_state = STATE_A;
        f_reg = 0;
        g_reg = 0;
    end
    
    // Define the sequential logic for the FSM
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= STATE_A;
            f_reg <= 0;
            g_reg <= 0;
        end else begin
            current_state <= next_state;
            f_reg <= (current_state == STATE_B) ? 1'b1 : 1'b0;
            g_reg <= (current_state == STATE_E) ? 1'b1 :
                     (current_state == STATE_A || current_state == STATE_B) ? 1'b0 :
                     (current_state == STATE_D && y) ? 1'b0 :
                     (current_state == STATE_C && !y) ? 1'b1 :
                     g_reg;
        end
    end
    
    // Define the combinatorial logic for the next state calculation
    always @(*) begin
        case(current_state)
            STATE_A: begin
                next_state = (resetn) ? STATE_B : STATE_A;
            end
            STATE_B: begin
                next_state = STATE_C;
            end
            STATE_C: begin
                next_state = STATE_D;
            end
            STATE_D: begin
                next_state = (x == 1'b1 && y == 1'b0) ? STATE_E : STATE_A;
            end
            STATE_E: begin
                next_state = (y == 1'b1) ? STATE_E : STATE_A;
            end
            default: next_state = STATE_A;
        endcase
    end
    
    // Assign the outputs
    assign f = f_reg;
    assign g = g_reg;
    
endmodule

