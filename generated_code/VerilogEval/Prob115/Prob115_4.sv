
module TopModule (
    input  wire        clk,
    input  wire        load,
    input  wire        ena,
    input  wire [1:0] amount,
    input  wire [63:0] data,
    output reg  [63:0] q
);

    always @(posedge clk) begin
        if (load) begin
            // Load the data into the shift register
            q <= data;
        end else if (ena) begin
            // Shift operations based on amount
            case (amount)
                2'b00: q <= {q[62:0], 1'b0};         // Shift left by 1 bit
                2'b01: q <= {q[55:0], 8'b0};         // Shift left by 8 bits
                2'b10: q <= {q[63], q[63:1]};        // Shift right by 1 bit (arithmetic)
                2'b11: q <= {q[63], q[63:8]};        // Shift right by 8 bits (arithmetic)
                default: q <= q;                     // No operation
            endcase
        end
    end

endmodule