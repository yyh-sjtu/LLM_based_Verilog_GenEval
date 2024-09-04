
module TopModule (
    input wire a,       // First input bit
    input wire b,       // Second input bit
    input wire cin,     // Carry-in bit
    output wire cout,   // Carry-out bit
    output wire sum     // Sum bit
);

    // Logic for sum and carry-out
    assign sum = a ^ b ^ cin;          // Sum calculation: XOR of all inputs
    assign cout = (a & b) | (b & cin) | (a & cin); // Carry-out calculation

endmodule