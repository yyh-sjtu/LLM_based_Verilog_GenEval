module TopModule (
	input clk,
	input reset,
	input w,
	output z
);
    parameter A=0, B=1, C=2, D=3, E=4, F=5;
    reg [1:0] state;
    reg [1:0] next_state;
    always @(*) begin
        next_state = state;
        case (state)
            A: begin
                case (w)
                    0: next_state = B;
                    1: next_state = C;
                    2: next_state = D;
                    3: next_state = E;
                    4: next_state = F;
                    5: next_state = F;
                    6: next_state = A;
                    7: next_state = B;
                    8: next_state = A;
                    9: next_state = C;
                    default: next_state = A;
                endcase
            end
            B: begin
                case (w)
                    0: next_state = C;
                    1: next_state = B;
                    2: next_state = D;
                    3: next_state = E;
                    4: next_state = F;
                    5: next_state = F;
                    6: next_state = A;
                    7: next_state = B;
                    8: next_state = C;
                    9: next_state = D;
                    9: next_state = E;
                    7: next_state = F;
                endcase
            end
        endcase
        case (state)
            A: begin
                case (w)
                    0: next_state = B;
                    1: next_state = C;
                    2: next_state = D;
                    3: next_state = E;
                    5: next_state = F;
                    6: next_state = B;
                    7: next_state = F;
                    8: next_state = C;
                    9: next_state = F;
                    9: next_state = A;
                    8: next_state = B;
                    9: next_state = C;
                    10: next_state = A;
                    11: next_state = B;
                    12: next_state = C;
                    13: next_state = D;
                    14: next_state = E;
                    15: next_state = F;
                endcase
            end
        endcase
    end
endmodule

