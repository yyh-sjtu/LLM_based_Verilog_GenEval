
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
        if (wenc) RAM_MEM[waddr] <= wdata;
    end

    always @(posedge rclk) begin
        if (renc) rdata <= RAM_MEM[raddr];
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

reg [$clog2(DEPTH)-1:0] wptr, rptr, wptr_syn, rptr_syn;
reg [$clog2(DEPTH)-1:0] wptr_buff, rptr_buff;

always @(posedge wclk or negedge wrstn) begin
    if (!wrstn) begin
        wptr <= 0;
        wptr_buff <= 0;
    else if (winc) begin
        wptr <= wptr + 1;
        wptr_buff <= wptr;
    end
end

always @(posedge rclk or negedge rrstn) begin
    if (!rrstn) begin
        rptr <= 0;
        rptr_buff <= 0;
    else if (rinc) begin
        rptr <= rptr + 1;
        rptr_buff <= rptr;
    end
end

always @(wptr or rptr) begin
    wptr_syn <= wptr ^ (wptr >> 1);
    rptr_syn <= rptr ^ (rptr >> 1);
end

always @(posedge wclk) begin
    if (wptr_syn == rptr) wfull <= 1;
    else wfull <= 0;
end

always @(posedge rclk) begin
    if (rptr == wptr && rptr_buff != wptr_buff) rempty <= 1;
    else rempty <= 0;
end

dual_port_RAM RAM (
    .wclk(wclk),
    .wenc(!wfull),
    .waddr(wptr_syn),
    .wdata(wdata),
    .rclk(rclk),
    .renc(!rempty),
    .raddr(rptr_syn),
    .rdata(rdata)
);

endmodule