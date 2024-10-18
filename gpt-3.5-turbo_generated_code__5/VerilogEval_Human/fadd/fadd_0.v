module full_adder (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	assign sum = a ^ b ^ cin;
	assign cout = (a & b) | (cin & (a ^ b));
  
endmodule

module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	full_adder fa1(.a(a), .b(b), .cin(cin), .cout(cout), .sum(sum));
endmodule

