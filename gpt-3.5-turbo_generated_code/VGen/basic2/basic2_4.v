
// This is a module that implements an AND gate
module and_gate( 
    input a, 
    input b, 
    output out 
);
    // Internal logic for AND operation
    assign out = a & b;
endmodule
module tb_and_gate;
    reg a;
    reg b;
    wire out;

    // Instantiate the AND gate
    and_gate uut (
        .a(a),
        .b(b),
        .out(out)
    );

    initial begin
        // Test all combinations of a and b
        a = 0; b = 0; #10; // out should be 0
        a = 0; b = 1; #10; // out should be 0
        a = 1; b = 0; #10; // out should be 0
        a = 1; b = 1; #10; // out should be 1

        // End simulation
        $finish;
    end
endmodule