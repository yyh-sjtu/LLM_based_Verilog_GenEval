
module dual_port_RAM (
  input wclk, input wenc, input [$clog2(DEPTH)-1:0] waddr, input [WIDTH-1:0] wdata,
  input rclk, input renc, input [$clog2(DEPTH)-1:0] raddr, 
  output reg [WIDTH-1:0] rdata
);

  // Dual-port RAM implementation goes here

endmodule

module asyn_fifo (
  input wclk, input rclk, input wrstn, input rrstn, input winc, input rinc, input [WIDTH-1:0] wdata,
  output reg wfull, output reg rempty, output reg [WIDTH-1:0] rdata
);

  localparam WIDTH = 8;
  localparam DEPTH = 16;

  reg [$clog2(DEPTH)-1:0] waddr_bin, raddr_bin;    // Binary write and read pointers
  reg [WIDTH-1:0] wptr, rptr, wptr_buff, rptr_buff; // Gray code converted write and read pointers

  // Asynchronous FIFO implementation goes here

endmodule