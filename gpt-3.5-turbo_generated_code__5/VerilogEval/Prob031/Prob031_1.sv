
module TopModule (
  input clk,
  input d,
  input q
);

  reg q_next;

  always @(posedge clk) begin
    q_next <= d;
  end

  assign q = q_next;

endmodule