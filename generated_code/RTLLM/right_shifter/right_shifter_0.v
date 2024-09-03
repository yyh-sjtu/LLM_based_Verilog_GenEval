module right_shifter (
    input clk,
    input d,
    output reg [7:0] q
);

    // Initialize q register to 0
    initial begin
        q <= 8'b0;
    end
    
    // Perform right shift operation on rising edge of clock
    always @ (posedge clk) begin
        q <= {q[6:0], d}; // Shift q to the right by 1 bit and insert d in the MSB
    end

endmodule

