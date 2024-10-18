
module TopModule(
  input  clk,
  input  x,
  output z
);
  
  reg flipflop_x;
  reg flipflop_y;
  reg flipflop_z;
  
  always @(posedge clk)
  begin
    flipflop_x <= x;
    flipflop_y <= ~flipflop_x;
    flipflop_z <= flipflop_x & flipflop_y;
  end
  
  xnor3 xnor_gate(
    flipflop_x,
    ~flipflop_y,
    ~flipflop_z,
    z
  );
  
endmodule

module xnor3(
  input a,
  input b,
  input c,
  output d
);
  
  wire temp;
  
  xnor2 xnor1(
    a,
    b,
    temp
  );
  
  xnor2 xnor2(
    temp,
    c,
    d
  );
  
endmodule

module xnor2(
  input a,
  input b,
  output c
);
  
  wire temp1;
  wire temp2;
  
  not not_gate1(
    a,
    temp1
  );
  
  not not_gate2(
    b,
    temp2
  );
  
  and2 and_gate1(
    a,
    temp2,
    c
  );
  
  and2 and_gate2(
    b,
    temp1,
    c
  );
  
endmodule

module and2(
  input a,
  input b,
  output c
);
  
  and and_gate(
    a,
    b,
    c
  );
  
endmodule

module not(
  input a,
  output b
);
  
  not not_gate(
    a,
    b
  );
  
endmodule