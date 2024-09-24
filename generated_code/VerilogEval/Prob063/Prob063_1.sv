
module TopModule (
    input  wire clk,
    input  wire shift_ena,
    input  wire count_ena,
    input  wire data,
    output reg  [3:0] q
);

// Initial value for the register
initial begin
    q = 4'b0000;
end

always @(posedge clk) begin
    // Shift operation
    if (shift_ena) begin
        q <= {data, q[3:1]}; // Shift in data at the MSB and shift others to the right
    end
    // Count down operation
    else if (count_ena) begin
        if (q > 4'b0000) begin
            q <= q - 1; // Decrement unless it's already 0
        end
    end
end

endmodule