
module TopModule (
    input  clk,
    input  areset,
    input  load,
    input  ena,
    input  [3:0] data,
    output reg [3:0] q
);

    // On the positive edge of the clock
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            q <= 4'b0000; // Reset the shift register to 0
        end else if (load) begin
            // Load data into the shift register
            q <= data; // Load the input data
        end else if (ena) begin
            // Shift right
            q <= {1'b0, q[3:1]}; // Shift right (MSB gets 0, LSB is lost)
        end
        // If neither load nor ena is active, q retains its value
    end

endmodule