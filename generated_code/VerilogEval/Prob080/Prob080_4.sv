
module TopModule (
    input wire clk,
    input wire load,
    input wire [9:0] data,
    output reg tc
);

    reg [9:0] counter; // 10-bit internal counter

    // Sequential logic for counter
    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the new value into the counter
            tc <= 1'b0;      // Reset the terminal count when loaded
        end else if (counter > 0) begin
            counter <= counter - 1; // Decrement the counter
            tc <= 1'b0;              // Maintain tc as low while counting down
        end

        // Assert terminal count when counter reaches 0
        if (counter == 1) begin
            tc <= 1'b1; // Assert terminal count when about to reach zero
        end else if (counter == 0) begin
            tc <= 1'b1; // Assert terminal count when counter reaches zero
        end
    end

endmodule