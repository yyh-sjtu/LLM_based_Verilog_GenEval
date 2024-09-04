
module TopModule (
    input       clk,      // Clock input
    input       areset,   // Asynchronous reset
    input       load,     // Load control
    input       ena,      // Enable control
    input [3:0] data,     // 4-bit input data
    output reg [3:0] q     // 4-bit output (shift register contents)
);

// Asynchronous reset
always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Reset q to zero
        q <= 4'b0000;
    end else begin
        // If load is asserted, load the data
        if (load) begin
            q <= data;
        end
        // If enable is asserted and load is not asserted, perform right shift
        else if (ena) begin
            q <= {1'b0, q[3:1]}; // Right shift: MSB (q[3]) moves out, LSB (q[0]) becomes 0
        end
    end
end

endmodule