
module TopModule (
    input  wire a,  // Input port 'a'
    input  wire b,  // Input port 'b'
    input  wire c,  // Input port 'c'
    output wire w,  // Output port 'w' (connected to 'a')
    output wire x,  // Output port 'x' (connected to 'b')
    output wire y,  // Output port 'y' (connected to 'b')
    output wire z   // Output port 'z' (connected to 'c')
);

// Assignments to connect inputs to outputs
assign w = a;  // Connect input 'a' to output 'w'
assign x = b;  // Connect input 'b' to output 'x'
assign y = b;  // Connect input 'b' to output 'y'
assign z = c;  // Connect input 'c' to output 'z'

endmodule