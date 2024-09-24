
// Define the module TopModule with input and output ports
module TopModule (
    input wire a,        // first input bit
    input wire b,        // second input bit
    input wire cin,      // carry-in bit
    output wire cout,    // carry-out bit
    output wire sum      // sum output
);

    // Logic for the sum and cout
    assign sum = a ^ b ^ cin;         // Sum is the XOR of the inputs
    assign cout = (a & b) | (cin & (a ^ b)); // Carry-out logic

endmodule