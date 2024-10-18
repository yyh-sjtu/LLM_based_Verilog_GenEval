
module TopModule (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// State encoding
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

reg [2:0] state, next_state;

// State flip-flop
always @ (posedge clk or negedge resetn)
begin
    if (~resetn)
        state <= A;
    else
        state <= next_state;
end

// State transition and output logic
always @ (*)
begin
    case (state)
        A: begin
            if (r[0] && ~r[1] && ~r[2])
                next_state = B;
            else if (r[0] && ~r[1] && r[2])
                next_state = C;
            else if (~r[0] && ~r[1] && ~r[2])
                next_state = D;
            else
                next_state = A;
        end
        B: begin
            if (r[0])
                next_state = B;
            else
                next_state = A;
        end
        C: begin
            if (r[1])
                next_state = C;
            else
                next_state = A;
        end
        D: next_state = A;
    endcase
end

// Output assignment
always @ (*)
begin
    g[0] = (state == B) ? 1'b1 : 1'b0;
    g[1] = (state == C) ? 1'b1 : 1'b0;
    g[2] = 1'b0;
end

endmodule