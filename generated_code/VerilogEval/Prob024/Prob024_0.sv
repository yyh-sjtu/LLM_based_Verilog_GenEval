
module TopModule (
    input  wire a,      // First input bit
    input  wire b,      // Second input bit
    output wire sum,    // Sum output
    output wire cout    // Carry-out output
);

// The sum is the XOR of the two inputs
assign sum = a ^ b;

// The carry-out is the AND of the two inputs
assign cout = a & b;

endmodule