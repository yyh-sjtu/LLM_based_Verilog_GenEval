
module TopModule (
    input clk,
    input load,
    input [9:0] data,
    output reg tc
);

    reg [9:0] counter; // Internal 10-bit counter

    always @(posedge clk) begin
        if (load) begin
            // Load the counter with the specified data when load is high
            counter <= data;
            tc <= 1'b0; // Reset terminal count when loading new value
        end else begin
            // Decrement the counter if load is low
            if (counter > 0) begin
                counter <= counter - 1;
            end
            // Assert tc signal if the counter reaches 0
            if (counter == 1) begin
                tc <= 1'b1; // Terminal count asserted when reaching 0
            end else begin
                tc <= 1'b0; // Terminal count not asserted otherwise
            end
        end
    end

endmodule