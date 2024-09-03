
module dual_port_RAM #(parameter DEPTH = 16, WIDTH = 8)(
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
        if(wenc)
            RAM_MEM[waddr] <= wdata;
    end
    
    always @(posedge rclk) begin
        if(renc)
            rdata <= RAM_MEM[raddr];
    end
    
endmodule

module asyn_fifo #(parameter WIDTH = 8, DEPTH = 16)(
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
    
    reg [$clog2(DEPTH)-1:0] wptr;
    reg [$clog2(DEPTH)-1:0] rptr;
    reg [$clog2(DEPTH)-1:0] wptr_buff;
    reg [$clog2(DEPTH)-1:0] rptr_buff;
    
    wire [WIDTH-1:0] rdata_tmp;
    
    dual_port_RAM #(DEPTH, WIDTH) RAM (
        .wclk(wclk),
        .wenc(~wrstn),
        .waddr(wptr),
        .wdata(wdata),
        .rclk(rclk),
        .renc(rrstn),
        .raddr(rptr),
        .rdata(rdata_tmp)
    );
    
    // Gray code conversion for write pointer
    assign wptr[0] = wptr_buff[0] ^ winc;
    generate
        genvar i;
        for(i = 1; i < $clog2(DEPTH); i = i + 1) begin
            assign wptr[i] = wptr_buff[i-1] ^ wptr_buff[i] ^ winc;
        end
    endgenerate
    
    // Gray code conversion for read pointer
    assign rptr[0] = rptr_buff[0] ^ rinc;
    generate
        genvar j;
        for(j = 1; j < $clog2(DEPTH); j = j + 1) begin
            assign rptr[j] = rptr_buff[j-1] ^ rptr_buff[j] ^ rinc;
        end
    endgenerate
    
    // Synchronize write and read pointers
    always @(posedge wclk or negedge wrstn) begin
        if(~wrstn)
            wptr_buff <= 0;
        else
            wptr_buff <= wptr;
    end
    
    always @(posedge rclk or negedge rrstn) begin
        if(~rrstn)
            rptr_buff <= 0;
        else
            rptr_buff <= rptr;
    end
    
    // Full and empty signals
    always @(*) begin
        if(wptr == {~rptr[$clog2(DEPTH)-1], rptr[$clog2(DEPTH)-2:0]})
            wfull = 1;
        else
            wfull = 0;
        
        if(wptr == rptr)
            rempty = 1;
        else
            rempty = 0;
    end
    
    assign rdata = rempty ? rdata_tmp : rdata;
    
endmodule