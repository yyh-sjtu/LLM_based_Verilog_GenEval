
module and_gate(
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule

module xor_gate(
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule

module or_gate(
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule

module carry_lookahead_block(
    input a,
    input b,
    input c_in,
    output sum,
    output c_out
);
    wire p, g;
    
    assign p = a ^ b;
    assign g = a & b;
    
    assign sum = p ^ c_in;
    assign c_out = g | (p & c_in);
endmodule

module adder_32bit (
    input [31:0] A,
    input [31:0] B,
    output [31:0] S,
    output C32
);
    wire [15:0] co;
    wire [16:0] p, g;
    
    carry_lookahead_block CLB0(.a(A[0]), .b(B[0]), .c_in(1'b0), .sum(S[0]), .c_out(co[0]));
    carry_lookahead_block CLB1(.a(A[1]), .b(B[1]), .c_in(co[0]), .sum(S[1]), .c_out(co[1]));
    carry_lookahead_block CLB2(.a(A[2]), .b(B[2]), .c_in(co[1]), .sum(S[2]), .c_out(co[2]));
    carry_lookahead_block CLB3(.a(A[3]), .b(B[3]), .c_in(co[2]), .sum(S[3]), .c_out(co[3]));
    carry_lookahead_block CLB4(.a(A[4]), .b(B[4]), .c_in(co[3]), .sum(S[4]), .c_out(co[4]));
    carry_lookahead_block CLB5(.a(A[5]), .b(B[5]), .c_in(co[4]), .sum(S[5]), .c_out(co[5]));
    carry_lookahead_block CLB6(.a(A[6]), .b(B[6]), .c_in(co[5]), .sum(S[6]), .c_out(co[6]));
    carry_lookahead_block CLB7(.a(A[7]), .b(B[7]), .c_in(co[6]), .sum(S[7]), .c_out(co[7]));
    carry_lookahead_block CLB8(.a(A[8]), .b(B[8]), .c_in(co[7]), .sum(S[8]), .c_out(co[8]));
    carry_lookahead_block CLB9(.a(A[9]), .b(B[9]), .c_in(co[8]), .sum(S[9]), .c_out(co[9]));
    carry_lookahead_block CLB10(.a(A[10]), .b(B[10]), .c_in(co[9]), .sum(S[10]), .c_out(co[10]));
    carry_lookahead_block CLB11(.a(A[11]), .b(B[11]), .c_in(co[10]), .sum(S[11]), .c_out(co[11]));
    carry_lookahead_block CLB12(.a(A[12]), .b(B[12]), .c_in(co[11]), .sum(S[12]), .c_out(co[12]));
    carry_lookahead_block CLB13(.a(A[13]), .b(B[13]), .c_in(co[12]), .sum(S[13]), .c_out(co[13]));
    carry_lookahead_block CLB14(.a(A[14]), .b(B[14]), .c_in(co[13]), .sum(S[14]), .c_out(co[14]));
    carry_lookahead_block CLB15(.a(A[15]), .b(B[15]), .c_in(co[14]), .sum(S[15]), .c_out(co[15]));
    
    carry_lookahead_block CLB16(.a(S[0]), .b(S[1]), .c_in(co[15]), .sum(S[16]), .c_out(co[16]));
    carry_lookahead_block CLB17(.a(S[2]), .b(S[3]), .c_in(co[16]), .sum(S[17]), .c_out(co[17]));
    carry_lookahead_block CLB18(.a(S[4]), .b(S[5]), .c_in(co[17]), .sum(S[18]), .c_out(co[18]));
    carry_lookahead_block CLB19(.a(S[6]), .b(S[7]), .c_in(co[18]), .sum(S[19]), .c_out(co[19]));
    carry_lookahead_block CLB20(.a(S[8]), .b(S[9]), .c_in(co[19]), .sum(S[20]), .c_out(co[20]));
    carry_lookahead_block CLB21(.a(S[10]), .b(S[11]), .c_in(co[20]), .sum(S[21]), .c_out(co[21]));
    carry_lookahead_block CLB22(.a(S[12]), .b(S[13]), .c_in(co[21]), .sum(S[22]), .c_out(co[22]));
    carry_lookahead_block CLB23(.a(S[14]), .b(S[15]), .c_in(co[22]), .sum(S[23]), .c_out(co[23]));
    
    carry_lookahead_block CLB24(.a(S[16]), .b(S[17]), .c_in(co[23]), .sum(S[24]), .c_out(co[24]));
    carry_lookahead_block CLB25(.a(S[18]), .b(S[19]), .c_in(co[24]), .sum(S[25]), .c_out(co[25]));
    carry_lookahead_block CLB26(.a(S[20]), .b(S[21]), .c_in(co[25]), .sum(S[26]), .c_out(co[26]));
    carry_lookahead_block CLB27(.a(S[22]), .b(S[23]), .c_in(co[26]), .sum(S[27]), .c_out(co[27]));
    
    carry_lookahead_block CLB28(.a(S[24]), .b(S[25]), .c_in(co[27]), .sum(S[28]), .c_out(co[28]));
    carry_lookahead_block CLB29(.a(S[26]), .b(S[27]), .c_in(co[28]), .sum(S[29]), .c_out(co[29]));
    
    carry_lookahead_block CLB30(.a(S[28]), .b(S[29]), .c_in(co[29]), .sum(S[30]), .c_out(co[30]));
    
    carry_lookahead_block CLB31(.a(S[30]), .b(C32), .c_in(co[30]), .sum(S[31]), .c_out(C32));
    
    initial begin
        $dumpfile("adder_32bit.vcd");
        $dumpvars(0, adder_32bit);
    end

endmodule