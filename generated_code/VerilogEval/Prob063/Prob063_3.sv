
module TopModule (
    input  clk,
    input  shift_ena,
    input  count_ena,
    input  data,
    output reg [3:0] q
);

    always @(posedge clk) begin
        if (shift_ena) begin
            // Shift in data (most-significant-bit first)
            q <= {data, q[3:1]};
        end else if (count_ena) begin
            // Decrement the value in the register
            if (q != 4'b0000) begin
                q <= q - 1;
            end
        end
    end

endmodule