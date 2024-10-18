
module TopModule (
  input [99:0] in,
  output [99:0] out_both,
  output [99:0] out_any,
  output [99:0] out_different
);

  genvar i;

  // Calculate out_both
  generate
    for (i = 0; i < 100; i++) begin
      if (i == 0) begin
        out_both[i] = (in[i] & in[i+1]);
      end else if (i == 99) begin
        out_both[i] = 0;
      end else begin
        out_both[i] = (in[i] & in[i+1]);
      end
    end
  endgenerate

  // Calculate out_any
  generate
    for (i = 0; i < 100; i++) begin
      if (i == 0) begin
        out_any[i] = (in[i] | in[i+1]);
      end else if (i == 99) begin
        out_any[i] = 0;
      end else begin
        out_any[i] = (in[i] | in[i+1]);
      end
    end
  endgenerate

  // Calculate out_different
  generate
    for (i = 0; i < 100; i++) begin
      if (i == 0) begin
        out_different[i] = (in[i] != in[99]);
      end else begin
        out_different[i] = (in[i] != in[i-1]);
      end
    end
  endgenerate

endmodule