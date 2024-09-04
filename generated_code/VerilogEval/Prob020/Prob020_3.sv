
module TopModule (
    input [1:0] A,  // 2-bit input A
    input [1:0] B,  // 2-bit input B
    output z        // output z
);

    // Compare the two 2-bit inputs and assign the result to output z
    assign z = (A == B) ? 1'b1 : 1'b0;

endmodule