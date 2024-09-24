
module TopModule (
    input clk,
    input x,
    output reg z
);

reg d_ff1, d_ff2, d_ff3;

always @(posedge clk) begin
    d_ff1 <= x ^ d_ff1;   // XOR gate
    d_ff2 <= x & ~d_ff2;  // AND gate
    d_ff3 <= x | ~d_ff3;  // OR gate

    z <= ~(d_ff1 & d_ff2 & d_ff3);  // XNOR gate
end

endmodule