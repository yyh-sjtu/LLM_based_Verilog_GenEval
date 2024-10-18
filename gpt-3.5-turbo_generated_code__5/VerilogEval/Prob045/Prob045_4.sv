
module TopModule (
  input clk,
  input [7:0] in,
  input [7:0] anyedge,
  output reg [7:0] output
);

  reg [7:0] prev_in;

  always @(posedge clk) begin
    prev_in <= in;

    for (integer i = 0; i < 8; i = i + 1) begin
      if (anyedge[i] && (in[i] != prev_in[i]))
        output[i] <= 1'b1;
      else
        output[i] <= 1'b0;
    end
  end

endmodule