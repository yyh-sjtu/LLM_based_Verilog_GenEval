
module TopModule (
  input clock,
  input a,
  output p,
  output q
);

  reg p;
  reg q;

  always @(posedge clock) begin
    if (a == 1'b1) begin
      p <= a;
      q <= !p;
    end else begin
      p <= 1'b0;
      q <= 1'b0;
    end
  end

endmodule