
module TopModule (
    input       clk,
    input       reset,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] d_ff;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        d_ff <= 8'b0;
    end else begin
        d_ff <= d;
    end
end

assign q = d_ff;

endmodule