module full_adder(
    input a,
    input b,
    input cin,
    output sum,
    output cout
    );

    assign {cout, sum} = a + b + cin;

endmodule

module

module testbench;
    reg a, b, cin;
    wire sum, cout;

    full_adder dut(
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        a = 1;
        b = 1;
        cin = 0;
        
        #10;
        
        $display("a = %b, b = %b, cin = %b, sum = %b, cout = %b", a, b, cin, sum, cout);
        
        a = 0;
        b = 1;
        cin = 1;
        
        #10;
        
        $display("a = %b, b = %b, cin = %b, sum = %b, cout = %b", a, b, cin, sum, cout);
        
        // Continue testing with different values of a, b, and cin
        
    end
endmodule
