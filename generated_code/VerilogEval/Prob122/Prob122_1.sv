
module TopModule(
    input a,
    input b,
    input c,
    input d,
    output reg out
);

always @* begin
    case ({c,d})
        2'b00: out = a & b;
        2'b01: out = a ^ b;
        2'b10: out = a & b;
        2'b11: out = a ^ b;
    endcase
end

endmodule