module top_module (
	input clk,
	input areset,
	input x,
	output z
);


	reg [3:0] count;
	reg z;
	always @(posedge clk or negedge areset) begin
		if (!areset) begin
			count <= 0;
			z <= 0;
		end else begin
			count <= count + 1;
			if (count == 0) begin
				z <= x;
			end else begin
				z <= ~x + 1;
			end
		end
	end


endmodule

