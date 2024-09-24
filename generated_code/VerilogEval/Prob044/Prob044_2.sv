
module TopModule (
    input  logic [2:0] a,               // 3-bit input a
    input  logic [2:0] b,               // 3-bit input b
    output logic [2:0] out_or_bitwise,  // 3-bit output for bitwise OR
    output logic out_or_logical,         // output for logical OR
    output logic [5:0] out_not           // 6-bit output for NOT operations
);

    // Compute bitwise OR of a and b
    assign out_or_bitwise = a | b;
    
    // Compute logical OR of a and b
    assign out_or_logical = |{a, b};  // Combine the inputs into one vector
    
    // Compute NOT of a and b
    assign out_not = {~b, ~a};  // Upper half is ~b, lower half is ~a

endmodule