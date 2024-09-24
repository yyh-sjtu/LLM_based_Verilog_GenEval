
module TopModule (
    input  p1a, p1b, p1c, p1d,
    input  p2a, p2b, p2c, p2d,
    output reg p1y,
    output reg p2y
);

always @(*) begin
    p1y = ~(p1a & p1b & p1c & p1d); // 4-input NAND gate
    p2y = ~(p2a & p2b & p2c & p2d); // 4-input NAND gate
end

endmodule