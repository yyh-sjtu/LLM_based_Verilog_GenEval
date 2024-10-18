
module TopModule(
    input [7:0] in,
    output parity
);
    
    wire [7:0] xor_result;
    
    // XOR all the input bits
    assign xor_result = ^in;
    
    // Calculate parity bit
    assign parity = ^xor_result;
    
endmodule