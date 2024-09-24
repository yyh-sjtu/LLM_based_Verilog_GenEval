
module TopModule (
    input wire x,    // One-bit input x
    input wire y,    // One-bit input y
    output wire z    // One-bit output z
);

// Internal wire for the XOR result
wire xor_result;

// Perform the XOR operation between x and y
assign xor_result = x ^ y;

// Perform the AND operation with x
assign z = xor_result & x;

endmodule
module Testbench;

    reg x;
    reg y;
    wire z;

    // Instantiate the TopModule
    TopModule uut (
        .x(x),
        .y(y),
        .z(z)
    );

    initial begin
        // Test all combinations of x and y
        x = 0; y = 0; #10;
        $display("x=%b, y=%b, z=%b", x, y, z); // Expected: z=0

        x = 0; y = 1; #10;
        $display("x=%b, y=%b, z=%b", x, y, z); // Expected: z=0

        x = 1; y = 0; #10;
        $display("x=%b, y=%b, z=%b", x, y, z); // Expected: z=1

        x = 1; y = 1; #10;
        $display("x=%b, y=%b, z=%b", x, y, z); // Expected: z=0

        // Finish simulation
        $finish;
    end

endmodule