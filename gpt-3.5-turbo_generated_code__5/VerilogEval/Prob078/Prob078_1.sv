
module TopModule (
  input clk,
  input d,
  output q
);

  reg q1;
  reg q2;

  always @(posedge clk) begin
    q1 <= d;
  end
  
  always @(negedge clk) begin
    q2 <= q1;
  end

  assign q = q2;

endmodule