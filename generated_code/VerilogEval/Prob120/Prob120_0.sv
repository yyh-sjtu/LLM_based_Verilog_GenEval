
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

typedef enum logic [1:0] {A, B, C, D} state_t;
reg [1:0] state, next_state;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    case (state)
        A: begin
            next_state = (in) ? B : A;
            out = 0;
        end
        B: begin
            next_state = (in) ? B : C;
            out = 0;
        end
        C: begin
            next_state = (in) ? D : A;
            out = 0;
        end
        D: begin
            next_state = (in) ? B : C;
            out = 1;
        end
    endcase
end

endmodule