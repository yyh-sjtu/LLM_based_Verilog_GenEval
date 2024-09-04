
module TopModule (
    input  [254:0] in,  // 255-bit input
    output [7:0] out     // 8-bit output
);

    // Internal signal to hold the population count
    reg [7:0] count;

    // Always block to calculate population count on input change
    always @(*) begin
        // Initialize count to 0
        count = 0;

        // Count the number of '1's in the input vector
        integer i;
        for (i = 0; i < 255; i = i + 1) begin
            count = count + in[i];
        end
    end

    // Assign the calculated count to the output
    assign out = count;

endmodule