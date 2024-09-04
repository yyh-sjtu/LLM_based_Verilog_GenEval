
module TopModule (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output reg [7:0] w,
    output reg [7:0] x,
    output reg [7:0] y,
    output reg [7:0] z
);

    // Intermediate wire for the concatenated input
    wire [29:0] concatenated_inputs;

    // Concatenate the inputs and add two '1' bits at the end
    assign concatenated_inputs = {a, b, c, d, e, f};

    // Assign the outputs from the concatenated input
    always @* begin
        w = {concatenated_inputs[29:22], 2'b11}; // First 8 bits + two '1's
        x = {concatenated_inputs[21:14], 2'b11}; // Next 8 bits + two '1's
        y = {concatenated_inputs[13:6], 2'b11};  // Next 8 bits + two '1's
        z = {concatenated_inputs[5:0], 2'b11};    // Last 8 bits + two '1's
    end

endmodule