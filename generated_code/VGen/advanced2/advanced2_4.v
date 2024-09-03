module for the 16-bit full adder
module full_adder_16(
   input [15:0] a,
   input [15:0] b,
   input cin,
   output reg [15:0] sum,
   output reg cout
);

// Internal wires for intermediate calculations
wire [15:0] sum_i;
wire [15:0] c_i;

// Implement full adders for each bit
genvar i;
generate
   for(i = 0; i < 16; i = i + 1) begin : gen_full_adder
      full_adder fa(
         .a(a[i]),
         .b(b[i]),
         .cin(c_i[i]),
         .sum(sum_i[i]),
         .cout(c_i[i+1])
      );
   end
endgenerate

assign sum = sum_i;
assign cout = c_i[15];

endmodule

module for the decade counter
module decade_counter(
   input clk,
   input slowena,
   input reset,
   output reg [3:0] q
);

reg [3:0] q_prev;
always @(posedge clk or posedge reset) begin
   if(reset) begin
      q <= 4'b0000;
      q_prev <= 4'b0000;
   end else begin
      q_prev <= q;
      if(slowena && q != 4'b1001) begin
         q <= q + 1;
      end
   end
end

endmodule

