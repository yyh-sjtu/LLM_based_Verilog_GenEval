
module accu (
  input clk,
  input rst_n,
  input [7:0] data_in,
  input valid_in,
  output reg valid_out,
  output reg [9:0] data_out
);

  reg [7:0] sum_reg [0:3];
  reg [2:0] count;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      valid_out <= 0;
      data_out <= 0;
      count <= 0;
      sum_reg[0] <= 0;
      sum_reg[1] <= 0;
      sum_reg[2] <= 0;
      sum_reg[3] <= 0;
    end else begin
      if (valid_in) begin
        sum_reg[count] <= data_in;
        count <= count + 1;
        if (count == 3) begin
          valid_out <= 1;
          count <= 0;
          data_out <= sum_reg[0] + sum_reg[1] + sum_reg[2] + sum_reg[3];
        end else begin
          valid_out <= 0;
        end
      end
    end
  end
endmodule