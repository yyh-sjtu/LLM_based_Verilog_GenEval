
module TopModule (
    input wire c,        // Input bit c
    input wire d,        // Input bit d
    output wire [3:0] mux_in // 4-bit output for the 4-to-1 multiplexer
);
    wire a, b;          // Assuming a and b are defined somewhere as inputs
    wire w0, w1, w2, w3; // Intermediate wires for the 2-to-1 multiplexers

    // 2-to-1 Mux to produce mux_in[0]
    assign w0 = (c & ~d); // c when d = 0, gives 1 for ab = 01
    assign mux_in[0] = (a == 1'b0) ? 0 : w0;

    // 2-to-1 Mux to produce mux_in[1]
    assign w1 = (c & ~d) | (~c & ~d); // 1 when c & ~d or when c is 0
    assign mux_in[1] = (a == 1'b0) ? w1 : (0); // 0 when a is 1

    // 2-to-1 Mux to produce mux_in[2]
    assign w2 = (c & d); // Only when c and d are both 1
    assign mux_in[2] = (a == 1'b0) ? w2 : (1); // 1 when a is 1 and d is 0

    // 2-to-1 Mux to produce mux_in[3]
    assign w3 = (c & ~d) | (c & d); // c will be 1 for ab=10
    assign mux_in[3] = (a == 1'b0) ? w3 : (1); // 1 when a is 1

endmodule