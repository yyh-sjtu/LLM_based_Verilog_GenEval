
module signed_adder(
   input [7:0] a,
   input [7:0] b,
   output reg [7:0] s,
   output reg overflow
);

   always @ (*)
   begin
      // Perform the addition
      s = a + b;
      
      // Check for overflow by comparing the sign bits of inputs and output
      if ((a[7] == b[7]) && (a[7] != s[7]))
         overflow = 1;
      else
         overflow = 0;
   end
   
endmodule