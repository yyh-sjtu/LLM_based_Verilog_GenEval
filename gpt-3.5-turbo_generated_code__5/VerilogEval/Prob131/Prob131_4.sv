
module A (input x, input y, output z);
  wire tmp;
  
  assign tmp = x ^ y;
  assign z = tmp & x;
endmodule
module B (input x, input y, output z);
  reg z;
  
  always @(x or y) begin
    case ({x, y})
      2'b00: z = 1;
      2'b01: z = 0;
      2'b10: z = 0;
      2'b11: z = 1;
      default: z = 0;
    endcase
  end
endmodule
module Top_Module (input x, input y, output z);
  wire a1_z, a2_z, b1_z, b2_z;
  
  A A1 (x, y, a1_z);
  A A2 (x, y, a2_z);
  B B1 (x, y, b1_z);
  B B2 (x, y, b2_z);
  
  wire or_out, and_out;
  
  assign or_out = a1_z | b1_z;
  assign and_out = a2_z & b2_z;
  assign z = or_out ^ and_out;
endmodule