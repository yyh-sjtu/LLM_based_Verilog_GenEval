module full_adder(
input wire [15:0] A,
input wire [15:0] B,
input wire Cin,
output reg [15:0] Sum,
output reg Cout
);

// Internal wire declaration
wire [15:0] XOR1_output;
wire [15:0] XOR2_output;
wire [15:0] AND1_output;
wire [15:0] AND2_output;
wire [15:0] AND3_output;
wire [15:0] OR1_output;

// Implementing XOR gates
genvar i;
generate
  for(i=0; i<16; i=i+1) begin : xor_generate
    assign XOR1_output[i] = A[i] ^ B[i];
    assign XOR2_output[i] = XOR1_output[i] ^ Cin;
  end
endgenerate

// Implementing AND gates
genvar j;
generate
  for(j=0; j<16; j=j+1) begin : and_generate
    assign AND1_output[j] = A[j] & B[j];
    assign AND2_output[j] = A[j] & XOR1_output[j];
    assign AND3_output[j] = B[j] & XOR1_output[j];
  end
endgenerate

// Implementing OR gate
genvar k;
generate
  for (k=0; k<16; k=k+1) begin : or_generate
    assign Sum[k] = XOR2_output[k];
    assign Cout = (AND1_output[k] | AND2_output[k] | AND3_output[k]);
  end
endgenerate

endmodule

module priority_encoder( 
input [2:0] in,
output reg [1:0] pos );

// Implementing the priority encoder
always @* begin
  case(in)
    3'b000 : pos = 2'b00;
    3'b001 : pos = 2'b01;
    3'b010 : pos = 2'b01;
    3'b011 : pos = 2'b10;
    3'b100 : pos = 2'b00;
    3'b101 : pos = 2'b01;
    3'b110 : pos = 2'b10;
    3'b111 : pos = 2'b11;
  endcase
end

endmodule

