
module TopModule (
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] s,
    output reg overflow
);

reg [8:0] sum;

always @(*) begin
    sum = a + b;
    if (sum[8] != sum[7]) begin
        overflow = 1;
    end else begin
        overflow = 0;
    end
end

assign s = sum[7:0];

endmodule