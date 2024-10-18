module dual_port_RAM (
    input wclk,
    input wenc,
    input [(DEPTH-1):0] waddr,
    input [(WIDTH-1):0] wdata,
    input rclk,
    input renc,
    input [(DEPTH-1):0] raddr,
    output reg [(WIDTH-1):0] rdata
);

    reg [(WIDTH-1):0] RAM_MEM [DEPTH-1:0];

    always @(posedge wclk) begin
        if(wenc) RAM_MEM[waddr] <= wdata;
    end

    always @(posedge rclk) begin
        if(renc) rdata <= RAM_MEM[raddr];
    end

endmodule

module asyn_fifo (
    input wclk,
    input rclk,
    input wrstn,
    input rrstn,
    input winc,
    input rinc,
    input [(WIDTH-1):0] wdata,
    output wfull,
    output rempty,
    output [(WIDTH-1):0] rdata
);

    parameter WIDTH = 8;
    parameter DEPTH = 16;

    reg [(DEPTH-1):0] waddr_bin;
    reg [($clog2(DEPTH)-1):0] wptr;
    reg [($clog2(DEPTH)-1):0] rptr;
    reg [(DEPTH-1):0] raddr_bin;
    reg [($clog2(DEPTH)-1):0] wptr_buff;
    reg [($clog2(DEPTH)-1):0] rptr_buff;

    assign wfull = (wptr == ({(~rptr[$clog2(DEPTH)-1]), rptr[($clog2(DEPTH)-2):0]}));
    assign rempty = (wptr == rptr);
    assign rdata = dual_port_RAM.rdata;

    always @(posedge wclk or negedge wrstn) begin
        if(~wrstn) begin
            waddr_bin <= 0;
            wptr <= 0;
        end else begin
            if(winc) begin
                waddr_bin <= waddr_bin + 1;
                wptr <= wptr_bin;
            end
            wptr_buff <= wptr;
        end
    end

    always @(posedge rclk or negedge rrstn) begin
        if(~rrstn) begin
            raddr_bin <= 0;
            rptr <= 0;
        end else begin
            if(rinc) begin
                raddr_bin <= raddr_bin + 1;
                rptr <= rptr_bin;
            end
            rptr_buff <= rptr;
        end
    end

    dual_port_RAM RAM (
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

