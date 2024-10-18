
module counter_12 (
    input rst_n,
    input clk,
    input valid_count,
    output reg [3:0] out
);

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)             // Reset condition
            out <= 4'b0000;
        else if (valid_count)   // Count only when valid_count is active
        begin
            if (out == 4'd11)   // Wrap around to 0 when maximum value is reached
                out <= 4'b0000;
            else
                out <= out + 1; // Increment the count value
        end
    end

endmodule