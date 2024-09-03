module
module full_adder(
input [15:0] a, b, // 16-bit inputs
input cin,  // Input carry
output [15:0] sum, // Output sum
output cout ); // Output carry

// Internal wires
wire [15:0] c; // Carry array

// Instantiate 16 half adders
half_adder HA0( .a(a[0]), .b(b[0]), .sum(sum[0]), .cout(c[0]) );
half_adder HA1( .a(a[1]), .b(b[1]), .sum(sum[1]), .cout(c[1]) );
// Repeat for the remaining bits...

// Generate carry chain
genvar i;
generate
  for (i = 1; i < 16; i = i + 1) begin : GEN
    half_adder adder( .a(a[i]), .b(b[i]), .sum(sum[i]), .cout(c[i]) );
    assign c[i] = cin & c[i-1]; // Propagate carry
  end
endgenerate

assign cout = c[15]; // Output carry is the carry from the last full adder

endmodule

