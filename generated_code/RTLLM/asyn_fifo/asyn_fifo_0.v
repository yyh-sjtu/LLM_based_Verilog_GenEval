
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
        if (wenc)
            RAM_MEM[waddr] <= wdata;
    end

    always @(posedge rclk)
    begin
        if (renc)
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

reg [WIDTH-1:0] wdata_reg;
reg [$clog2(DEPTH)-1:0] wptr, rptr;
reg [WIDTH-1:0] wptr_buff, rptr_buff;

dual_port_RAM ram (
    .wclk(wclk),
    .wenc(winc),
    .waddr(wptr),
    .wdata(wdata_reg),
    .rclk(rclk),
    .renc(rinc),
    .raddr(rptr),
    .rdata(rdata)
);

always @(posedge wclk)
begin
    if (~wrstn)
    begin
        wptr <= 0;
        wptr_buff <= 0;
    end
    else
    begin
        wdata_reg <= wdata;
        wptr <= wptr + 1;
        wptr_buff <= wptr;
    end
end

always @(posedge rclk)
begin
    if (~rrstn)
    begin
        rptr <= 0;
        rptr_buff <= 0;
    end
    else
    begin
        rptr <= rptr + 1;
        rptr_buff <= rptr;
    end
end

always @(*)
begin
    if (wptr == rptr)
        rempty <= 1;
    else
        rempty <= 0;

    if ((wptr == (rptr[DEPTH-1] ^ rptr[DEPTH-2]) && (rptr[DEPTH-1:0] != 0))
        wfull <= 1;
    else
        wfull <= 0;
end

endmodule