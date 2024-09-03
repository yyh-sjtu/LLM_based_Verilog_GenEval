
module full_adder_16bit (
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
);

genvar i;
generate
for (i = 0; i < 16; i=i+1) begin: adder_bit
    assign {cout, sum[i]} = a[i] + b[i] + cin;
end
endgenerate

endmodule
module decade_counter (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

always @ (posedge clk) begin
    if (reset) begin
        q <= 4'b0000;
    end else begin
        if (slowena) begin
            if (q == 4'b1001) begin
                q <= 4'b0000;
            end else begin
                q <= q + 1;
            end
        end
    end
end

endmodule