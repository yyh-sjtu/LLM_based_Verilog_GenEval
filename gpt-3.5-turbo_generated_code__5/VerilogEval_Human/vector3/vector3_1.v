module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

    // Concatenate the input vectors
    wire [29:0] input_concatenated;
    assign input_concatenated = {a, b, c, d, e, f};
    
    // Create the output vectors
    wire [7:0] output_w;
    wire [7:0] output_x;
    wire [7:0] output_y;
    wire [7:0] output_z;
    
    // Split the input_concatenated vector into output vectors
    assign {output_z, output_y, output_x, output_w} = {input_concatenated, 2'b11};

    // Assign the output vectors to the module outputs
    assign w = output_w;
    assign x = output_x;
    assign y = output_y;
    assign z = output_z;

endmodule

