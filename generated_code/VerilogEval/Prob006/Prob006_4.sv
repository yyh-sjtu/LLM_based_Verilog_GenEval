
module TopModule (
    input  [7:0] in,   // 8-bit input
    output [7:0] out   // 8-bit output
);

    // Assign the reversed bits to the output
    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};

endmodule
module testbench;

    reg  [7:0] in;   // Test input
    wire [7:0] out;  // Test output

    // Instantiate the TopModule
    TopModule uut (
        .in(in),
        .out(out)
    );

    initial begin
        // Test different values
        in = 8'b00000000; #10;
        in = 8'b11011010; #10;
        in = 8'b10101010; #10;
        in = 8'b11111111; #10;
        in = 8'b00001111; #10;

        // Finish simulation
        $finish;
    end

    // Monitor the inputs and outputs
    initial begin
        $monitor("Time: %0t | Input: %b | Output: %b", $time, in, out);
    end
endmodule