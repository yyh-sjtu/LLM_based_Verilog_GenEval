
module TopModule(
  input clock,
  input a,
  output reg p,
  output reg q
);

  reg Q;

  always @(posedge clock) begin
    if (Q == 1'b0 && a == 1'b1) begin
      p <= 1'b1;
      q <= 1'b0;
      Q <= 1'b1;
    end else if (Q == 1'b1 && a == 1'b0) begin
      p <= 1'b0;
      q <= 1'b0;
      Q <= 1'b0;
    end else if (Q == 1'b0 && a == 1'b0) begin
      p <= 1'b0;
      q <= 1'b0;
      Q <= 1'b0;
    end else if (Q == 1'b1 && a == 1'b1) begin
      p <= 1'b1;
      q <= 1'b1;
      Q <= 1'b1;
    end
  end

endmodule