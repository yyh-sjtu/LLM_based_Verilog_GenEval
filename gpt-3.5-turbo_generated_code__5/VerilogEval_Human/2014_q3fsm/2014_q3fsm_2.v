module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// define the states
parameter A = 0;
parameter B = 1;

// define the state variable
reg curr_state, next_state;

// define the count variable to keep track of the number of clock cycles with w = 1
reg [2:0] count;

// synchronous reset
always @(posedge clk) begin
	if (reset) begin
		curr_state <= A;
		count <= 0;
	end else begin
		curr_state <= next_state;
		if (curr_state == A && s == 1) begin
			next_state <= B;
			count <= 0;
		end else if (curr_state == B) begin
			if (count == 2 && w == 1) begin
				next_state <= B;
				count <= 0;
			end else begin
				next_state <= B;
				count <= count + 1;
			end
		end else begin
			next_state <= A;
			count <= 0;
		end
	end
end

// sequential logic
always @(posedge clk) begin
	if (reset) begin
		z <= 0;
	end else begin
		// update output z based on current state
		if (curr_state == B && count == 2) begin
			z <= 1;
		end else begin
			z <= 0;
		end
	end
end

endmodule

