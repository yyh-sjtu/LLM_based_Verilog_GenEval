
module TopModule (
    input  [7:0] a,
    input  [7:0] b,
    input  [7:0] c,
    input  [7:0] d,
    output [7:0] min
);

    // Intermediate variable to hold minimum value
    reg [7:0] min_reg;

    always @(*) begin
        // Initial assumption
        min_reg = a;

        // Compare with b
        if (b < min_reg) min_reg = b;
        
        // Compare with c
        if (c < min_reg) min_reg = c;
        
        // Compare with d
        if (d < min_reg) min_reg = d;
    end

    // Assign the minimum value to the output
    assign min = min_reg;

endmodule