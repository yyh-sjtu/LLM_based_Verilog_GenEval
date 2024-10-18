module alu(
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

// operation parameters
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

// result and temporary storage
reg [31:0] res;
reg [31:0] shiftamt;

always @* begin
    // set defaults
    r = 32'b0;
    zero = 1'b0;
    carry = 1'b0;
    negative = 1'b0;
    overflow = 1'b0;
    flag = 1'bz;

    // perform the operation based on the control signal (aluc)
    case (aluc)
        ADD, ADDU: begin
            res = a + b;
            r = res;
        end
        SUB, SUBU: begin
            res = a - b;
            r = res;
        end
        AND: begin
            res = a & b;
            r = res;
        end
        OR: begin
            res = a | b;
            r = res;
        end
        XOR: begin
            res = a ^ b;
            r = res;
        end
        NOR: begin
            res = ~(a | b);
            r = res;
        end
        SLT: begin
            if (a < b)
                flag = 1'b1;
        end
        SLTU: begin
            if (a < b)
                flag = 1'b1;
        end
        SLL: begin
            shiftamt = b[4:0];
            res = a << shiftamt;
            r = res;
        end
        SRL: begin
            shiftamt = b[4:0];
            res = a >> shiftamt;
            r = res;
        end
        SRA: begin
            shiftamt = b[4:0];
            res = $signed(a) >>> shiftamt;
            r = res;
        end
        SLLV: begin
            res = a << b[4:0];
            r = res;
        end
        SRLV: begin
            res = a >> b[4:0];
            r = res;
        end
        SRAV: begin
            res = $signed(a) >>> b[4:0];
            r = res;
        end
        LUI: begin
            res = {a[31:16], 16'b0};
            r = res;
        end
        default: begin
            r = 32'bz;
        end
    end

    // set zero and negative flags
    if (res == 32'b0)
        zero = 1'b1;
    if (res < 0)
        negative = 1'b1;

    // set carry and overflow flags
    // ... (implementation dependent)
end

endmodule

