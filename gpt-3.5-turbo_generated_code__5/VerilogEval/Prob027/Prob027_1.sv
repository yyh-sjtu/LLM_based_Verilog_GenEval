module TopModule(
   input a,
   input b,
   input cin,
   output cout,
   output sum
);

   wire carry1, carry2;

   // XOR gates for sum calculation
   assign sum = a ^ b ^ cin;

   // AND gates for carry calculation
   assign carry1 = a & b;
   assign carry2 = a & cin;
   assign cout = carry1 | carry2;

endmodule

