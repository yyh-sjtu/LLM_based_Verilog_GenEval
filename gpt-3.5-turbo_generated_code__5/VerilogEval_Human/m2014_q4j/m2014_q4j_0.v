module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Define internal signals
	wire [4:0] internal_sum;

	// Instantiate full adders
	full_adder fa0(x[0], y[0], 1'b0, internal_sum[0], internal_sum[1]);
	full_adder fa1(x[1], y[1], internal_sum[1], internal_sum[2], internal_sum[3]);
	full_adder fa2(x[2], y[2], internal_sum[3], internal_sum[4], internal_sum[5]);
	full_adder fa3(x[3], y[3], internal_sum[5], sum[3], sum[4]);

	// Assign output signals
	assign sum[0] = internal_sum[0];
	assign sum[1] = internal_sum[1];
	assign sum[2] = internal_sum[2];
endmodule

module full_adder (
	input a,
	input b,
	input cin,
	output sum,
	output cout
);
	// Define internal signals
	wire s_int, c1, c2;

	// Calculate intermediate values
	xor x1(s_int, a, b);
	xor x2(sum, s_int, cin);
	and a1(c1, a, b);
	and a2(c2, s_int, cin);
	or o1(cout, c1, c2);
endmodule

module xor (
	input a,
	input b,
	output y
);
	assign y = a ^ b;
endmodule

module and (
	input a,
	input b,
	output y
);
	assign y = a & b;
endmodule

module or (
	input a,
	input b,
	output y
);
	assign y = a | b;
endmodule

