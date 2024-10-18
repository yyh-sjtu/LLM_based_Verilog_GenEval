module dual_port_RAM (
    input wclk,
    input wenc,
    input [$clog2(DEPTH)-1:0] waddr,
    input [WIDTH-1:0] wdata,
    input rclk,
    input renc,
    input [$clog2(DEPTH)-1:0] raddr,
    output reg [WIDTH-1:0] rdata
);

reg [DEPTH-1:0][WIDTH-1:0] RAM_MEM;

always @(posedge wclk)
begin
    if(wenc)
        RAM_MEM[waddr] <= wdata;
end

always @(posedge rclk)
begin
    if(renc)
        rdata <= RAM_MEM[raddr];
end

endmodule

module asyn_fifo (
    input wclk,
    input rclk,
    input wrstn,
    input rrstn,
    input winc,
    input rinc,
    input [WIDTH-1:0] wdata,
    output wfull,
    output rempty,
    output reg [WIDTH-1:0] rdata
);
    
parameter WIDTH = 8;
parameter DEPTH = 16;

reg [$clog2(DEPTH)-1:0] waddr_bin;
reg [$clog2(DEPTH)-1:0] raddr_bin;
reg [DEPTH-1:0][WIDTH-1:0] RAM_MEM;
reg [DEPTH-1:0][WIDTH-1:0] wptr_buff;
reg [DEPTH-1:0][WIDTH-1:0] rptr_buff;

reg [DEPTH-1:0][WIDTH-1:0] wptr;
reg [DEPTH-1:0][WIDTH-1:0] rptr;
reg [1:0] wptr_sync;
reg [1:0] rptr_sync;

always @(posedge wclk or negedge wrstn)
begin
    if(~wrstn)
    begin
        waddr_bin <= 0;
        wptr <= 0;
    end
    else if(winc)
    begin
        waddr_bin <= waddr_bin + 1;
        wptr <= (waddr_bin ^ (waddr_bin >> 1));
    end
end

always @(posedge rclk or negedge rrstn)
begin
    if(~rrstn)
    begin
        raddr_bin <= 0;
        rptr <= 0;
    end
    else if(rinc)
    begin
        raddr_bin <= raddr_bin + 1;
        rptr <= (raddr_bin ^ (raddr_bin >> 1));
    end
end

always @(posedge wclk)
begin
    wptr_sync <= wptr;
    wptr_buff <= wptr_sync;
end

always @(posedge rclk)
begin
    rptr_sync <= rptr;
    rptr_buff <= rptr_sync;
end

assign wfull = (wptr_sync == ((wptr_sync & ~(1 << ($clog2(DEPTH)-1))) | ~(wptr_sync & ~(1 << ($clog2(DEPTH)-1)))));
assign rempty = (rptr_sync == wptr_sync);

dual_port_RAM ram_inst(
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

