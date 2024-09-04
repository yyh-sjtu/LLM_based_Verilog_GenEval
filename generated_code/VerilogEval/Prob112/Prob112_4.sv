module named `TopModule`. The module takes a 4-bit input and produces a 2-bit output representing the position of the highest priority input bit (the first high bit). If none of the input bits are high, the output will be zero.

Here is the implementation:

```systemverilog
module TopModule (
    input logic [3:0] in, // 4-bit input
    output logic [1:0] pos // 2-bit output
);

    always_comb begin
        // Default output if no bits are high
        pos = 2'b00;

        // Check the input bits starting from the highest priority
        if (in[3]) begin
            pos = 2'b11; // Bit 3 is first (highest)
        end else if (in[2]) begin
            pos = 2'b10; // Bit 2 is first
        end else if (in[1]) begin
            pos = 2'b01; // Bit 1 is first
        end else if (in[0]) begin
            pos = 2'b00; // Bit 0 is first
        end
        // If all bits are low, pos remains 2'b00 (no action needed)
    end

endmodule

