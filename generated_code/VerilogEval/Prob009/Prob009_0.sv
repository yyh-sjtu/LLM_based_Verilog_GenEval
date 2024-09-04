
module TopModule (
    input  [2:0] in,  // 3-bit input
    output [1:0] out  // 2-bit output
);

    // Intermediate signal to hold population count
    wire [1:0] count;

    // Implementing the population count logic
    assign count = 
        (in[0] + in[1] + in[2]); // Count of 1's in the input
    
    assign out = count;

endmodule