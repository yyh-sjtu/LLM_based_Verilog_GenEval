module d_ff (
  input clk,
  input d,
  input areset,
  output reg q
);

  always @(posedge clk or posedge areset) begin
    if (areset)
      q <= 0;
    else
      q <= d;
  end

endmodule

module top_module (
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q
);

  reg [7:0] q_ff[7:0];

  generate
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin
      d_ff dff_instance (
        .clk(clk),
        .d(d[i]),
        .areset(areset),
        .q(q_ff[i])
      );
    end
  endgenerate

  always @(posedge clk) begin
    if (!areset)
      q <= q_ff;
  end

endmodule

