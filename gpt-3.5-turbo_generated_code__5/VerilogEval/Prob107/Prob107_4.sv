
module TopModule (
    input clk,
    input reset,
    input in,
    output reg out
);

// State encoding
parameter B = 1'b0;
parameter A = 1'b1;

// State register
reg state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= B;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        B: begin
            if (in) begin
                next_state = B;
                out = 1'b1;
            end else begin
                next_state = A;
                out = 1'b1;
            end
        end
        A: begin
            if (in) begin
                next_state = A;
                out = 1'b0;
            end else begin
                next_state = B;
                out = 1'b0;
            end
        end
    endcase
end

endmodule