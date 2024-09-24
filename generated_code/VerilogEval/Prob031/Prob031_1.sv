
module TopModule (
    input clk,  // Clock input
    input d,    // Data input
    output reg q // Output
);

// Always block that triggers on the positive edge of the clock
always @(posedge clk) begin
    q <= d; // Assigning the data input to the output on the rising edge of the clock
end

endmodule
module TopModule_tb;

reg clk; 
reg d;
wire q;

// Instantiate the TopModule
TopModule uut (
    .clk(clk),
    .d(d),
    .q(q)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // Toggle clock every 5 time units
end

// Test sequence
initial begin
    // Initialize inputs
    d = 0;

    // Wait for the clock to stabilize
    #15;

    // Test cases
    d = 1; #10; // Wait for next clock edge
    $display("q = %b (should be 1)", q); // Expected output: 1

    d = 0; #10; // Wait for next clock edge
    $display("q = %b (should be 0)", q); // Expected output: 0

    d = 1; #10; // Wait for next clock edge
    $display("q = %b (should be 1)", q); // Expected output: 1

    // Finish the simulation
    $finish;
end

endmodule