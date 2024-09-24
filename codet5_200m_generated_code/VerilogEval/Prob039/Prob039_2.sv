module TopModule (
	input a,
	input b,
	input sel_b1,
	input sel_b2,
	output out_assign,
	output out_always
);
    parameter ID = 0;
    parameter HEN = 0;
    parameter LEN = 0;
    parameter DW = 0;
    parameter VPWR = 1;
    parameter VGND = 1;
    parameter VPB = 1;
    parameter VNB = 1;
    wire sel_b1_out;
    assign sel_b1_out = sel_b1;
    assign sel_b1_out = (sel_b2 == 2'b01)? sel_b1 : (sel_b1 == 2'b10)? sel_b1 : sel_b1;
    assign sel_b1_out = (sel_b2 == 2'b01)? sel_b2 : sel_b2;
    assign out_always_out = sel_b1_out;
endmodule

