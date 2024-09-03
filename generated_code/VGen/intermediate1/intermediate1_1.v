module named half_adder
module half_adder( 
input a, b, // Inputs to the half adder module
output cout, sum ); // Outputs from the half adder module

// Define the internal wires for intermediate signals
wire and_result, xor_result;

// Implement the logic for the half adder
assign and_result = a & b; // Calculate the AND of inputs a and b
assign xor_result = a ^ b; // Calculate the XOR of inputs a and b
assign sum = xor_result; // Output the XOR result as the sum output
assign cout = and_result; // Output the AND result as the carry output

endmodule

