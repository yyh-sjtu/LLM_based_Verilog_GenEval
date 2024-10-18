
module adder_8bit (input [7:0] a, input [7:0] b, input cin, output [7:0] sum, output cout);

  // Internal wire declarations
  wire [7:0] carries; // Carry outputs from each bit-level adder

  // Bit-level adder instantiation
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin : bit_adder
      full_adder fa(.a(a[i]), .b(b[i]), .cin(i ? carries[i-1] : cin), .sum(sum[i]), .cout(carries[i]));
    end
  endgenerate

  // Carry-out
  assign cout = carries[7];

endmodule

module full_adder (input a, input b, input cin, output sum, output cout);
  assign {cout, sum} = a + b + cin;
endmodule