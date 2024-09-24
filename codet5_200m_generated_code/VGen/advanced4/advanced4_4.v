module advshift (
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q
);
 
parameter WIDTH = 64; 
parameter DEPTH = 64; 
reg [WIDTH-1:0] shiftreg; 
always @(posedge clk)
begin
    if (load)
        shiftreg <= data; 
    else if (ena)
        shiftreg <= {shiftreg[WIDTH-1:0], data}; 
end
always @(posedge clk)
begin
    if (load)
        q <= shiftreg; 
    else if (ena)
        q <= {shiftreg[WIDTH-1:0], data}; 
end
endmodule

