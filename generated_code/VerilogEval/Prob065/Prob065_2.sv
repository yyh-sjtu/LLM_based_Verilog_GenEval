
module TopModule (
    input  wire p1a,
    input  wire p1b,
    input  wire p1c,
    input  wire p1d,
    input  wire p2a,
    input  wire p2b,
    input  wire p2c,
    input  wire p2d,
    output wire p1y,
    output wire p2y
);

// Implement the first 4-input NAND gate
assign p1y = ~(p1a & p1b & p1c & p1d);

// Implement the second 4-input NAND gate
assign p2y = ~(p2a & p2b & p2c & p2d);

endmodule
module Testbench;

    reg p1a, p1b, p1c, p1d;
    reg p2a, p2b, p2c, p2d;
    wire p1y, p2y;

    // Instantiate the TopModule
    TopModule uut (
        .p1a(p1a),
        .p1b(p1b),
        .p1c(p1c),
        .p1d(p1d),
        .p2a(p2a),
        .p2b(p2b),
        .p2c(p2c),
        .p2d(p2d),
        .p1y(p1y),
        .p2y(p2y)
    );

    initial begin
        // Apply test vectors
        {p1a, p1b, p1c, p1d} = 4'b0000; // Expected p1y = 1
        {p2a, p2b, p2c, p2d} = 4'b0000; // Expected p2y = 1
        #10;

        {p1a, p1b, p1c, p1d} = 4'b1111; // Expected p1y = 0
        {p2a, p2b, p2c, p2d} = 4'b1111; // Expected p2y = 0
        #10;

        // More test cases can be added here...

        $finish; // End simulation
    end

endmodule