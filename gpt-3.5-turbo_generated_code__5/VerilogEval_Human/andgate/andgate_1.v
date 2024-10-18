module and_gate (
    input a,
    input b,
    output out
);

    assign out = a & b;

endmodule

module top_module (
    input a,
    input b,
    output out
);

    // Instantiate and_gate module
    and_gate u1 (
        .a(a),
        .b(b),
        .out(out)
    );

endmodule

