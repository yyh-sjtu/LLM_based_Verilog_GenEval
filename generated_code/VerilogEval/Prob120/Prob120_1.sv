
module TopModule (
    input wire clk,
    input wire reset,
    input wire in,
    output reg out
);

// State Encoding
typedef enum reg [1:0] {
    A = 2'b00,
    B = 2'b01,
    C = 2'b10,
    D = 2'b11
} state_t;

state_t current_state, next_state;

// State Transition Logic
always @(*) begin
    case (current_state)
        A: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = A;
            end
            out = 1'b0;
        end
        
        B: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
            out = 1'b0;
        end
        
        C: begin
            if (in) begin
                next_state = D;
            end else begin
                next_state = A;
            end
            out = 1'b0;
        end
        
        D: begin
            if (in) begin
                next_state = B;
            end else begin
                next_state = C;
            end
            out = 1'b1;
        end
        
        default: begin
            next_state = A;
            out = 1'b0; // Default output
        end
    endcase
end

// State Update Logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= A; // Reset to state A
        out <= 1'b0; // Output on reset
    end else begin
        current_state <= next_state; // Update state
    end
end

endmodule