module counter_12 (
    input rst_n,
    input clk,
    input valid_count,
    output reg [3:0] out
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out <= 4'b0000;
    end else begin
        if (valid_count) begin
            if (out == 4'd11) begin
                out <= 4'b0000;
            end else begin
                out <= out + 1;
            end
        end
    end
end

endmodule

