module adder_8bit (
	input [7:0] a,
	input [7:0] b,
	input cin,
	output [7:0] sum,
	output cout
);
    wire [7:0] a_1, b_1;
    wire cin_1;
    wire [7:0] sum_1;
    wire cout_1;
    adder_8bit_1 add_1_0 (a_1, b_1, cin_1, sum_1);
    adder_8bit_1 add_1_1 (a_1, b_1, cin_1, sum_1);
    adder_8bit_1 add_1_2 (a_1, b_1, cin_1, sum_2);
    adder_8bit_1 add_1_3 (a_1, b_1, cin_1, sum_3);
    adder_8bit_1 add_1_4 (a_1, b_1, cin_1, sum_4);
    adder_8bit_1 add_1_5 (a_1, b_1, cin_1, sum_5);
    adder_8bit_1 add_1_6 (a_1, b_1, cin_1, sum_6);
    adder_8bit_1 add_1_7 (a_1, b_1, cin_1, sum_7);
    adder_8bit_1 add_1_8 (a_1, b_1, cin_1, sum_8);
    assign sum = sum_8;
    assign cout = cout_1;
endmodule

