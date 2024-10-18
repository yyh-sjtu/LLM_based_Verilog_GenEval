
module RAM #(parameter WIDTH = 6, DEPTH = 8) (
  input clk,
  input rst_n,
  input write_en,
  input [WIDTH-1:0] write_addr,
  input [WIDTH-1:0] write_data,
  input read_en,
  input [WIDTH-1:0] read_addr,
  output [WIDTH-1:0] read_data
);

  reg [DEPTH-1:0] RAM [2**WIDTH-1:0];
  reg [WIDTH-1:0] read_data;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Reset
      for (integer i=0; i<2**WIDTH; i=i+1) begin
        RAM[i] <= 6'b000000;
      end
    end else if (write_en) begin
      // Write Operation
      RAM[write_addr] <= write_data;
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      // Reset
      read_data <= 6'b000000;
    end else if (read_en) begin
      // Read Operation
      read_data <= RAM[read_addr];
    end else begin
      read_data <= 6'b000000;
    end
  end

endmodule