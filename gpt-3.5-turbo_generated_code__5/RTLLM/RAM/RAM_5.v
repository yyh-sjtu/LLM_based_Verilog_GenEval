module RAM #
  (
  parameter WIDTH = 6,
  parameter DEPTH = 8
  )
  (
  input clk, rst_n, write_en, read_en,
  input [WIDTH-1:0] write_addr,
  input [WIDTH-1:0] read_addr,
  input [WIDTH-1:0] write_data,
  output reg [WIDTH-1:0] read_data
  );
  
  reg [WIDTH-1:0] RAM [2**WIDTH-1:0];
  reg [WIDTH-1:0] read_data_temp;
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      for (int i = 0; i < 2**WIDTH; i = i+1) begin
        RAM[i] <= 6'b000000;
      end
    end
    else if (write_en) begin
      RAM[write_addr] <= write_data;
    end
  end
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      read_data_temp <= 6'b000000;
    end
    else if (read_en) begin
      read_data_temp <= RAM[read_addr];
    end
    else begin
      read_data_temp <= 6'b000000;
    end
  end
  
  always @(posedge clk) begin
    read_data <= read_data_temp;
  end

endmodule

