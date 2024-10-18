
module TopModule (
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @* begin
    case ({c, d})
        2'b00: out = 1;
        2'b01: out = (a & b) | (!a & c);
        2'b10: out = a | b | c;
        2'b11: out = (a & b) | (b & c) | (a & c);
    endcase
end

endmodule