
module TopModule (
    input clk,
    input L,
    input q_in,
    input r_in,
    output Q
);

  reg [2:0] r [2:0];
  reg L [2:0];
  reg q_in [2:0];
  wire Q [2:0];

  full_module full_module_inst0 (
      .r(r[0]),
      .L(L[0]),
      .clk(clk),
      .q(Q[0])
  );

  full_module full_module_inst1 (
      .r(r[1]),
      .L(L[1]),
      .clk(clk),
      .q(Q[1])
  );

  full_module full_module_inst2 (
      .r(r[2]),
      .L(L[2]),
      .clk(clk),
      .q(Q[2])
  );

  always @ (posedge clk) begin
      r[0] <= r_in;
      r[1] <= q_in;
      r[2] <= 3'b0;

      L[0] <= L;
      L[1] <= L;
      L[2] <= L;

      q_in[0] <= r_in;
      q_in[1] <= Q[0];
      q_in[2] <= Q[1];
  end

endmodule