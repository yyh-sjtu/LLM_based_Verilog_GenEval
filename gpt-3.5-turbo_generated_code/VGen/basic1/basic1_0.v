
// This module assigns the output to the input
module wire_assign(
    input wire in,   // Input signal
    output wire out  // Output signal
);

    // Assign the input directly to the output
    assign out = in;

endmodule
module top_module;
    wire a;        // Define input signal
    wire b;        // Define output signal

    // Instantiate the wire_assign module
    wire_assign u1 (
        .in(a),     // Connect input 'a' to module input 'in'
        .out(b)     // Connect output 'b' to module output 'out'
    );

    // You can drive 'a' with some testbench stimulus or another logic

endmodule