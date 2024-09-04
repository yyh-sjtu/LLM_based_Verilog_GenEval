
module TopModule (
    input  [99:0] in,
    output       out_and,
    output       out_or,
    output       out_xor
);

// Internal combational logic
wire and_result;
wire or_result;
wire xor_result;

assign and_result = &in;           // Performs 100-input AND operation
assign or_result = |in;            // Performs 100-input OR operation
assign xor_result = ^in;           // Performs 100-input XOR operation

// Assign results to outputs
assign out_and = and_result;
assign out_or  = or_result;
assign out_xor = xor_result;

endmodule