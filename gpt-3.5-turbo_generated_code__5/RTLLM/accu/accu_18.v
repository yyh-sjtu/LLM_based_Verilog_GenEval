
module accu (
  input         clk,
  input         rst_n,
  input  [7:0]  data_in,
  input         valid_in,
  output        valid_out,
  output [9:0]  data_out
);

  reg  [9:0] data_out_reg;
  reg        valid_out_reg;
  reg  [2:0] count;

  always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
      data_out_reg   <= 0;
      valid_out_reg  <= 0;
      count          <= 0;
    end else begin
      if (valid_in) begin
        data_out_reg  <= data_out_reg + data_in;
        count         <= count + 1;
        if (count == 3) begin
          valid_out_reg <= 1;
          count        <= 0;
        end else begin
          valid_out_reg <= 0;
        end
      end
    end
  end

  assign valid_out = valid_out_reg;
  assign data_out  = data_out_reg;

endmodule