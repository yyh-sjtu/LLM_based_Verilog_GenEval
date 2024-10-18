
module RAM (
  input wire clk,        // Clock signal
  input wire rst_n,      // Reset signal (active low)
  input wire write_en,   // Write enable signal
  input wire [WIDTH-1:0] write_addr,   // Write address
  input wire [WIDTH-1:0] write_data,   // Data to be written
  input wire read_en,    // Read enable signal
  input wire [WIDTH-1:0] read_addr,    // Read address
  output wire [WIDTH-1:0] read_data     // Data read from RAM
);

  parameter WIDTH = 6;   // Bit width of RAM data
  parameter DEPTH = 8;   // Depth of RAM

  reg [WIDTH-1:0] RAM [0:(1<<WIDTH)-1];   // RAM array

  // Write operation
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin   // Reset
      for (integer i = 0; i < (1<<WIDTH); i = i + 1)
        RAM[i] <= 6'b000000;
    end else begin
      if (write_en)   // Write enable
        RAM[write_addr] <= write_data;   // Write data to specified address
    end
  end

  // Read operation
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin   // Reset
      read_data <= 6'b000000;
    end else begin
      if (read_en)    // Read enable
        read_data <= RAM[read_addr];   // Read data from specified address
      else
        read_data <= 6'b000000;   // Clear read data
    end
  end

endmodule