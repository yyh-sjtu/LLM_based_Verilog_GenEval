module
module full_adder(input wire a, b, cin, output wire sum, output wire cout);
assign {cout, sum} = a + b + cin;
endmodule

