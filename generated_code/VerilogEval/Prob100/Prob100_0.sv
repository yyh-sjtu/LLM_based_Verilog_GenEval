
module TopModule (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(*) begin
    case(state)
        A: begin
            if(in)
                next_state = B;
            else
                next_state = A;
            out = 0;
        end
        B: begin
            if(in)
                next_state = B;
            else
                next_state = C;
            out = 0;
        end
        C: begin
            if(in)
                next_state = D;
            else
                next_state = A;
            out = 0;
        end
        D: begin
            if(in)
                next_state = B;
            else
                next_state = C;
            out = 1;
        end
    endcase
end

endmodule