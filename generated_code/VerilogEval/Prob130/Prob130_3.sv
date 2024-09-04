
module TopModule (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

always @* begin
    case(c)
        b: q = e;
        default: q = 4'b1111; // f in binary representation
    endcase
end

endmodule