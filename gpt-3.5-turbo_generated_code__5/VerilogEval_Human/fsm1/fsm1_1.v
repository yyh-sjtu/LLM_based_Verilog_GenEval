module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
  
parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= B;
	else
		if (state == A)
			state <= in ? A : B;
		else
			state <= in ? B : A;
end

assign out = (state == A) ? 1'b1 : 1'b0;

endmodule

