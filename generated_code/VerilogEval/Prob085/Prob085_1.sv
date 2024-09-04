
module TopModule (
    input  wire clk,
    input  wire areset,
    input  wire load,
    input  wire ena,
    input  wire [3:0] data,
    output reg  [3:0] q
);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            q <= 4'b0000;
        end else if (load) begin
            // Load data into the shift register
            q <= data;
        end else if (ena) begin
            // Shift right logic
            q <= {1'b0, q[3:1]};
        end
        // If neither load nor ena are asserted, q retains its value
    end

endmodule