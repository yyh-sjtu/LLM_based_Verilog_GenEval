
module TopModule(
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @*
begin
    case({c, d, a, b})
        4'b0000: out = 1;
        4'b0001: out = 0;
        4'b0010: out = 1;
        4'b0011: out = 1;
        4'b0110: out = 0;
        default: out = 1; // Don't-care case
    endcase
end

endmodule