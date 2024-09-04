
// This is a 2-to-1 multiplexer.
module mux( 
    input [4:0] a,      // First input
    input [4:0] b,      // Second input
    input sel,          // Select signal
    output [4:0] out    // Output
);

    // Assigning output based on select line
    assign out = sel ? b : a;

endmodule
module tb_mux;

    reg [4:0] a;          // Test input a
    reg [4:0] b;          // Test input b
    reg sel;              // Test select signal
    wire [4:0] out;       // Output wire

    // Instantiate the mux module
    mux uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Apply test cases
        a = 5'b10101; b = 5'b01010; sel = 0; // Expect out = a
        #10;
        if (out !== a) $display("Test failed when sel = 0, expected %b, got %b", a, out);
        else $display("Test passed when sel = 0, out = %b", out);

        sel = 1; // Change select to 1, expect out = b
        #10;
        if (out !== b) $display("Test failed when sel = 1, expected %b, got %b", b, out);
        else $display("Test passed when sel = 1, out = %b", out);

        // Include more test cases as needed
        #10;
        a = 5'b11111; b = 5'b00000; sel = 0; // Expect out = a
        #10;
        if (out !== a) $display("Test failed when sel = 0, expected %b, got %b", a, out);
        else $display("Test passed when sel = 0, out = %b", out);

        sel = 1; // Change select to 1, expect out = b
        #10;
        if (out !== b) $display("Test failed when sel = 1, expected %b, got %b", b, out);
        else $display("Test passed when sel = 1, out = %b", out);
        
        $finish; // End simulation
    end
endmodule