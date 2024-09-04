
module TopModule (
    input  wire a,
    input  wire b,
    output wire out
);

    // Implementing the XNOR logic
    assign out = ~(a ^ b); // XNOR can be implemented with negation of XOR

endmodule
module Testbench;

    reg a;
    reg b;
    wire out;

    // Instantiate the TopModule
    TopModule uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        // Test various combinations of inputs
        $monitor("a=%b, b=%b, out=%b", a, b, out);

        // Test Case 1: a=0, b=0, expect out=1
        a = 0; b = 0; #10;

        // Test Case 2: a=0, b=1, expect out=0
        a = 0; b = 1; #10;

        // Test Case 3: a=1, b=0, expect out=0
        a = 1; b = 0; #10;

        // Test Case 4: a=1, b=1, expect out=1
        a = 1; b = 1; #10;

        $finish;
    end

endmodule