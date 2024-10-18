module top_module (
	input [255:0] in,
	input [7:0] sel,
	output  out
);

wire [255:0] selected;
wire [7:0] selected_index;

assign selected = in;
assign selected_index = sel;

assign out = selected[selected_index];

endmodule

