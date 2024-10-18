module dual_port_RAM #(
	parameter WIDTH = 8,
	parameter DEPTH = 16
)(
	input wclk,
	input wenc,
	input [$clog2(DEPTH)-1:0] waddr,
	input [WIDTH-1:0] wdata,
	input rclk,
	input renc,
	input [$clog2(DEPTH)-1:0] raddr,
	output reg [WIDTH-1:0] rdata
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
	if(wenc)
		RAM_MEM[waddr] <= wdata;
end

always @(posedge rclk) begin
	if(renc)
		rdata <= RAM_MEM[raddr];
end

endmodule

module asyn_fifo #(
	parameter WIDTH = 8,
	parameter DEPTH = 16
)(
	input wclk,
	input rclk,
	input wrstn,
	input rrstn,
	input winc,
	input rinc,
	input [WIDTH-1:0] wdata,
	output wfull,
	output rempty,
	output [WIDTH-1:0] rdata
);

reg [$clog2(DEPTH)-1:0] waddr_bin, raddr_bin;
reg [$clog2(DEPTH)-1:0] wptr, rptr, wptr_buff, rptr_buff;

// Dual-port RAM instantiation
dual_port_RAM #(
	.WIDTH(WIDTH),
	.DEPTH(DEPTH)
) ram_inst (
	.wclk(wclk),
	.wenc(winc),
	.waddr(waddr_bin),
	.wdata(wdata),
	.rclk(rclk),
	.renc(rinc),
	.raddr(raddr_bin),
	.rdata(rdata)
);

// Write and Read Pointer logic
always @(posedge wclk or negedge wrstn) begin
	if(~wrstn) begin
		waddr_bin <= 0;
		wptr <= 0;
	end
	else if(winc)
		waddr_bin <= waddr_bin + 1;
end

always @(posedge rclk or negedge rrstn) begin
	if(~rrstn) begin
		raddr_bin <= 0;
		rptr <= 0;
	end
	else if(rinc)
		raddr_bin <= raddr_bin + 1;
end

// Gray Code Conversion
always @(posedge wclk) begin
	wptr_buff <= wptr;
	wptr <= waddr_bin ^ (waddr_bin >> 1);
end

always @(posedge rclk) begin
	rptr_buff <= rptr;
	rptr <= raddr_bin ^ (raddr_bin >> 1);
end

// Full and Empty Signals
assign wfull = (wptr[($clog2(DEPTH)-1)] == (~rptr_buff[($clog2(DEPTH)-1)]) && 
				wptr[($clog2(DEPTH)-2):0] == rptr_buff[($clog2(DEPTH)-2):0]);
assign rempty = (rptr == wptr_buff);

endmodule

