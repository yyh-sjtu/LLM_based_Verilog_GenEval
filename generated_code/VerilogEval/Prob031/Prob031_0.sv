
module TopModule (
    input clk,  // Clock input
    input d,    // Data input
    output reg q // Output
);

    // On the rising edge of the clock, assign the value of d to q
    always @(posedge clk) begin
        q <= d;
    end

endmodule