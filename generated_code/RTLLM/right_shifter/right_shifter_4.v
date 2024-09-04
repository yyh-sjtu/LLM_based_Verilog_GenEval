
module right_shifter (
    input wire clk,
    input wire d,
    output reg [7:0] q
);

    initial begin
        q <= 8'b0;
    end

    always @(posedge clk) begin
        q <= {q[6:0], d};
    end

endmodule