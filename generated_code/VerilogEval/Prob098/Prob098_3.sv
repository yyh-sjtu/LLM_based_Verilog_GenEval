
module TopModule (
    input clk,
    input a,
    output reg q
);

always @(posedge clk or negedge a) begin
    if (!a) begin
        q <= 1'b0;
    end else begin
        q <= a;
    end
end

endmodule