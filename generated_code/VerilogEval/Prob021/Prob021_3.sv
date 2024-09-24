
module TopModule (
    input  [1023:0] in,  // 1024 bits input
    input  [7:0]   sel,  // 8 bits select signal
    output [3:0]   out   // 4 bits output
);

    // Calculate the starting index of the selected 4-bit segment
    // Each selection corresponds to 4 bits, so we need to multiply sel by 4.
    wire [9:0] index = sel * 4;

    // Use the calculated index to select the output from the input vector
    assign out = in[index +: 4];  // Select 4 bits starting from calculated index

endmodule