module that implements a 16-bit full adder in Verilog

module full_adder(
    input [15:0] a,
    input [15:0] b,
    input cin,
    output [15:0] sum,
    output cout
);

wire [15:0] carry_in;
wire [15:0] carry_out;

// Generate internal signals for each bit
genvar i;
generate
    for (i = 0; i < 16; i = i + 1) begin : gen
        assign carry_in[i] = (i == 0) ? cin : carry_out[i-1];
        assign {cout, sum[i]} = a[i] + b[i] + carry_in[i];
        assign carry_out[i] = (a[i] & b[i]) | (a[i] & carry_in[i]) | (b[i] & carry_in[i]);
    end
endgenerate

endmodule

module
module test_full_adder;

    reg [15:0] a;
    reg [15:0] b;
    reg cin;
    wire [15:0] sum;
    wire cout;

    full_adder FA(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Test case
    initial begin
        a = 16'b11001100;
        b = 16'b10101010;
        cin = 1;
        #10;
        $display("Sum: %b", sum);
        $display("Carry Out: %b", cout);
    end

endmodule
