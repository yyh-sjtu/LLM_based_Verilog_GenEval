
module left_rotate (
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Clear output on reset
        out <= 8'b0;
    end else if (load) begin
        // Perform left rotate operation
        // Amount must be modded by 8 since we are rotating an 8-bit value
        case (amount % 8)
            3'b000: out <= data; // No rotation
            3'b001: out <= {data[6:0], data[7]}; // Rotate left by 1
            3'b010: out <= {data[5:0], data[7:6]}; // Rotate left by 2
            3'b011: out <= {data[4:0], data[7:5]}; // Rotate left by 3
            3'b100: out <= {data[3:0], data[7:4]}; // Rotate left by 4
            3'b101: out <= {data[2:0], data[7:5]}; // Rotate left by 5
            3'b110: out <= {data[1:0], data[7:6]}; // Rotate left by 6
            3'b111: out <= {data[0], data[7:1]}; // Rotate left by 7
            default: out <= data; // Default case (although not expected)
        endcase
    end
end

endmodule