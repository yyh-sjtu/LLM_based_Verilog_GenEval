
module ram #(
  parameter ADDR_WIDTH = 6,
  parameter DATA_WIDTH = 8
)
(
  input [DATA_WIDTH-1:0] data,
  input [ADDR_WIDTH-1:0] addr,
  input we,
  input clk,
  output reg [DATA_WIDTH-1:0] q
);

  reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

  always @(posedge clk) begin
    if (we) begin
      ram[addr] <= data;
    end
    q <= ram[addr];
  end

endmodule