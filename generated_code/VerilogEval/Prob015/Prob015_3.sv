
// Define the module
module TopModule (
    input  [15:0] in,   // 16-bit input
    output [7:0] out_hi, // 8 bits upper half
    output [7:0] out_lo  // 8 bits lower half
);

    // Assigning the upper and lower bytes from the 16-bit input
    assign out_hi = in[15:8]; // Upper byte (bits 15 to 8)
    assign out_lo = in[7:0];  // Lower byte (bits 7 to 0)

endmodule
module tb_TopModule;

    reg [15:0] in; // Test input
    wire [7:0] out_hi; // Output for upper byte
    wire [7:0] out_lo; // Output for lower byte

    // Instantiate the TopModule
    TopModule uut (
        .in(in),
        .out_hi(out_hi),
        .out_lo(out_lo)
    );

    initial begin
        // Test various inputs
        in = 16'hA5A5; // Example input
        #10; // Wait for 10 time units
        $display("Input: %h, out_hi: %h, out_lo: %h", in, out_hi, out_lo);
        
        in = 16'h1234;
        #10;
        $display("Input: %h, out_hi: %h, out_lo: %h", in, out_hi, out_lo);
        
        in = 16'hFFFF;
        #10;
        $display("Input: %h, out_hi: %h, out_lo: %h", in, out_hi, out_lo);
        
        in = 16'h0000;
        #10;
        $display("Input: %h, out_hi: %h, out_lo: %h", in, out_hi, out_lo);

        // End simulation
        $finish;
    end

endmodule