module adder_8bit (
	input [7:0] a,
	input [7:0] b,
	input cin,
	output [7:0] sum,
	output cout
);
    wire [7:0] a_1, b_1, cin_1;
    wire [7:0] sum_1, sum_2, sum_3, sum_4, sum_5, sum_6, sum_7;
    adder_8bit_1 add_1_0 (a_1, b_1, cin_1, sum_1, sum_2, sum_3, sum_4, sum_5, sum_6, sum_7);
    adder_8bit_1 add_2_0 (a_1, b_1, cin_1, sum_2, sum_3, sum_4, sum_5, sum_6, sum_7);
    adder_8bit_1 add_3_0 (a_1, b_1, cin_1, sum_3, sum_4, sum_5, sum_6, sum_7);
    assign sum = sum_1 + sum_2 + sum_3 + sum_4;
    assign cout = sum_1 & sum_2;
endmodule

