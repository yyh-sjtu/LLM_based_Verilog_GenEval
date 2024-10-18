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
	
	always @(x, y) begin
		case ({x, y})
			2'b00: z = 1;
			2'b01: z = 0;
			2'b10: z = 0;
			2'b11: z = 1;
		endcase
	end
	
endmodule

module top_module(
	input x,
	input y,
	output z);
	
	A a1(x, y, a_out1);
	B b1(x, y, b_out1);
	A a2(x, y, a_out2);
	B b2(x, y, b_out2);
	
	or #(.N(2)) u1(.a({a_out1, b_out1}), .z(or_out));
	and #(.N(2)) u2(.a({a_out2, b_out2}), .z(and_out));
	xor u3(.a(or_out), .b(and_out), .z(z));
	
endmodule

