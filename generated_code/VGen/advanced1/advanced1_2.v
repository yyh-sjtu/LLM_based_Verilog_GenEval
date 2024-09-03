module signed_adder(
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

wire cin;
wire [7:0] sum;
wire co;

assign cin = 1'b0;
assign {co, sum} = a + b + cin;

assign s = sum;
assign overflow = co;

endmodule

