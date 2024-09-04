
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

// State flip-flop
reg [2:0] state_reg, next_state;

// State transition logic
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        state_reg <= A;
    end else begin
        state_reg <= next_state;
    end
end

// State table
always @* begin
    case (state_reg)
        A: begin
            if (r[0] && !r[1] && !r[2]) next_state = B;
            else if (r[0] && !r[1] && !r[2]) next_state = B;
            else if (!r[0] && r[1]) next_state = C;
            else if (!r[0] && !r[1] && !r[2]) next_state = D;
            else next_state = A;
        end
        B: begin
            if (r[0]) next_state = B;
            else if (!r[0]) next_state = A;
            else next_state = B;
        end
        C: begin
            if (r[1]) next_state = C;
            else if (!r[1]) next_state = A;
            else next_state = C;
        end
        D: begin
            next_state = A;
        end
    endcase
end

// FSM outputs
always @* begin
    case (state_reg)
        A: g = 3'b000;
        B: g = 3'b001;
        C: g = 3'b010;
        D: g = 3'b000; // No grants in state D
        default: g = 3'b000;
    endcase
end

endmodule