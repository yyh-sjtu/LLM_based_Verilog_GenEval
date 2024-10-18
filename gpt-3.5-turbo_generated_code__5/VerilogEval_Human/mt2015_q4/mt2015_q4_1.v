module A(
	input x,
	input y,
	output wire z);
	
	assign z = x ^ y & x;
	
endmodule

module B(
	input x,
	input y,
	output wire z);
	
	assign z = (x & y) ^ x;
	
endmodule

module top_module(
	input x,
	input y,
	output z);
	
	wire a1, a2, b1, b2;
	
	A a_inst1(.x(x), .y(y), .z(a1));
	A a_inst2(.x(x), .y(y), .z(a2));
	B b_inst1(.x(x), .y(y), .z(b1));
	B b_inst2(.x(x), .y(y), .z(b2));
	
	or or_gate(.a(a1), .b(b1), .z(z));
	and and_gate(.a(a2), .b(b2), .z(z));
	
endmodule

