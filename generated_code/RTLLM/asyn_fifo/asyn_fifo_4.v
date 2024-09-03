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

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

always @(posedge wclk) begin
    if (wenc) begin
        RAM_MEM[waddr] <= wdata;
    end
end

always @(posedge rclk) begin
    if (renc) begin
        rdata <= RAM_MEM[raddr];
    end
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

reg [$clog2(DEPTH)-1:0] wptr;
reg [$clog2(DEPTH)-1:0] rptr;

reg [$clog2(DEPTH)-1:0] wptr_buff;
reg [$clog2(DEPTH)-1:0] rptr_buff;

reg [$clog2(DEPTH)-1:0] wptr_syn;
reg [$clog2(DEPTH)-1:0] rptr_syn;

wire wen = ~wfull & ~wrstn;
wire ren = ~rempty & ~rrstn;

dual_port_RAM RAM (
    .wclk(wclk),
    .wenc(wen),
    .waddr(wptr_syn),
    .wdata(wdata),
    .rclk(rclk),
    .renc(ren),
    .raddr(rptr_syn),
    .rdata(rdata)
);

always @(posedge wclk or negedge wrstn or posedge rclk or negedge rrstn) begin
    if (~wrstn) begin
        wptr <= 0;
        wptr_buff <= 0;
        wptr_syn <= 0;
    end else begin
        wptr <= wptr + winc;
        wptr_buff <= wptr;
        wptr_syn <= wptr ^ (wptr >> 1);
    end

    if (~rrstn) begin
        rptr <= 0;
        rptr_buff <= 0;
        rptr_syn <= 0;
    end else begin
        rptr <= rptr + rinc;
        rptr_buff <= rptr;
        rptr_syn <= rptr ^ (rptr >> 1);
    end

    rempty <= (rptr == wptr_syn);
    wfull <= (wptr_syn == {~wptr_syn[$clog2(DEPTH)-1], wptr_syn[$clog2(DEPTH)-2:0]});
end

endmodule
