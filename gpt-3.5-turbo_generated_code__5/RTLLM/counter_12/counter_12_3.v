
module counter_12 (
    input wire rst_n,
    input wire clk,
    input wire valid_count,
    output reg [3:0] out
);

    always @(posedge clk) begin
        if (!rst_n) begin
            out <= 4'b0000; // Reset counter to 0
        end else if (valid_count) begin
            if (out == 4'd11) begin
                out <= 4'b0000; // Wrap around and reset counter
            end else begin
                out <= out + 1; // Increment counter
            end
        end
    end

endmodule