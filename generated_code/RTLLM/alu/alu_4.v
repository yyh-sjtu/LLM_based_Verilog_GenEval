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

// Define Operations
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

// Define Internal Wires
reg [31:0] res;
reg [1:0] shift_amount;

// Assign Inputs to Registers
always @(*)
begin
    case(aluc)
        ADD: res = a + b;
        ADDU: res = a + b;
        SUB: res = a - b;
        SUBU: res = a - b;
        AND: res = a & b;
        OR: res = a | b;
        XOR: res = a ^ b;
        NOR: res = ~(a | b);
        SLT: res = (a < b) ? 1 : 0;
        SLTU: res = (a < b) ? 1 : 0;
        SLL: res = a << b[4:0];
        SRL: res = a >> b[4:0];
        SRA: res = a >>> b[4:0];
        SLLV: res = a << b[4:0];
        SRLV: res = a >> b[4:0];
        SRAV: res = a >>> b[4:0];
        LUI: res = {a[15:0], 16'b0};
        default: res = 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
    endcase
    
    // Set Zero Flag
    if (res == 0)
        zero = 1;
    else
        zero = 0;
    
    // Set Negative Flag
    if (res[31] == 1)
        negative = 1;
    else
        negative = 0;
    
    // Set Carry Flag
    // Not implemented in this code
    
    // Set Overflow Flag
    // Not implemented in this code

    // Set Flag based on Control Signal
    if (aluc == SLT || aluc == SLTU)
        flag = 1;
    else
        flag = 0;
end

// Assign Result to Output
assign r = res;

endmodule

