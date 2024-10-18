module alu (
  input [31:0] a,
  input [31:0] b,
  input [5:0] aluc,
  output reg [31:0] r,
  output reg zero,
  output reg carry,
  output reg negative,
  output reg overflow,
  output reg flag
  );
  
  parameter ADD = 6'b100000;
  parameter ADDU = 6'b100001;
  parameter SUB = 6'b100010;
  parameter SUBU = 6'b100011;
  parameter AND = 6'b100100;
  parameter OR = 6'b100101;
  parameter XOR = 6'b100110;
  parameter NOR = 6'b100111;
  parameter SLT = 6'b101010;
  parameter SLTU = 6'b101011;
  parameter SLL = 6'b000000;
  parameter SRL = 6'b000010;
  parameter SRA = 6'b000011;
  parameter SLLV = 6'b000100;
  parameter SRLV = 6'b000110;
  parameter SRAV = 6'b000111;
  parameter LUI = 6'b001111;
  
  reg [31:0] res;
  reg [4:0] shift_amount;
  
  // Assign input operands to signed wires
  wire signed [31:0] signed_a = a;
  wire signed [31:0] signed_b = b;
  
  // Assign output result to lower 32 bits of register
  assign r = res[31:0];
  
  // Assign flag output based on control signal
  assign flag = (aluc == SLT || aluc == SLTU) ? 1'b1 : 1'bz;
  
  // Set zero output based on result
  assign zero = (r == 32'h0) ? 1'b1 : 1'b0;
  
  always @*
  begin
    case (aluc)
      ADD:
        res = signed_a + signed_b;
      ADDU:
        res = a + b;
      SUB:
        res = signed_a - signed_b;
      SUBU:
        res = a - b;
      AND:
        res = a & b;
      OR:
        res = a | b;
      XOR:
        res = a ^ b;
      NOR:
        res = ~(a | b);
      SLT:
        res = (signed_a < signed_b) ? 32'h1 : 32'h0;
      SLTU:
        res = (a < b) ? 32'h1 : 32'h0;
      SLL:
        res = a << b[4:0];
      SRL:
        res = a >> b[4:0];
      SRA:
        res = signed_a >>> b[4:0];
      SLLV:
        res = a << signed_b[4:0];
      SRLV:
        res = a >> signed_b[4:0];
      SRAV:
        res = signed_a >>> signed_b[4:0];
      LUI:
        res = {a[31:16], 16'b0};
      default:
        res = 32'hz;
    endcase
    
    // Set carry output based on result
    carry = (res[31] == 1'b1) ? 1'b1 : 1'b0;
    
    // Set negative output based on result
    negative = (res[31] == 1'b1) ? 1'b1 : 1'b0;
    
    // Set overflow output based on result
    overflow = ((signed_a[31] == signed_b[31]) && (signed_a[31] != res[31]) && (signed_b[31] != res[31])) ? 1'b1 : 1'b0;
  end
  
endmodule

