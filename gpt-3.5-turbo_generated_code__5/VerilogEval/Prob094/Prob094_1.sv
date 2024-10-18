
module TopModule (
  input [3:0] in,
  output reg [3:0] out_both,
  output reg [3:0] out_any,
  output reg [3:0] out_different
);

  always @* begin
    // Calculation for out_both
    out_both[0] = 0; // in[0] has no neighbour to the left
    out_both[1] = in[0] & in[1];
    out_both[2] = in[1] & in[2];
    out_both[3] = in[2] & in[3];

    // Calculation for out_any
    out_any[3] = in[2] | in[3]; // in[3] has no neighbour to the right
    out_any[2] = in[1] | in[2];
    out_any[1] = in[0] | in[1];
    out_any[0] = in[3] | in[0];

    // Calculation for out_different
    out_different[3] = in[2] != in[3];
    out_different[2] = in[1] != in[2];
    out_different[1] = in[0] != in[1];
    out_different[0] = in[3] != in[0];
  end

endmodule