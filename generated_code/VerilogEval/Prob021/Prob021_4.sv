module TopModule (
    input  logic [1023:0] in,    // 1024-bit input
    input  logic [7:0]   sel,    // 8-bit select input
    output logic [3:0]   out     // 4-bit output
);

    // Calculate the starting index of the selected 4-bit input
    logic [9:0] index; // 8-bit sel + 2 bits for 4-bit word width
    assign index = sel << 2; // Multiply sel by 4 to get the correct index in the 1024 bits

    // Assign the output based on the selected portion of the input
    assign out = in[index +: 4];  // Grab 4 bits starting from index

endmodule

