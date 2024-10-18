
module alu (
  input wire [31:0] a,
  input wire [31:0] b,
  input wire [5:0] aluc,
  output wire [31:0] r,
  output wire zero,
  output wire carry,
  output wire negative,
  output wire overflow,
  output wire flag
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

  wire [31:0] res;

  reg zero;
  reg carry;
  reg negative;
  reg overflow;
  reg flag;

  always @(*) begin
    case (aluc)
      ADD: res = a + b;
      ADDU: res = a + b;
      SUB: res = a - b;
      SUBU: res = a - b;
      AND: res = a & b;
      OR: res = a | b;
      XOR: res = a ^ b;
      NOR: res = ~(a | b);
      SLT: begin
        res = (a < b) ? 32'b1 : 32'b0;
        flag = 1'b1;
      end
      SLTU: begin
        res = (a < b) ? 32'b1 : 32'b0;
        flag = 1'b1;
      end
      SLL: begin
        res = a << b[4:0];
        flag = 1'bz;
      end
      SRL: begin
        res = a >> b[4:0];
        flag = 1'bz;
      end
      SRA: begin
        res = $signed(a) >>> b[4:0];
        flag = 1'bz;
      end
      SLLV: begin
        res = a << b;
        flag = 1'bz;
      end
      SRLV: begin
        res = a >> b;
        flag = 1'bz;
      end
      SRAV: begin
        res = $signed(a) >>> b;
        flag = 1'bz;
      end
      LUI: begin
        res = {a[15:0], 16'b0};
        flag = 1'bz;
      end
      default: res = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
    endcase

    zero = (res == 32'b0) ? 1'b1 : 1'b0;
    carry = (res[31] != b[31]) ? 1'b1 : 1'b0;
    negative = (res[31] == 1'b1) ? 1'b1 : 1'b0;
    overflow = (a[31] == b[31] && res[31] != a[31]) ? 1'b1 : 1'b0;
  end
  
  assign r = res;

endmodule