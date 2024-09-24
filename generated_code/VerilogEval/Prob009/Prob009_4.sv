
module TopModule (
    input  [2:0] in,  // 3-bit input
    output [1:0] out  // 2-bit output
);

    // Internal signal to hold the population count
    wire [1:0] count;

    // Count the number of '1's in the input
    assign count[0] = in[0] ^ in[1] ^ in[2]; // XOR for LSB of population count
    assign count[1] = (in[0] & in[1]) | (in[0] & in[2]) | (in[1] & in[2]); // ANDs and ORs for MSB

    assign out = count;

endmodule