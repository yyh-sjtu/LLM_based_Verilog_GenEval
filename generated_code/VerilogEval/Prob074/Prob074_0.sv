
module TopModule (
    input  clk,
    input  x,
    output z
);
    // Internal signals for flip-flop outputs
    reg ff_xor_out;
    reg ff_and_out;
    reg ff_or_out;

    // Flip-Flop behavior on the positive edge of clk
    always @(posedge clk) begin
        ff_xor_out <= x ^ ff_xor_out; // XOR gate with DFF output
        ff_and_out <= x & ~ff_and_out; // AND gate with DFF complemented output
        ff_or_out <= x | ~ff_or_out; // OR gate with DFF complemented output
    end
    
    // Three-input XNOR gate
    assign z = ~(ff_xor_out ^ ff_and_out ^ ff_or_out);

endmodule