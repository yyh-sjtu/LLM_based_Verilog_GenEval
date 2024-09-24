
module TopModule(
    input wire in1,      // First input
    input wire in2,      // Second input
    input wire in3,      // Third input
    output wire out      // Output
);
    
    wire xnor_out;       // Intermediate wire to hold the output of XNOR

    // Two-input XNOR gate
    assign xnor_out = ~(in1 ^ in2);  // XNOR is the complement of XOR

    // Two-input XOR gate
    assign out = xnor_out ^ in3;      // XOR with the result of the XNOR and in3

endmodule
module testbench;
    reg in1;
    reg in2;
    reg in3;
    wire out;

    // Instantiate the TopModule
    TopModule uut (
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out(out)
    );

    initial begin
        // Test all combinations of inputs
        $monitor("in1=%b, in2=%b, in3=%b, out=%b", in1, in2, in3, out);
        
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