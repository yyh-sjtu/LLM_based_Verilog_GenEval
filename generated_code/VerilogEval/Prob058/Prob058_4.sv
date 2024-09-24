
module TopModule (
    input  wire clk,            // Clock input
    input  wire a,              // Input a
    input  wire b,              // Input b
    output wire out_assign,     // Output from assign statement
    output reg  out_always_comb, // Output from combinational always block
    output reg  out_always_ff   // Output from clocked always block (flip-flop)
);

    // Continuous assignment: simple XOR using assign statement
    assign out_assign = a ^ b;

    // Combinational always block
    always @* begin
        out_always_comb = a ^ b; // Compute XOR
    end

    // Sequential always block (flip-flop)
    always @(posedge clk) begin
        out_always_ff <= a ^ b; // Compute XOR on clock edge
    end

endmodule