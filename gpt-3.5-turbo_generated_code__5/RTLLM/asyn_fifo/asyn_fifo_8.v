module dual_port_RAM
  #(parameter DEPTH = 16, WIDTH = 8)
  (input wire wclk, wenc, rclk, renc,
   input wire [clog2(DEPTH)-1:0] waddr, raddr,
   input wire [WIDTH-1:0] wdata,
   output reg [WIDTH-1:0] rdata);
  
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

module asyn_fifo
  #(parameter WIDTH = 8, DEPTH = 16)
  (input wire wclk, rclk, wrstn, rrstn, winc, rinc, 
   input wire [WIDTH-1:0] wdata,
   output reg wfull, rempty,
   output reg [WIDTH-1:0] rdata);
  
  reg [clog2(DEPTH)-1:0] waddr, raddr;
  reg [clog2(DEPTH)-1:0] wptr, rptr;
  reg [clog2(DEPTH)-1:0] wptr_buff, rptr_buff;
  
  dual_port_RAM #(DEPTH, WIDTH) dp_ram_inst (.wclk(wclk), .wenc(winc), .waddr(waddr), .wdata(wdata),
                                              .rclk(rclk), .renc(rinc), .raddr(raddr), .rdata(rdata));
  
  always @(posedge wclk or negedge wrstn)
    begin
      if (~wrstn)
        waddr <= 0;
      else if (winc)
        waddr <= waddr + 1;
      
      wptr <= waddr ^ (waddr >> 1);
      wptr_buff <= (posedge wclk) ? wptr : wptr_buff;
    end
  
  always @(posedge rclk or negedge rrstn)
    begin
      if (~rrstn)
        raddr <= 0;
      else if (rinc)
        raddr <= raddr + 1;
      
      rptr <= raddr ^ (raddr >> 1);
      rptr_buff <= (posedge rclk) ? rptr : rptr_buff;
    end
  
  always @(*)
    begin
      if (wptr == rptr_buff)
        rempty = 1;
      else
        rempty = 0;
      
      if (((rptr_buff + 1) ^ rptr_buff) >> (clog2(DEPTH)-1))
        wfull = 1;
      else
        wfull = 0;
    end
endmodule

