
module TopModule (
    input  [2:0] in,  // 3-bit input
    output [1:0] out  // 2-bit output
);

// Internal signal to hold the population count
reg [1:0] count;

always @(*) begin
    count = 2'b00; // Initialize to 0
    if (in[0] == 1'b1) count = count + 2'b01; // Check the first bit
    if (in[1] == 1'b1) count = count + 2'b01; // Check the second bit
    if (in[2] == 1'b1) count = count + 2'b01; // Check the third bit
end

assign out = count; // Assign the result to output

endmodule