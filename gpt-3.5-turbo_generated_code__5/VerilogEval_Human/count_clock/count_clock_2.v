
module counter(
	input clk,
	input reset,
	input ena,
	inout [3:0] count
);

always @(posedge clk) begin
	if (reset) begin
		count <= 4'b0000; // reset to 0
	end else if (ena) begin
		count <= count + 1;
		if (count == 4'b1001) begin
			count <= 4'b0000; // reset to 0 when reaching 9
		end
	end
end

endmodule

module bcd_converter(
	input [3:0] binary,
	output [3:0] bcd
);

assign bcd = (binary >= 5) ? binary + 3 : binary;

endmodule

module top_module(
	input clk,
	input reset,
	input ena,
	output reg pm,
	output reg [7:0] hh,
	output reg [7:0] mm,
	output reg [7:0] ss
);

reg [3:0] hh_count;
reg [3:0] mm_count;
reg [3:0] ss_count;

counter hh_counter (.clk(clk), .reset(reset), .ena(ena), .count(hh_count));
counter mm_counter (.clk(clk), .reset(reset), .ena(ena), .count(mm_count));
counter ss_counter (.clk(clk), .reset(reset), .ena(ena), .count(ss_count));

bcd_converter hh_converter (.binary(hh_count), .bcd(hh));
bcd_converter mm_converter (.binary(mm_count), .bcd(mm));
bcd_converter ss_converter (.binary(ss_count), .bcd(ss));

always @(posedge clk) begin
	pm <= (hh_count >= 4'd12);
end

endmodule