
module TopModule(
  input clk,
  input [7:0] in,
  input [7:0] anyedge,
  output [7:0] out
);
  reg [7:0] prev_in;

  always @(posedge clk) begin
    // Detect any edge for each bit
    for (int i = 0; i < 8; i = i + 1) begin
      if (anyedge[i] && (in[i] != prev_in[i]))
        out[i] <= 1'b1;  // Set output bit after a 0 to 1 transition
      else
        out[i] <= 1'b0;
    end

    prev_in <= in;  // Store current input as previous input for next cycle
  end
endmodule