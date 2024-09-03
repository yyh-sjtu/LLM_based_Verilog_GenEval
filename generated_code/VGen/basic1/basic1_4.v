module full_adder(
    input  wire    a,
    input  wire    b,
    input  wire    carry_in,
    output wire    sum,
    output reg     carry_out
);

assign sum = a ^ b ^ carry_in; // bitwise XOR of inputs and carry_in
assign carry_out = (a & b) | (b & carry_in) | (a & carry_in); // calculates carry_out

endmodule

