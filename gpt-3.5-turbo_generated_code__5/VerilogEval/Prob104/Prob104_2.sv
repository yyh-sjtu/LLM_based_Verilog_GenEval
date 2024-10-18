
module flipflop (
  input clk, 
  input r_in, 
  output reg Q
);
  
  always @(posedge clk) begin
    if (r_in)
      Q <= 1'b0;
    else
      Q <= 1'b1;
  end
  
endmodule

module mux21 (
  input L, 
  input q_in, 
  input r_in, 
  output reg Q
);
  
  always @(*) begin
    if (L)
      Q <= r_in;
    else
      Q <= q_in;
  end
  
endmodule

module TopModule (
  input clk, 
  input L, 
  input q_in, 
  input r_in, 
  output Q
);

  wire [2:0] q_out;
  reg [2:0] r;

  flipflop u1 (.clk(clk), .r_in(r_in), .Q(q_out[0]));
  
  mux21 u2 (.L(L), .q_in(q_in), .r_in(r_out[1]), .Q(q_out[1]));
  
  mux21 u3 (.L(L), .q_in(q_out[1]), .r_in(r_out[2]), .Q(q_out[2]));
  
  full_module u4 (.r(r), .L(L), .clk(clk), .q(Q));
  
endmodule
