
module dual_port_RAM (
    input wire wclk,
    input wire wenc,
    input wire [$clog2(DEPTH)-1:0] waddr,
    input wire [WIDTH-1:0] wdata,
    input wire rclk,
    input wire renc,
    input wire [$clog2(DEPTH)-1:0] raddr,
    output reg [WIDTH-1:0] rdata
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
    if (wenc) RAM_MEM[waddr] <= wdata;
end

always @(posedge rclk) begin
    if (renc) rdata <= RAM_MEM[raddr];
end

endmodule

module asyn_fifo (
    input wire wclk,
    input wire rclk,
    input wire wrstn,
    input wire rrstn,
    input wire winc,
    input wire rinc,
    input wire [WIDTH-1:0] wdata,
    output reg wfull,
    output reg rempty,
    output reg [WIDTH-1:0] rdata
);

parameter WIDTH = 8;
parameter DEPTH = 16;

reg [$clog2(DEPTH)-1:0] waddr_bin, raddr_bin, wptr, rptr, wptr_buff, rptr_buff;

always @(posedge wclk) begin
    if (wrstn)
        wptr <= 0;
    else begin
        wptr <= wptr ^ (wptr >> 1);
        wptr <= wptr + winc;
    end
end

always @(posedge rclk) begin
    if (rrstn)
        rptr <= 0;
    else begin
        rptr <= rptr ^ (rptr >> 1);
        rptr <= rptr + rinc;
    end
end

assign waddr_bin = wptr ^ (wptr >> 1);
assign raddr_bin = rptr ^ (rptr >> 1);

always @(posedge wclk) begin
    wptr_buff <= wptr;
end

always @(posedge rclk) begin
    rptr_buff <= rptr;
end

assign wfull = (wptr == ~{rptr[($clog2(DEPTH)-2):0], rptr[($clog2(DEPTH)-1)]});
assign rempty = (rptr == wptr);
  
dual_port_RAM dp_RAM (
    .wclk(wclk),
    .wenc(winc),
    .waddr(waddr_bin),
    .wdata(wdata),
    .rclk(rclk),
    .renc(rinc),
    .raddr(raddr_bin),
    .rdata(rdata)
);

endmodule