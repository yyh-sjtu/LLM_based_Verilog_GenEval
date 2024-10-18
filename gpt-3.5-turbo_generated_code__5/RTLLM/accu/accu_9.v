
module accu (
  input clk,
  input rst_n,
  input [7:0] data_in,
  input valid_in,
  output reg valid_out,
  output reg [9:0] data_out
);

  reg [9:0] sum;
  reg [2:0] count;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      valid_out <= 0;
      sum <= 0;
      count <= 0;
    end else begin
      if (valid_in) begin
        sum <= sum + data_in;
        count <= count + 1;
        if (count == 3) begin
          data_out <= sum;
          valid_out <= 1;
          sum <= 0;
          count <= 0;
        end
      end
    end
  end
endmodule