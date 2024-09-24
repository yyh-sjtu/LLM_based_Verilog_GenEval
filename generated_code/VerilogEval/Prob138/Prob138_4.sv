
module TopModule (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State variables
    state_t current_state, next_state;

    // Flip-flops for state memory
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A; // reset to state A
        end else begin
            current_state <= next_state; // update current state
        end
    end

    // Next state logic for the FSM
    always @(*) begin
        case (current_state)
            A: begin
                if (w) 
                    next_state = B;
                else 
                    next_state = A;
            end
            
            B: begin
                if (w) 
                    next_state = C;
                else 
                    next_state = D;
            end
            
            C: begin
                if (w) 
                    next_state = E;
                else 
                    next_state = D;
            end
            
            D: begin
                if (w) 
                    next_state = F;
                else 
                    next_state = A;
            end
            
            E: begin
                if (w) 
                    next_state = E;
                else 
                    next_state = D;
            end
            
            F: begin
                if (w) 
                    next_state = C;
                else 
                    next_state = D;
            end
            
            default: next_state = A; // Default case for safety
        endcase
    end

    // Output logic for z
    always @(*) begin
        case (current_state)
            A, B, D: z = 0; // Output z = 0 in states A, B, D
            C, E, F: z = 1; // Output z = 1 in states C, E, F
            default: z = 0; // Default case for safety
        endcase
    end

endmodule