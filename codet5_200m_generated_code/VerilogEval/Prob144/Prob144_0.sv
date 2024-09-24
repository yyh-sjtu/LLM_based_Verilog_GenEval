module TopModule (
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q
);
    reg [255:0] grid [0:15];
    reg [255:0] grid_q;
    initial
    begin
        grid_q = 256'h00000000;
        grid_q[0] = 256'h00000000;
        grid_q[1] = 256'h00000000;
        grid_q[2] = 256'h00000000;
        grid_q[3] = 256'h00000000;
        grid_q[4] = 256'h00000000;
        grid_q[5] = 256'h00000000;
        grid_q[6] = 256'h00000000;
        grid_q[7] = 256'h00000000;
        grid_q[8] = 256'h00000000;
        grid_q[9] = 256'h00000000;
        grid_q[10] = 256'h00000000;
        grid_q[11] = 256'h00000000;
        grid_q[12] = 256'h00000000;
        grid_q[13] = 256'h00000000;
        grid_q[14] = 256'h00000000;
        grid_q[15] = 256'h00000000;
        grid_q[16] = 256'h00000000;
        grid_q[17] = 256'h00000000;
        grid_q[18] = 256'h00000000;
        grid_q[19] = 256'h00000000;
        grid_q[20] = 256'h00000000;
        grid_q[21] = 256'h00000000;
        grid_q[22] = 256'h00000000;
        grid_q[23] = 256'h00000000;
        grid_q[24] = 256'h00000000;
        grid_q[25] = 256'h00000000;
        grid_q[26] = 256'h00000000;
        grid_q[27] = 256'h00000000;
        grid_q[28] = 256'h00000000;
        grid_q[29] = 256'h00000000;
        grid_q[30] = 256'h00000000;
        grid_q[31] = 256'h00000000;
        grid_q[32] = 256'h00000000;
        grid_q[33] = 256'h00000000;
        grid_q[34] = 256'h00000000;
        grid_q[35] = 256'h00000000;
        grid_q[36] = 256'h00000000;
        grid_q[37] = 256'h00000000;
        grid_q[38] = 256'h00000000;
        grid_q[39] = 256'h00000000;
        grid_q[40] = 256'h00000000;
        grid_q[41] = 256'h00000000;
        grid_q[42] = 256'h00000000;
        grid_q[43] = 256'h00000000;
        grid_q[44] = 256'h00000000;
        grid_q[45] = 256'h00000000;
        grid_q[45] = 256'h00000000;
        grid_q[45] = 256'h00000000;
        grid_q[45] = 256'h00000000;
        grid_q[45] = 256'h00000000;
    end
    always @(posedge clk)
    begin
        if (load)
            grid[0] <= data;
        else
            grid[0] <= grid[0];
    end
endmodule

