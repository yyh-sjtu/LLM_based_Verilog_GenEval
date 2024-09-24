
module TopModule (
    input       clk,
    input       load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q
);

    always @(posedge clk) begin
        if (load) begin
            // Load data into the register
            q <= data;
        end else begin
            case (ena)
                2'b01: begin
                    // Rotate right by 1 bit
                    q <= {q[0], q[99:1]}; // Shift right and wrap around the bit
                end
                2'b10: begin
                    // Rotate left by 1 bit
                    q <= {q[98:0], q[99]}; // Shift left and wrap around the bit
                end
                default: begin
                    // 2'b00: Do not rotate
                    // 2'b11: Do not rotate
                    q <= q; // Retain current value
                end
            endcase
        end
    end

endmodule