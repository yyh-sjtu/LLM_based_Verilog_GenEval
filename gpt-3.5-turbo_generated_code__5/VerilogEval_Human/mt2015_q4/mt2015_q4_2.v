module A(
	input x,
	input y,
	output z);
	
	assign z = (x ^ y) & x;
endmodule

module B(
	input x,
	input y,
	output z);
	
	reg z;	
	always @(x or y)
	begin
		case({x, y})
			2'b00: z = 1;
			2'b10: z = 0;
			default: z = 1;
		endcase
	end
	
	assign z = z;
endmodule

module top_module(
	input x,
	input y,
	output z);
	
	wire a_out1, a_out2;
	wire b_out1, b_out2;
	wire or_out, and_out;
	
	A a1(x, y, a_out1);
	A a2(x, y, a_out2);
	B b1(x, y, b_out1);
	B b2(x, y, b_out2);
	
	assign or_out = a_out1 | b_out1;
	assign and_out = a_out2 & b_out2;
	assign z = xor (or_out, and_out);
endmodule

