
module TopModule (
    input a,
    input b,
    output reg q
);

always @* begin
    case ({a, b})
        2'b00: q = 1'b0;
        2'b01: q = 1'b0;
        2'b10: q = 1'b0;
        2'b11: q = 1'b1;
        default: q = 1'b0;
    endcase
end

endmodule