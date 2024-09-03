
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

reg [$clog2(DEPTH)-1:0] wptr, rptr;
reg [WIDTH-1:0] dual_port_RAM [0:DEPTH-1];

reg [$clog2(DEPTH)-1:0] wptr_bin, rptr_bin;
reg [$clog2(DEPTH)-1:0] wptr_buff, rptr_buff;
reg [$clog2(DEPTH)-1:0] wptr_syn, rptr_syn;

reg [WIDTH-1:0] rdata_out;

// Dual-port RAM instantiation
dual_port_RAM #(
    .WIDTH(WIDTH)
) ram_instance (
    .wclk(wclk),
    .wenc(winc),
    .waddr(wptr_syn),
    .wdata(wdata),
    .rclk(rclk),
    .renc(rinc),
    .raddr(rptr_syn),
    .rdata(rdata_out)
);

// Write pointer logic
always @(posedge wclk or negedge wrstn) begin
    if (~wrstn) begin
        wptr <= 0;
    end else begin
        wptr <= winc ? (wptr + 1) : wptr;
    end
end

// Read pointer logic
always @(posedge rclk or negedge rrstn) begin
    if (~rrstn) begin
        rptr <= 0;
    end else begin
        rptr <= rinc ? (rptr + 1) : rptr;
    end
end

// Gray code conversion
assign wptr_bin = wptr ^ (wptr >> 1);
assign rptr_bin = rptr ^ (rptr >> 1);

// Pointer synchronization
always @* begin
    wptr_syn = wptr_bin ^ wptr_buff;
    rptr_syn = rptr_bin ^ rptr_buff;
end

// Full and Empty conditions
always @* begin
    wfull = (wptr == {~rptr_bin[($clog2(DEPTH)-1)], rptr_bin[($clog2(DEPTH)-2):0]});
    rempty = (rptr == wptr);
end

// Buffer registers for write and read pointer
always @(posedge wclk or negedge wrstn) begin
    wptr_buff <= ~wrstn ? 0 : wptr_bin;
end

always @(posedge rclk or negedge rrstn) begin
    rptr_buff <= ~rrstn ? 0 : rptr_bin;
end

// Output data and connection
always @* begin
    if (rinc && ~rempty) begin
        rdata = rdata_out;
    end
end

endmodule