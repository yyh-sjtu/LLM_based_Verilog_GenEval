
// This is a 2-to-1 multiplexer.
module mux( 
    input  [4:0] a,    // 5-bit input a
    input  [4:0] b,    // 5-bit input b
    input  sel,        // select signal
    output [4:0] out   // 5-bit output
);
    // Always block to implement the MUX functionality
    assign out = (sel == 1'b0) ? a : b; // Multiplexer logic
endmodule
`timescale 1ns / 1ps

module tb_mux;  // Testbench for the mux
    reg  [4:0] a;   // Input a
    reg  [4:0] b;   // Input b
    reg  sel;       // Select signal
    wire [4:0] out; // Output from the mux

    // Instantiate the mux
    mux uut (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Test case 1
        a = 5'b00001;  
        b = 5'b11111;  
        sel = 0;       // select a
        #10;
        $display("sel=%b, out=%b", sel, out); // Expected output: 00001

        // Test case 2
        sel = 1;       // select b
        #10;
        $display("sel=%b, out=%b", sel, out); // Expected output: 11111

        // End the simulation
        $finish;
    end
endmodule