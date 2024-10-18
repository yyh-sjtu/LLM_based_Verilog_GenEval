
module TopModule(
    input a,
    input b,
    input c,
    output reg out
);

always @* begin
    case({c, b})
        2'b00: out = a;
        2'b01: out = 1;
        2'b11: out = 1;
        2'b10: out = 1;
        default: out = 0;
    endcase
end

endmodule