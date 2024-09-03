module full_adder(
  input [15:0] a,
  input [15:0] b,
  input cin,
  output reg [15:0] sum,
  output reg cout
);

  always @(*)
  begin
    {cout, sum} = a + b + cin;
  end
  
endmodule

