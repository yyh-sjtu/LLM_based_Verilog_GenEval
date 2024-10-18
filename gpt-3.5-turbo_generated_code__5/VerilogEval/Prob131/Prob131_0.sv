
module top_module (
    input x,
    input y,
    output z
);

wire a_out1, a_out2, b_out1, b_out2, or_out, and_out;

module_A A1(x, y, a_out1);
module_A A2(x, y, a_out2);

module_B B1(x, y, b_out1);
module_B B2(x, y, b_out2);

or_gate or1(a_out1, b_out1, or_out);
and_gate and1(a_out2, b_out2, and_out);

xor_gate xor1(or_out, and_out, z);

endmodule