module
// Inputs: x3, x2, x1
// Output: f
module truth_table (
    input x3,
    input x2,
    input x1,
    output reg f
);

// Define the truth table conditions and assign values to output f
// The output f will be assigned based on the conditions provided
always @(*) begin
    case({x3, x2, x1})
        3'b000: f = 1;
        3'b001: f = 1;
        3'b010: f = 0;
        3'b011: f = 1;
        3'b100: f = 0;
        3'b101: f = 0;
        3'b110: f = 1;
        3'b111: f = 0;
        default: f = 0; // Default case if no match is found
    endcase
end

endmodule

