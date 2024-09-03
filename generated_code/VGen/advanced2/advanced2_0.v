module full_adder(
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

assign {cout, sum} = a + b + cin;

endmodule

module decade_counter(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

reg [3:0] q_next;

always @(*) begin
    if (reset) begin
        q_next = 4'b0000;
    end else begin
        if (slowena) begin
            q_next = q + 1;
        end else begin
            q_next = q;
        end
    end
end

always @(posedge clk) begin
    q <= q_next;
end

endmodule

module full_adder_16bit(
    input wire [15:0] a,
    input wire [15:0] b,
    input wire cin,
    output wire [15:0] sum,
    output wire cout
);

wire [3:0] co;
wire [15:0] s1, s2, s3;

full_adder fa0(a[0], b[0], cin, s1[0], co[0]);
full_adder fa1(a[1], b[1], co[0], s1[1], co[1]);
full_adder fa2(a[2], b[2], co[1], s1[2], co[2]);
full_adder fa3(a[3], b[3], co[2], s1[3], co[3]);

full_adder fa4(a[4], b[4], cin, s2[0], co[4]);
full_adder fa5(a[5], b[5], co[4], s2[1], co[5]);
full_adder fa6(a[6], b[6], co[5], s2[2], co[6]);
full_adder fa7(a[7], b[7], co[6], s2[3], co[7]);

full_adder fa8(a[8], b[8], cin, s3[0], co[8]);
full_adder fa9(a[9], b[9], co[8], s3[1], co[9]);
full_adder fa10(a[10], b[10], co[9], s3[2], co[10]);
full_adder fa11(a[11], b[11], co[10], s3[3], co[11]);

full_adder fa12(a[12], b[12], cin, sum[0], co[12]);
full_adder fa13(a[13], b[13], co[12], sum[1], co[13]);
full_adder fa14(a[14], b[14], co[13], sum[2], co[14]);
full_adder fa15(a[15], b[15], co[14], sum[3], co[15]);

assign cout = co[15];

endmodule

