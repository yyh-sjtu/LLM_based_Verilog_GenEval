module for the signed adder
module signed_adder(input [7:0] a, input [7:0] b, output reg [7:0] s, output reg overflow);

  // Designing the full adder for each bit of the numbers
  genvar i;
  generate
    for(i = 0; i < 8; i = i + 1) begin : full_adder_gen
      assign s[i] = a[i] ^ b[i] ^ overflow;
      assign overflow = (a[i] & b[i]) | (a[i] & overflow) | (b[i] & overflow);
    end
  endgenerate
  
endmodule

