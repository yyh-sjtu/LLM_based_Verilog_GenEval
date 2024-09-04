module half_adder(
input a, b,
output cout, sum);

assign sum = a ^ b; // XOR gate for sum
assign cout = a & b; // AND gate for carry out

endmodule

