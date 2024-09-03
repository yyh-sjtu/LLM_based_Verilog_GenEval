
module right_shifter (
    input wire clk,
    input wire d,
    output reg [7:0] q
);

    always @(posedge clk) begin
        q <= (q >> 1);
        q[7] <= d;
    end

    initial begin
        q <= 8'b0;
    end

endmodule