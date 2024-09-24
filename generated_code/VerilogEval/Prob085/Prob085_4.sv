
module TopModule (
    input  wire clk,
    input  wire areset,
    input  wire load,
    input  wire ena,
    input  wire [3:0] data,
    output reg  [3:0] q
);

    // Always block for asynchronous reset and synchronous operations
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset: Set q to 0
            q <= 4'b0000;
        end else if (load) begin
            // Load operation: Load data into q
            q <= data;
        end else if (ena) begin
            // Shift right operation: Shift q to the right
            q <= {1'b0, q[3:1]};
        end
        // If none of the conditions are met (default case), keep the current value
    end

endmodule