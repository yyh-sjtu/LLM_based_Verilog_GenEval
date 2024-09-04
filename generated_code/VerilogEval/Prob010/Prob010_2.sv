
module TopModule (
    input wire x,
    input wire y,
    output wire z
);

// Internal signal to hold the XOR result
wire xor_result;

// Calculate the XOR of x and y
assign xor_result = x ^ y;

// Calculate the AND of xor_result and x to get z
assign z = xor_result & x;

endmodule