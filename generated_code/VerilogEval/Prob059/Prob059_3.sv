
module TopModule (
    input   wire a,  // Input a
    input   wire b,  // Input b
    input   wire c,  // Input c
    output  wire w,  // Output w
    output  wire x,  // Output x
    output  wire y,  // Output y
    output  wire z   // Output z
);

    // Assign inputs to outputs as specified
    assign w = a;  // Connect input a to output w
    assign x = b;  // Connect input b to output x
    assign y = b;  // Connect input b to output y
    assign z = c;  // Connect input c to output z

endmodule