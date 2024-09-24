
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state, next_state;

always @ (posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @ (*) begin
    case (state)
        A: begin
            if (in) begin
                next_state = B;
            else
                next_state = A;
            end
            out = 1'b0;
        end
        B: begin
            if (in) begin
                next_state = B;
            else
                next_state = C;
            end
            out = 1'b0;
        end
        C: begin
            if (in) begin
                next_state = D;
            else
                next_state = A;
            end
            out = 1'b0;
        end
        D: begin
            if (in) begin
                next_state = B;
            else
                next_state = C;
            end
            out = 1'b1;
        end
        default: begin
            next_state = A;
            out = 1'b0;
        end
    endcase
end

endmodule