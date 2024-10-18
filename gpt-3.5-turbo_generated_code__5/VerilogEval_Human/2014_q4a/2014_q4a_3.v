module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg [1:0] mux_select; // 2-bit mux select signal

// D flip-flop to store the value
always @(posedge clk) begin
	if (L) begin
		Q <= R;
	end else begin
		Q <= Q;
	end
end

// Mux to select between input data and output of previous stage
always @(*) begin
	if (E) begin
		mux_select = 2'b01; // Load input data
	end else begin
		mux_select = 2'b10; // Shift data
	end
end

// Mux to select between input data and output of previous stage
always @(*) begin
	case(mux_select)
		2'b01: Q <= R; // Load input data
		2'b10: Q <= w; // Shift data
	endcase
end

endmodule

