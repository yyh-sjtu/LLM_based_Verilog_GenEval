
module TopModule (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @(*) begin
    case ({c, d, a, b})
        4'b0000: out = 1;
        4'b0001: out = 0;
        4'b0010: out = 0;
        4'b0011: out = 0;
        4'b0110: out = 0;
        4'b0111: out = 1;
        4'b1010: out = 1;
        4'b1011: out = 1;
        default: out = 0; // Don't care
    endcase
end

endmodule