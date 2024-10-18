
module TopModule (
    input [3:0] x,
    input [3:0] y,
    output [4:0] sum
);

wire [3:0] carry;
wire [3:0] sum_intermediate;

// Full adders for each bit
FullAdder fa0 (.a(x[0]), .b(y[0]), .cin(1'b0), .sum(sum_intermediate[0]), .cout(carry[0]));
FullAdder fa1 (.a(x[1]), .b(y[1]), .cin(carry[0]), .sum(sum_intermediate[1]), .cout(carry[1]));
FullAdder fa2 (.a(x[2]), .b(y[2]), .cin(carry[1]), .sum(sum_intermediate[2]), .cout(carry[2]));
FullAdder fa3 (.a(x[3]), .b(y[3]), .cin(carry[2]), .sum(sum_intermediate[3]), .cout(carry[3]));

// Overflow bit
assign sum[4] = carry[3];

// Final sum
assign sum = {sum_intermediate, sum[4]};

endmodule