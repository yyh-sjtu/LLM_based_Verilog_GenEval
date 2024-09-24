module TopModule (
	input c,
	input d,
	output [3:0] mux_in
);
    wire [1:0] a;
    wire [1:0] b;
    wire [1:0] c;
    wire [1:0] c2;
    wire [1:0] b2;
    wire [1:0] b3;
    assign c = {a,b,c2,c1,c0};
    assign b = {a,b,b1,c0};
    assign a = {a,b,c2,c1,c0};
    assign b = {b,b1,c2,c1};
    assign a2 = {a,b,c3,c1,c0};
    assign b2 = {b,b,c2,c1};
    assign b3 = {b,b,c3,c0};
    assign mux_in = a2;
endmodule

