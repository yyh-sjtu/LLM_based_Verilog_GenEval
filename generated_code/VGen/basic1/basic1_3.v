module full_adder (
    input wire A,        // input A
    input wire B,        // input B
    input wire Cin,      // input carry-in
    output wire Sum,     // output sum
    output wire Cout     // output carry-out
);

assign {Cout, Sum} = A + B + Cin;

endmodule

module
module test_bench;
    reg A, B, Cin;
    wire Sum, Cout;

    full_adder dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $display("Testing Full Adder");

        // Test case 1
        A = 4'b0010;
        B = 4'b1100;
        Cin = 1'b0;
        #10 $display("Sum = %b, Cout = %b", Sum, Cout);

        // Test case 2
        A = 4'b1111;
        B = 4'b0001;
        Cin = 1'b1;
        #10 $display("Sum = %b, Cout = %b", Sum, Cout);

        // Add more test cases as needed

        $stop;
    end
endmodule

