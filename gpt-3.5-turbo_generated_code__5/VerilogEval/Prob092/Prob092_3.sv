
module TopModule (
  input [99:0] in,
  output [99:0] out_both,
  output [99:0] out_any,
  output [99:0] out_different
);
  reg [99:0] in_shifted;
  reg [99:0] in_wrapped;

  always @(*) begin
    // Calculate out_both
    out_both[99] = 0; // No left neighbour for in[99]
    for (int i = 98; i >= 0; i = i - 1) begin
      out_both[i] = (in[i] & in_shifted[i]);
    end

    // Calculate out_any
    out_any[0] = 0; // No right neighbour for in[0]
    for (int i = 1; i < 100; i = i + 1) begin
      out_any[i] = (in[i] | in_shifted[i]);
    end

    // Calculate out_different
    out_different[99] = (in[99] != in_wrapped[0]);
    for (int i = 98; i >= 0; i = i - 1) begin
      out_different[i] = (in[i] != in_shifted[i]);
    end
  end

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      in_shifted <= 0;
      in_wrapped <= 0;
    end else begin
      in_shifted <= {in[98:0], 0}; // Shift in to the left by one position
      in_wrapped <= {in[99], in[98:0]}; // Wrap around the vector
    end
  end

endmodule