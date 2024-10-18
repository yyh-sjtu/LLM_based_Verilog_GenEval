module asyn_fifo (
    input wclk, // Write clock signal used for synchronous write operations
    input rclk, // Read clock signal used for synchronous read operations
    input wrstn, // Write reset signal (active low)
    input rrstn, // Read reset signal (active low)
    input winc, // Write increment signal
    input rinc, // Read increment signal
    input [WIDTH-1:0] wdata, // Write data input
    output reg wfull, // Write full signal
    output reg rempty, // Read empty signal
    output reg [WIDTH-1:0] rdata // Read data output
);

parameter WIDTH = 8; // Width of the FIFO data
parameter DEPTH = 16; // Depth of the FIFO

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1]; // Dual-port RAM for data storage

reg [$clog2(DEPTH)-1:0] waddr; // Write address for RAM
reg [$clog2(DEPTH)-1:0] raddr; // Read address for RAM
reg [WIDTH-1:0] wptr; // Write pointer
reg [WIDTH-1:0] rptr; // Read pointer
reg [WIDTH-1:0] wptr_buff; // Write pointer buffer
reg [WIDTH-1:0] rptr_buff; // Read pointer buffer

// Write enable and read enable signals for RAM
reg wen;
reg ren;

// Dual-port RAM module instantiation
dual_port_RAM RAM_inst (
    .wclk(wclk),
    .wenc(wen),
    .waddr(waddr),
    .wdata(wdata),
    .rclk(rclk),
    .renc(ren),
    .raddr(raddr),
    .rdata(rdata)
);

// Gray code conversion for write pointer
always @ (posedge wclk or negedge wrstn) begin
    if (~wrstn) begin
        wptr <= 0;
    end else begin
        wptr <= (wptr ^ (wptr >> 1));
    end
end

// Gray code conversion for read pointer
always @ (posedge rclk or negedge rrstn) begin
    if (~rrstn) begin
        rptr <= 0;
    end else begin
        rptr <= (rptr ^ (rptr >> 1));
    end
end

// Pointer buffer update
always @ (posedge wclk or negedge wrstn) begin
    if (~wrstn) begin
        wptr_buff <= 0;
    end else begin
        wptr_buff <= wptr;
    end
end

always @ (posedge rclk or negedge rrstn) begin
    if (~rrstn) begin
        rptr_buff <= 0;
    end else begin
        rptr_buff <= rptr;
    end
end

// Full and Empty condition check
always @ (*) begin
    if ((wptr == rptr_buff) && (wptr_buff != rptr)) begin
        wfull <= 1;
    end else begin
        wfull <= 0;
    end
    
    if (rptr == wptr) begin
        rempty <= 1;
    else begin
        rempty <= 0;
    end
end

// Write and Read Pointer Increment
always @ (posedge wclk) begin
    if (winc && ~wfull) begin
        wen <= 1;
        waddr <= wptr;
    end else begin
        wen <= 0;
    end
end

always @ (posedge rclk) begin
    if (rinc && ~rempty) begin
        ren <= 1;
        raddr <= rptr;
    end else begin
        ren <= 0;
    end
end

endmodule

module dual_port_RAM (
    input wclk, // Write clock signal
    input wenc, // Write enable signal
    input [$clog2(DEPTH)-1:0] waddr, // Write address
    input [WIDTH-1:0] wdata, // Write data input
    input rclk, // Read clock signal
    input renc, // Read enable signal
    input [$clog2(DEPTH)-1:0] raddr, // Read address
    output reg [WIDTH-1:0] rdata // Read data output
);

reg [WIDTH-1:0] RAM_MEM [0:DEPTH-1]; // Dual-port RAM for data storage

// Write operation
always @ (posedge wclk) begin
    if (wenc) begin
        RAM_MEM[waddr] <= wdata;
    end
end

// Read operation
always @ (posedge rclk) begin
    if (renc) begin
        rdata <= RAM_MEM[raddr];
    end
end

endmodule

