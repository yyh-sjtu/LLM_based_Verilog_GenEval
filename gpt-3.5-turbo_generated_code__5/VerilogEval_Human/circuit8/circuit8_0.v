module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_reg;
reg q_reg;

always @(posedge clock) begin
	p_reg <= a;
	q_reg <= p_reg;
end

always @(posedge clock) begin
	if (a & (~p_reg))
		p <= 1'b1;
	else
		p <= 1'b0;
end

always @(posedge clock) begin
	if (a & p_reg & q_reg)
		q <= 1'b1;
	else
		q <= 1'b0;
end

endmodule

