
module TopModule (
    input wire a,    // Input a
    input wire b,    // Input b
    input wire sel,  // Selector input
    output wire out  // Output
);

    // Mux functionality implementation
    assign out = (sel) ? b : a;

endmodule