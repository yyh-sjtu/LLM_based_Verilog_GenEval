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
    output wfull, 
    output rempty, 
    output reg [WIDTH-1:0] rdata
);
    parameter WIDTH = 8;
    parameter DEPTH = 16;
    
    reg [$clog2(DEPTH)-1:0] waddr_bin, raddr_bin;
    reg [$clog2(DEPTH)-1:0] wptr, rptr;
    reg [$clog2(DEPTH)-1:0] wptr_buff, rptr_buff;
    
    wire wenc = !wfull;
    wire renc = !rempty;
    
    dual_port_RAM ram_inst (
        .wclk(wclk), 
        .wenc(wenc), 
        .waddr(waddr_bin), 
        .wdata(wdata), 
        .rclk(rclk), 
        .renc(renc), 
        .raddr(raddr_bin), 
        .rdata(rdata)
    );
    
    always @(posedge wclk or negedge wrstn)
    begin
        if (~wrstn)
            waddr_bin <= 0;
        else if (winc)
            waddr_bin <= wptr + 1;
    end
    
    always @(posedge rclk or negedge rrstn)
    begin
        if (~rrstn)
            raddr_bin <= 0;
        else if (rinc)
            raddr_bin <= rptr + 1;
    end
    
    always @(posedge wclk)
    begin
        wptr <= wptr_buff ^ (wptr_buff >> 1); // Gray code conversion
        wptr_buff <= wptr;
    end
    
    always @(posedge rclk)
    begin
        rptr <= rptr_buff ^ (rptr_buff >> 1); // Gray code conversion
        rptr_buff <= rptr;
    end
    
    assign wfull = (wptr == ~{1'b0, rptr[($clog2(DEPTH)-2):0]});
    assign rempty = (wptr == rptr);
endmodule

