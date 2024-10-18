module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire wire1, wire2;
    
    and gate1(a, b, wire1);
    and gate2(c, d, wire2);
    or gate3(wire1, wire2, out);
    not inv_out(out, out_n);

endmodule

