
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

// Dual-port RAM instantiation
dual_port_RAM ram (
    .wclk(wclk),
    .wenc(winc & ~wfull),
    .waddr(waddr),
    .wdata(wdata),
    .rclk(rclk),
    .renc(rinc & ~rempty),
    .raddr(raddr),
    .rdata(rdata)
);

// Signal declarations
reg [$clog2(DEPTH)-1:0] waddr, raddr;
reg [WIDTH-1:0] wptr, rptr;
reg [WIDTH-1:0] wptr_buff, rptr_buff;

// Write and read pointer logic
always @(posedge wclk or negedge wrstn) begin
    if (~wrstn) begin
        waddr <= 0;
        wptr <= 0;
        wptr_buff <= 0;
    end else begin
        waddr <= waddr + winc;
        wptr <= wptr ^ (wptr >> 1);
        wptr_buff <= wptr;
    end
end

always @(posedge rclk or negedge rrstn) begin
    if (~rrstn) begin
        raddr <= 0;
        rptr <= 0;
        rptr_buff <= 0;
    end else begin
        raddr <= raddr + rinc;
        rptr <= rptr ^ (rptr >> 1);
        rptr_buff <= rptr;
    end
end

// Full and empty signal generation
always @(*) begin
    if (wptr == ({~rptr[WIDTH-1], rptr[WIDTH-2:0]})) begin
        wfull <= 1;
    else
        wfull <= 0;
    
    if (wptr == rptr) begin
        rempty <= 1;
    else
        rempty <= 0;
end

endmodule