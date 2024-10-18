
module counter_12 (
    input rst_n,
    input clk,
    input valid_count,
    output reg [3:0] out
);

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        out <= 4'b0000; // Reset the counter to 0
    end else if (valid_count && (out != 4'd11)) begin
        out <= out + 1; // Increment the counter if valid_count is active and not at maximum value
    end else begin
        out <= out; // Remain unchanged if valid_count is inactive or at maximum value
    end
end

endmodule