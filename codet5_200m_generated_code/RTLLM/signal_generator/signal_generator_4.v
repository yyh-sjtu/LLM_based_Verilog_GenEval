module signal_generator (
	input clk,
	input rst_n,
	output [4:0] wave
);
    reg [4:0] count;
    always @(posedge clk or negedge rst_n)
        if (!rst_n)
            count <= 0;
        else
            count <= count + 1;
    assign wave = count;
endmodule

