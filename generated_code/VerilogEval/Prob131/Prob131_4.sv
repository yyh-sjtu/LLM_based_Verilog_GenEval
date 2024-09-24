
module A(
    input wire x,
    input wire y,
    output wire z
);
    assign z = (x ^ y) & x;
endmodule

module B(
    input wire x,
    input wire y,
    output wire z
);
    assign z = (x & y) | (~x & ~y);
endmodule

module TopModule(
    input wire x,
    input wire y,
    output wire z
);
    wire z_A1, z_A2;
    wire z_B1, z_B2;
    wire or_out, and_out;
    
    // Instantiate A modules
    A A1 (.x(x), .y(y), .z(z_A1));
    A A2 (.x(x), .y(y), .z(z_A2));
    
    // Instantiate B modules
    B B1 (.x(x), .y(y), .z(z_B1));
    B B2 (.x(x), .y(y), .z(z_B2));
    
    // OR gate connecting outputs of first A and B
    assign or_out = z_A1 | z_B1;
    
    // AND gate connecting outputs of second A and B
    assign and_out = z_A2 & z_B2;
    
    // XOR gate to produce final output
    assign z = or_out ^ and_out;
endmodule