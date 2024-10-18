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

reg [WIDTH-1:0] RAM_MEM [DEPTH-1:0];

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
    output reg wfull,
    output reg rempty,
    output reg [WIDTH-1:0] rdata
);

parameter WIDTH = 8;
parameter DEPTH = 16;

reg [$clog2(DEPTH)-1:0] waddr_bin;
reg [$clog2(DEPTH)-1:0] raddr_bin;
reg [$clog2(DEPTH)-1:0] waddr_gray;
reg [$clog2(DEPTH)-1:0] raddr_gray;
reg [WIDTH-1:0] wptr;
reg [WIDTH-1:0] rptr;
reg [WIDTH-1:0] wptr_buff;
reg [WIDTH-1:0] rptr_buff;

dual_port_RAM RAM_inst (
    .wclk(wclk),
    .wenc(winc),
    .waddr(waddr_bin),
    .wdata(wdata),
    .rclk(rclk),
    .renc(rinc),
    .raddr(raddr_bin),
    .rdata(rdata)
);

always @(posedge wclk or negedge wrstn)
begin
    if(~wrstn)
    begin
        waddr_bin <= 0;
        wptr <= 0;
        wptr_buff <= 0;
    end
    else
    begin
        waddr_bin <= waddr_gray;
        wptr <= wptr_buff ^ wptr;
        wptr_buff <= wptr;
    end
end

always @(posedge rclk or negedge rrstn)
begin
    if(~rrstn)
    begin
        raddr_bin <= 0;
        rptr <= 0;
        rptr_buff <= 0;
    end
    else
    begin
        raddr_bin <= raddr_gray;
        rptr <= rptr_buff ^ rptr;
        rptr_buff <= rptr;
    end
end

always @(*)
begin
    waddr_gray = wptr ^ (wptr >> 1);
    raddr_gray = rptr ^ (rptr >> 1);
    wfull = (wptr == (|({1'b0, rptr[($clog2(DEPTH)-2):0]}))) && (wptr != rptr);
    rempty = (wptr == rptr);
end

endmodule

