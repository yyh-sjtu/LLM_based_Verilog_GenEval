
module TopModule (
    input clk,
    input x,
    output reg z
);

reg dff1, dff2, dff3;

always @(posedge clk) begin
    dff1 <= x ^ dff1;  // XOR gate
    dff2 <= ~(x & dff2);  // AND gate
    dff3 <= ~(x | dff3);  // OR gate

    z <= ~(dff1 & dff2 & dff3);  // XNOR gate
end

endmodule