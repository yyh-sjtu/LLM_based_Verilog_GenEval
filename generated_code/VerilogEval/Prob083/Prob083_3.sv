
module TopModule (
    input wire x,
    input wire y,
    output reg z
);

// Combinational logic to determine z based on x and y inputs
always @(*) begin
    // Default state
    z = 0;

    case ({x, y})
        2'b00: z = 1; // When x=0, y=0 -> z=1 (0-20ns and 55-60ns)
        2'b01: z = 0; // When x=0, y=1 -> z=0 (35-40ns and 60-70ns)
        2'b10: z = 0; // When x=1, y=0 -> z=0 (25-30ns and 90ns)
        2'b11: z = 1; // When x=1, y=1 -> z=1 (45-50ns and 70-80ns)
    endcase
end

endmodule