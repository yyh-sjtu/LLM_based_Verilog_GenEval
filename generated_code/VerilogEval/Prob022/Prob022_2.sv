
module TopModule (
    input wire a,      // Input a
    input wire b,      // Input b
    input wire sel,    // Select signal
    output wire out    // Output
);

    assign out = (sel == 1'b0) ? a : b;  // Multiplexer logic

endmodule