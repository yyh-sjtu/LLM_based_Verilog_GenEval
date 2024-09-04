
module TopModule (
    input  [7:0] in,   // 8-bit input
    output reg [2:0] pos // 3-bit output
);

// Always block to describe the functionality
always @* begin
    // Default output to 3'b000 (zero)
    pos = 3'b000; 
    
    // Check each bit from LSB to MSB
    if (in[0]) pos = 3'd0;   // If bit 0 is high
    else if (in[1]) pos = 3'd1; // If bit 1 is high
    else if (in[2]) pos = 3'd2; // If bit 2 is high
    else if (in[3]) pos = 3'd3; // If bit 3 is high
    else if (in[4]) pos = 3'd4; // If bit 4 is high
    else if (in[5]) pos = 3'd5; // If bit 5 is high
    else if (in[6]) pos = 3'd6; // If bit 6 is high
    else if (in[7]) pos = 3'd7; // If bit 7 is high
end

endmodule