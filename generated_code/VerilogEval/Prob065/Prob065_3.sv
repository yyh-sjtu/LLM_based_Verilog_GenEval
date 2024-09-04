
module TopModule (
    input p1a,
    input p1b,
    input p1c,
    input p1d,
    input p2a,
    input p2b,
    input p2c,
    input p2d,
    output reg p1y,
    output reg p2y
);

// Internal signals
reg nand1_out;
reg nand2_out;

// 4-input NAND gate implementation
always @* begin
    nand1_out = ~(p1a & p1b & p1c & p1d);
    nand2_out = ~(p2a & p2b & p2c & p2d);
end

// Assign outputs
assign p1y = nand1_out;
assign p2y = nand2_out;

endmodule