
module TopModule (
    input  clk,
    input  shift_ena,
    input  count_ena,
    input  data,
    output reg [3:0] q
);
    
    // Initialize q to zero
    initial begin
        q = 4'b0000;
    end

    always @(posedge clk) begin
        if (shift_ena) begin
            // Shift in the new data MSB first
            q <= {data, q[3:1]};
        end else if (count_ena) begin
            // Down count
            q <= q - 1'b1;
        end
        // If both are enabled, behavior is unspecified
    end
endmodule