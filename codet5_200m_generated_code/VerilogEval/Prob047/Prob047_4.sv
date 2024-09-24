module TopModule (
	input clk,
	input areset,
	input [7:0] d,
	output [7:0] q
);
    wire [7:0] q_new;
    wire areset_sync;
    DFF_X4 U_DFF (
        .C(clk), 
        .D(d), 
        .Q(q_new) 
    );
    DFF_X4 U_DFF_Q (
        .C(clk), 
        .D(d_new), 
        .Q(q), 
        .A(areset_sync), 
        .CE(1'b1), 
        .CLR(1'b0), 
        .D(q_new) 
    );
    assign q = q_new;
endmodule

