
module TopModule (
    input  wire a,
    input  wire b,
    output wire out_and,
    output wire out_or,
    output wire out_xor,
    output wire out_nand,
    output wire out_nor,
    output wire out_xnor,
    output wire out_anotb
);

    // Implementing the logic gates
    assign out_and   = a & b;        // AND operation
    assign out_or    = a | b;        // OR operation
    assign out_xor   = a ^ b;        // XOR operation
    assign out_nand  = ~(a & b);     // NAND operation
    assign out_nor   = ~(a | b);     // NOR operation
    assign out_xnor  = ~(a ^ b);     // XNOR operation
    assign out_anotb = a & ~b;       // AND-NOT operation (a and not b)

endmodule