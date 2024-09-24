
module TopModule (
    input wire x,       // 1-bit input x
    input wire y,       // 1-bit input y
    output wire z       // 1-bit output z
);

    // Implementing the function z = (x ^ y) & x
    assign z = (x ^ y) & x;

endmodule
module TopModule_tb;

    reg x;               // Test input x
    reg y;               // Test input y
    wire z;             // Test output z

    // Instantiate the TopModule
    TopModule uut (
        .x(x),
        .y(y),
        .z(z)
    );

    initial begin
        // Test all combinations of x and y
        $monitor("x = %b, y = %b, z = %b", x, y, z);
        
        x = 0; y = 0; #10;
        x = 0; y = 1; #10;
        x = 1; y = 0; #10;
        x = 1; y = 1; #10;

        $finish;  // End the simulation
    end

endmodule