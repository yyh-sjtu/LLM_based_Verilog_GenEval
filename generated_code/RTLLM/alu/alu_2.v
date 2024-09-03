
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
reg flag;

always @(*) begin
    zero = (res == 0);
    carry = (res < a);
    negative = (res[31] == 1);
    overflow = ((a[31] == b[31]) && (res[31] != a[31]));
    flag = (aluc == SLT || aluc == SLTU) ? 1'b1 : 1'bz;
    
    case(aluc)
        ADD: res = a + b;
        ADDU: res = a + b;
        SUB: res = a - b;
        SUBU: res = a - b;
        AND: res = a & b;
        OR: res = a | b;
        XOR: res = a ^ b;
        NOR: res = ~(a | b);
        SLT:
        begin
            if (a < b)
                res = 32'b1;
            else
                res = 32'b0;
        end
        SLTU:
        begin
            if (a < b)
                res = 32'b1;
            else
                res = 32'b0;
        end
        SLL: res = a << b[4:0];
        SRL: res = a >> b[4:0];
        SRA: res = $signed(a) >>> b[4:0];
        SLLV: res = a << b[4:0];
        SRLV: res = a >> b[4:0];
        SRAV: res = $signed(a) >>> b[4:0];
        LUI: res = {a[15:0], 16'b0};
        default: res = 32'bz;
    endcase
end

endmodule