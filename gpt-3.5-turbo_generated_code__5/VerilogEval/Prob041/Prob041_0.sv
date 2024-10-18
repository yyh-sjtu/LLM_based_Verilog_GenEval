
module TopModule (
    input clk,
    input reset,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] d_ff [7:0];
integer i;

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 8'b0;
    else begin
        for (i = 0; i < 8; i = i + 1)
            d_ff[i] <= d[i];
        q <= {d_ff[0], d_ff[1], d_ff[2], d_ff[3], d_ff[4], d_ff[5], d_ff[6], d_ff[7]};
    end
end

endmodule