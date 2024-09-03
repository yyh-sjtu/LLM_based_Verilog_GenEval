
module counter_12 (
    input rst_n,
    input clk,
    input valid_count,
    output reg [3:0] out
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out <= 4'b0000; // Reset to 0
    end else begin
        if (valid_count) begin
            if (out == 4'd11) begin
                out <= 4'b0000; // Wrap around
            end else begin
                out <= out + 1; // Increment count
            end
        end
    end
end

endmodule