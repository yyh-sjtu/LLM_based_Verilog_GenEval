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
    and_gate and1 (
        .a(a),
        .b(b),
        .out(out)
    );
endmodule

