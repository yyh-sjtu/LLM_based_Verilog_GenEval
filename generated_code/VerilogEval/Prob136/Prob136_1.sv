
module TopModule (
    input  wire clk,
    input  wire reset,
    input  wire w,
    output reg  z
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

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;  // Reset state
            z <= 0;              // Output is 0 when reset
        end else begin
            current_state <= next_state; // Update current state
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default assignments
        z = 0; // Output default
        next_state = current_state; // Default is to stay in the same state

        case (current_state)
            A: begin
                if (w == 0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            
            B: begin
                if (w == 0) begin
                    next_state = C;
                end else begin
                    next_state = D;
                end
            end
            
            C: begin
                if (w == 0) begin
                    next_state = E;
                end else begin
                    next_state = D;
                end
            end
            
            D: begin
                if (w == 0) begin
                    next_state = F;
                end else begin
                    next_state = A;
                end
            end
            
            E: begin
                if (w == 0) begin
                    next_state = E;
                end else begin
                    next_state = D;
                end
                z = 1; // Output z is 1 in state E
            end
            
            F: begin
                if (w == 0) begin
                    next_state = C;
                end else begin
                    next_state = D;
                end
                z = 1; // Output z is 1 in state F
            end

            default: begin
                next_state = A; // In case of unknown state, go to A
            end
        endcase
    end
endmodule