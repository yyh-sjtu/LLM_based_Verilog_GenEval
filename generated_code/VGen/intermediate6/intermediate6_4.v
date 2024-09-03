module
module full_adder(input a, input b, input cin, output sum, output cout);
	assign {cout, sum} = a + b + cin;
endmodule

module
module full_adder_16bit(input [15:0] a, input [15:0] b, input cin, output [15:0] sum, output cout);
	genvar i;
	generate
		for(i = 0; i < 16; i = i + 1) begin: adder_loop
			full_adder fa(a[i], b[i], (i > 0) ? sum[i-1] : cin, sum[i], (i == 15) ? cout : sum[i+1]);
		end
	endgenerate
endmodule

module
module ram #( parameter ADDR_WIDTH=6, parameter DATA_WIDTH=8) 
(input [DATA_WIDTH-1:0] data, input [ADDR_WIDTH-1:0] addr, input we, clk, output [DATA_WIDTH-1:0] q);
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	always @(posedge clk) begin
		if (we) begin
			ram[addr] <= data;
		end
		q <= ram[addr];
	end

endmodule

