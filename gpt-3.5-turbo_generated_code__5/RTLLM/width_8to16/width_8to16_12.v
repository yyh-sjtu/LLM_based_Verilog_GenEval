
module width_8to16 (
  input wire clk,
  input wire rst_n,
  input wire valid_in,
  input wire [7:0] data_in,
  output reg valid_out,
  output reg [15:0] data_out
);

  reg [7:0] data_latch;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      valid_out <= 0;
      data_out <= 16'b0;
      data_latch <= 8'b0;
    end else begin
      if (valid_in) begin
        if (valid_out) begin
          data_out <= {data_in, data_latch};
          valid_out <= 1;
        end else begin
          data_latch <= data_in;
          valid_out <= 0;
        end
      end
    end
  end
endmodule