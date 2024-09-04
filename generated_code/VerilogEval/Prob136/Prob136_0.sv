
module TopModule (
    input  clk,
    input  reset,
    input  w,
    output reg z
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State variable
    state_t current_state, next_state;

    // Combinational logic for next state
    always_comb begin
        case (current_state)
            A: begin
                if (w == 0) next_state = B;
                else next_state = A;
            end
            
            B: begin
                if (w == 0) next_state = C;
                else next_state = D;
            end
            
            C: begin
                if (w == 0) next_state = E;
                else next_state = D;
            end
            
            D: begin
                if (w == 0) next_state = F;
                else next_state = A;
            end
            
            E: begin
                if (w == 0) next_state = E;
                else next_state = D;
            end
            
            F: begin
                if (w == 0) next_state = C;
                else next_state = D;
            end
            
            default: next_state = A; // Default to state A
        endcase
    end

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            z <= 0; // Assuming z is 0 by default on reset
        end else begin
            current_state <= next_state;
        end
    end

    // Output logic
    always_ff @(posedge clk) begin
        // Output z is 1 if in state E, else 0
        if (current_state == E) 
            z <= 1;
        else 
            z <= 0;
    end

endmodule