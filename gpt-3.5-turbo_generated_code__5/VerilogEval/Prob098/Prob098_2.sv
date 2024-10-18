
module TopModule(
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    if (a) begin
        q <= 1'b0;
    end else begin
        q <= a;
    end
end

endmodule