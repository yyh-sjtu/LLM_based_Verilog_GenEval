
module TopModule (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    if (a == 1'b1) begin
        q <= 1'b1;
    end else begin
        q <= 1'b0;
    end
end

endmodule