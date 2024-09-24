
module TopModule (
    input  clk,
    input  resetn,
    input  in,
    output out
);

    // 4-bit shift register declaration
    reg [3:0] shift_reg;

    // Synchronous process for the shift register
    always @(posedge clk) begin
        if (!resetn) begin
            // Reset the shift register to 0 when resetn is low
            shift_reg <= 4'b0000;
        end else begin
            // Shift left
            shift_reg <= {shift_reg[2:0], in};
        end
    end

    // Output the most significant bit of the shift register
    assign out = shift_reg[3];

endmodule
module TopModule_tb;

    reg clk;
    reg resetn;
    reg in;
    wire out;

    // Instantiate the TopModule
    TopModule uut (
        .clk(clk),
        .resetn(resetn),
        .in(in),
        .out(out)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        resetn = 0; // Start by asserting reset
        in = 0;

        // Release reset after some time
        #10 resetn = 1;

        // Simulate shifting of input values
        #10 in = 1; // Shift in 1
        #10 in = 0; // Shift in 0
        #10 in = 1; // Shift in 1
        #10 in = 1; // Shift in 1

        // Observe output
        #10;

        // Finish simulation
        $finish;
    end

    // Clock generation
    always #5 clk = ~clk; // Toggle clock every 5 time units

endmodule