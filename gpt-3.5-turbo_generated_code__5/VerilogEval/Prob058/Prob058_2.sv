
module TopModule (
    input  clk,
    input  a,
    input  b,
    output out_assign,
    output out_always_comb,
    output out_always_ff
);

    // Using assign statement
    assign out_assign = a ^ b;

    // Using combinational always block
    always @*
        out_always_comb = a ^ b;

    // Using clocked always block
    reg out_ff;
    always @(posedge clk)
        out_ff <= a ^ b;
    assign out_always_ff = out_ff;

endmodule