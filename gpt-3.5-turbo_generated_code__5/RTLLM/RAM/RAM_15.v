
module RAM #(parameter WIDTH=6, DEPTH=8) (
  input wire clk,
  input wire rst_n,
  input wire write_en,
  input wire [WIDTH-1:0] write_addr,
  input wire [WIDTH-1:0] write_data,
  input wire read_en,
  input wire [WIDTH-1:0] read_addr,
  output wire [WIDTH-1:0] read_data
);

  reg [WIDTH-1:0] RAM [DEPTH-1:0];

  // Write Operation
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      RAM <= '{DEPTH{WIDTH'h00}};
    end else begin
      if (write_en) begin
        RAM[write_addr] <= write_data;
      end
    end
  end

  // Read Operation
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      read_data <= {WIDTH{1'b0}};
    end else begin
      if (read_en) begin
        read_data <= RAM[read_addr];
      end else begin
        read_data <= {WIDTH{1'b0}};
      end
    end
  end

endmodule