
module TopModule (
    input clk,
    input d,
    output reg q
);

    // On the positive edge of the clock, assign d to q
    always @(posedge clk) begin
        q <= d;
    end

endmodule