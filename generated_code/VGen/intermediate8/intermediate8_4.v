module full_adder_16bit(
    input [15:0] A, // 16-bit input A
    input [15:0] B, // 16-bit input B
    input cin,      // input carry
    output [15:0] S, // 16-bit sum output
    output cout     // output carry
);

wire [16:0] c; // carry signals

// Implementing 16 full adders in parallel
// Using generate statement to reduce code redundancy
genvar i;
generate
    for(i=0; i<16; i=i+1) begin : gen_full_adder
        full_adder FA (
            .a(A[i]),
            .b(B[i]),
            .cin(c[i]),
            .s(S[i]),
            .cout(c[i+1])
        );
    end
endgenerate

assign c[0] = cin; // setting the initial carry input

assign cout = c[16]; // output carry from the last full adder

endmodule

module definition
module full_adder (
    input a,   // input A
    input b,   // input B
    input cin, // input carry
    output s,  // sum output
    output cout // output carry
);

assign s = (a ^ b) ^ cin; // sum output equation
assign cout = (a & b) | ((a ^ b) & cin); // carry output equation

endmodule
