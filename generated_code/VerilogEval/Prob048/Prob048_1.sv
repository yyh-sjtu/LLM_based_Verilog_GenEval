
module TopModule (
    input clk,
    input d,
    input r,
    output reg q
);

always @(posedge clk or posedge r) begin
    if (r) begin
        q <= 1'b0; // reset output to 0
    end else begin
        q <= d; // update output with input d on clock edge
    end
end

endmodule