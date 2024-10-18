module dual_port_RAM
   #(parameter DEPTH = 16, 
     parameter WIDTH = 8)
   (input wclk, 
    input wenc, 
    input [$clog2(DEPTH)-1:0] waddr, 
    input [WIDTH-1:0] wdata, 
    input rclk, 
    input renc, 
    input [$clog2(DEPTH)-1:0] raddr, 
    output reg [WIDTH-1:0] rdata);
    
    reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1];

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

module asyn_fifo
   #(parameter WIDTH = 8, 
     parameter DEPTH = 16)
   (input wclk, 
    input rclk, 
    input wrstn, 
    input rrstn, 
    input winc, 
    input rinc, 
    input [WIDTH-1:0] wdata, 
    output reg wfull, 
    output reg rempty, 
    output reg [WIDTH-1:0] rdata);

    reg [$clog2(DEPTH)-1:0] waddr_bin;
    reg [$clog2(DEPTH)-1:0] raddr_bin;
    reg [$clog2(DEPTH)-1:0] wptr;
    reg [$clog2(DEPTH)-1:0] rptr;
    reg [$clog2(DEPTH)-1:0] wptr_buff;
    reg [$clog2(DEPTH)-1:0] rptr_buff;

    dual_port_RAM #(DEPTH, WIDTH) ram_inst
    (.wclk(wclk), 
     .wenc(winc), 
     .waddr(waddr_bin), 
     .wdata(wdata), 
     .rclk(rclk), 
     .renc(rinc), 
     .raddr(raddr_bin), 
     .rdata(rdata));

    always @(posedge wclk)
    begin
        if(wrstn == 1'b0)
        begin
            wptr <= 0;
            wptr_buff <= 0;
        end
        else
        begin
            waddr_bin <= wptr ^ (wptr >> 1);
            wptr <= wptr + (winc ? 1 : 0);
            wptr_buff <= wptr;
        end
    end

    always @(posedge rclk)
    begin
        if(rrstn == 1'b0)
        begin
            rptr <= 0;
            rptr_buff <= 0;
        end
        else
        begin
            raddr_bin <= rptr ^ (rptr >> 1);
            rptr <= rptr + (rinc ? 1 : 0);
            rptr_buff <= rptr;
        end
    end

    always @(*)
    begin
        wfull = (wptr == {~rptr[$clog2(DEPTH)-1], rptr[$clog2(DEPTH)-2:0]});
        rempty = (rptr == wptr);
    end
endmodule

