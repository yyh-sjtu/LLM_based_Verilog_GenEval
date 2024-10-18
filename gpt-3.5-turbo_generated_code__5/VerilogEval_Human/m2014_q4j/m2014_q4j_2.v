module top_module (
  input [3:0] x,
  input [3:0] y,
  output [4:0] sum
);

  wire [3:0] carry;
  
  full_adder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .s(sum[0]), .cout(carry[0]));
  full_adder fa1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .s(sum[1]), .cout(carry[1]));
  full_adder fa2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .s(sum[2]), .cout(carry[2]));
  full_adder fa3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .s(sum[3]), .cout(sum[4]));
  
endmodule

module full_adder (
  input wire a,
  input wire b,
  input wire cin,
  output wire s,
  output wire cout
);
  
  wire c1, c2;
  
  xor_gate xor0 (.a(a), .b(b), .x(c1));
  xor_gate xor1 (.a(c1), .b(cin), .x(s));
  and_gate and0 (.a(c1), .b(cin), .x(c2));
  and_gate and1 (.a(a), .b(b), .x(carry));
  or_gate or0 (.a(c2), .b(carry), .x(cout));
  
endmodule

module xor_gate (
  input wire a,
  input wire b,
  output wire x
);
  
  assign x = a ^ b;
  
endmodule

module and_gate (
  input wire a,
  input wire b,
  output wire x
);
  
  assign x = a & b;
  
endmodule

module or_gate (
  input wire a,
  input wire b,
  output wire x
);
  
  assign x = a | b;
  
endmodule

