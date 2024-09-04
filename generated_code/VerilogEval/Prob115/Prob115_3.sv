
module TopModule (
    input  clk,
    input  load,
    input  ena,
    input  [1:0] amount,
    input  [63:0] data,
    output reg [63:0] q
);

always @(posedge clk) begin
    if (load) begin
        // Load data into the shift register
        q <= data;
    end else if (ena) begin
        // Perform shifting based on the value of amount
        case (amount)
            2'b00: q <= {q[62:0], 1'b0};                // Shift left by 1 bit
            2'b01: q <= {q[55:0], 8'b0};                 // Shift left by 8 bits
            2'b10: q <= {q[63], q[63:1]};                // Arithmetic shift right by 1 bit
            2'b11: q <= {q[63], q[63:8]};                // Arithmetic shift right by 8 bits
            default: q <= q;                             // No shift if amount is invalid
        endcase
    end
end

endmodule