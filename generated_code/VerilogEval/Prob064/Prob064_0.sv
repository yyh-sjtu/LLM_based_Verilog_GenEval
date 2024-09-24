
module TopModule (
    input [4:0] a,   // 5-bit input a
    input [4:0] b,   // 5-bit input b
    input [4:0] c,   // 5-bit input c
    input [4:0] d,   // 5-bit input d
    input [4:0] e,   // 5-bit input e
    input [4:0] f,   // 5-bit input f
    output [7:0] w,  // 8-bit output w
    output [7:0] x,  // 8-bit output x
    output [7:0] y,  // 8-bit output y
    output [7:0] z   // 8-bit output z
);

    // Concatenating the inputs together
    wire [29:0] concat_inputs;
    assign concat_inputs = {a, b, c, d, e, f}; // 30 bits from inputs a-f
    
    // Final 32-bit concatenation with two 1s
    wire [31:0] extended_outputs;
    assign extended_outputs = {concat_inputs, 2'b11}; // Append '11' to the LSB

    // Assigning the concatenated output to the respective outputs
    assign w = extended_outputs[31:24]; // 8-bit segment for w
    assign x = extended_outputs[23:16]; // 8-bit segment for x
    assign y = extended_outputs[15:8];  // 8-bit segment for y
    assign z = extended_outputs[7:0];   // 8-bit segment for z

endmodule