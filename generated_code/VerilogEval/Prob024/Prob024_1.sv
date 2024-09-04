
module TopModule (
    input wire a,       // First input bit
    input wire b,       // Second input bit
    output wire sum,    // Output sum
    output wire cout    // Output carry-out
);

// Logic for half adder
assign sum = a ^ b;   // Sum is the XOR of a and b
assign cout = a & b;  // Carry-out is the AND of a and b

endmodule
module tb_TopModule; // Testbench for TopModule
    reg a;           // Test input a
    reg b;           // Test input b
    wire sum;       // Wire to observe sum output
    wire cout;      // Wire to observe carry-out output

    // Instantiate the TopModule
    TopModule uut (
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        // Test cases
        $monitor("a=%b, b=%b -> sum=%b, cout=%b", a, b, sum, cout);
        
        // Test case 1
        a = 0; b = 0; #10;
        
        // Test case 2
        a = 0; b = 1; #10;
        
        // Test case 3
        a = 1; b = 0; #10;
        
        // Test case 4
        a = 1; b = 1; #10;

        // Finish simulation
        $finish;
    end
endmodule