
module top_level_module (
    input wire x,
    input wire y,
    output wire z
);

    wire a1_out, a2_out, b1_out, b2_out;
    wire or_out, and_out;
    
    // Instantiate Module A
    module A A1 (
        .x(x),
        .y(y),
        .z(a1_out)
    );
    
    module A A2 (
        .x(x),
        .y(y),
        .z(a2_out)
    );

    // Instantiate Module B
    module B B1 (
        .x(x),
        .y(y),
        .z(b1_out)
    );
    
    module B B2 (
        .x(x),
        .y(y),
        .z(b2_out)
    );

    // OR gate connecting outputs of A1 and B1
    assign or_out = a1_out | b1_out;

    // AND gate connecting outputs of A2 and B2
    assign and_out = a2_out & b2_out;

    // XOR gate connecting outputs of OR and AND gates
    assign z = or_out ^ and_out;

endmodule