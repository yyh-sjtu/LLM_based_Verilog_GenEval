
module TopModule(
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

  reg internal_Q;

  always @(posedge clk) begin
    if (E) begin
      if (L) begin
        internal_Q <= R;
      end
      else begin
        internal_Q <= w;
      end
    end
  end

  assign Q = internal_Q;

endmodule