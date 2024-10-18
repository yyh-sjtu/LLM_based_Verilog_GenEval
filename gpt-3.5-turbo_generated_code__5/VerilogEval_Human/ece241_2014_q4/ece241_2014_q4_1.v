module top_module (
	input clk,
	input x,
	output z
);
	reg [2:0] d_ff;  // D flip-flop outputs
	
	assign z = ~(d_ff[0] ^ d_ff[1] ^ d_ff[2]);  // Output Z is the XNOR of flip-flop outputs
	
	always @(posedge clk) begin
		d_ff[0] <= x ^ d_ff[0];  // XOR gate
		d_ff[1] <= ~(x & d_ff[1]);  // AND gate
		d_ff[2] <= ~(x | d_ff[2]);  // OR gate
	end
endmodule

