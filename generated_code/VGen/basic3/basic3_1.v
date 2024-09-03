module full_adder (
  input [15:0] a,
  input [15:0] b,
  input cin,
  output [15:0] sum,
  output cout
);

wire [15:0] c;
assign c = cin ? 1'b1 : 1'b0;

genvar i;
generate
  for (i = 0; i < 16; i = i + 1) begin : adder_loop
    assign sum[i] = a[i] ^ b[i] ^ c;
    assign c = (a[i] & b[i]) | (a[i] & c) | (b[i] & c);
  end
endgenerate

assign cout = c;

endmodule

module priority_encoder( 
  input [2:0] in,
  output reg [1:0] pos
);

always @* begin
  case (in)
    3'b001: pos = 2'b00;
    3'b010: pos = 2'b01;
    3'b011: pos = 2'b10;
    3'b100: pos = 2'b11;
    default: pos = 2'b00;
  endcase
end

endmodule

