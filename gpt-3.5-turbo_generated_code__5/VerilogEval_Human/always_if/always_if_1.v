module mux_assign (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output reg out
);

    assign out_assign = (sel_b1 && sel_b2) ? b : a;

endmodule

module mux_procedural (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output reg out_always
);

    always @* begin
        if (sel_b1 && sel_b2) begin
            out_always = b;
        end else begin
            out_always = a;
        end
    end

endmodule

module top_module (
    input a,
    input b,
    input sel_b1,
    input sel_b2,
    output out_assign,
    output reg out_always
);

mux_assign mux_inst1(
    .a(a),
    .b(b),
    .sel_b1(sel_b1),
    .sel_b2(sel_b2),
    .out_assign(out_assign)
);

mux_procedural mux_inst2(
    .a(a),
    .b(b),
    .sel_b1(sel_b1),
    .sel_b2(sel_b2),
    .out_always(out_always)
);

endmodule

