
module TopModule (
    input  [254:0] in,   // 255-bit input
    output [7:0] out     // 8-bit output
);

wire [7:0] count[0:31]; // Array to store intermediate counts
wire [7:0] sum0, sum1;  // Intermediate sums

// Population counting in a hierarchical manner
// Level 1: Count 8 groups of 32 bits
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin: count_32
        assign count[i] = in[i*32 +: 32][0] + in[i*32 +: 32][1] + 
                          in[i*32 +: 32][2] + in[i*32 +: 32][3] + 
                          in[i*32 +: 32][4] + in[i*32 +: 32][5] + 
                          in[i*32 +: 32][6] + in[i*32 +: 32][7] + 
                          in[i*32 +: 32][8] + in[i*32 +: 32][9] + 
                          in[i*32 +: 32][10] + in[i*32 +: 32][11] + 
                          in[i*32 +: 32][12] + in[i*32 +: 32][13] + 
                          in[i*32 +: 32][14] + in[i*32 +: 32][15] + 
                          in[i*32 +: 32][16] + in[i*32 +: 32][17] + 
                          in[i*32 +: 32][18] + in[i*32 +: 32][19] + 
                          in[i*32 +: 32][20] + in[i*32 +: 32][21] + 
                          in[i*32 +: 32][22] + in[i*32 +: 32][23] + 
                          in[i*32 +: 32][24] + in[i*32 +: 32][25] + 
                          in[i*32 +: 32][26] + in[i*32 +: 32][27] + 
                          in[i*32 +: 32][28] + in[i*32 +: 32][29] + 
                          in[i*32 +: 32][30] + in[i*32 +: 32][31];
    end
endgenerate 

// Level 2: Sum the intermediate counts
assign sum0 = count[0] + count[1] + count[2] + count[3] + count[4] + count[5];
assign sum1 = count[6] + count[7];

// Final count (8-bit result)
assign out = sum0 + sum1;

endmodule