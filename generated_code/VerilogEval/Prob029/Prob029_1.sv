
module TopModule (
    input wire in1,   // First input
    input wire in2,   // Second input
    input wire in3,   // Third input
    output wire out   // Output
);

    // Intermediate wire to hold the output of the XNOR
    wire xnor_out;

    // Implement the XNOR gate
    assign xnor_out = ~(in1 ^ in2); // XNOR can be implemented as NOT(XOR)

    // Implement the XOR gate
    assign out = xnor_out ^ in3;    // XOR with the third input

endmodule
module tb_TopModule;

    reg in1, in2, in3; // Testbench inputs
    wire out;         // Testbench output

    // Instantiate the TopModule
    TopModule uut (
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out(out)
    );

    initial begin
        // Monitor signals
        $monitor("in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);

        // Test all combinations
        in1 = 0; in2 = 0; in3 = 0; #10;
        in1 = 0; in2 = 0; in3 = 1; #10;
        in1 = 0; in2 = 1; in3 = 0; #10;
        in1 = 0; in2 = 1; in3 = 1; #10;
        in1 = 1; in2 = 0; in3 = 0; #10;
        in1 = 1; in2 = 0; in3 = 1; #10;
        in1 = 1; in2 = 1; in3 = 0; #10;
        in1 = 1; in2 = 1; in3 = 1; #10;

        $finish; // End simulation
    end

endmodule