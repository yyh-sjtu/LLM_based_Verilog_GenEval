
module RAM (
  input clk,
  input rst_n,
  input write_en,
  input [WIDTH-1:0] write_addr,
  input [WIDTH-1:0] write_data,
  input read_en,
  input [WIDTH-1:0] read_addr,
  output reg [WIDTH-1:0] read_data
);

  parameter WIDTH = 6;
  parameter DEPTH = 8;

  reg [WIDTH-1:0] RAM [2**WIDTH-1:0];

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      for (int i = 0; i < 2**WIDTH; i = i + 1) begin
        RAM[i] <= 'b000000;
      end
    end else if (write_en) begin
      RAM[write_addr] <= write_data;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      read_data <= 'b000000;
    end else if (read_en) begin
      read_data <= RAM[read_addr];
    end else begin
      read_data <= 'b000000;
    end
  end

endmodule