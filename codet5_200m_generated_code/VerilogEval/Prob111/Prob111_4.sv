module TopModule (
    input clk,
    input reset,
    input j,
    input k,
    output out
);
    parameter [31:0] STATE_START = 2'b00;
    parameter [31:0] STATE_FINISH = 2'b01;
    reg [31:0] s2;
    reg [31:0] s3;
    initial
    begin
        s2 = STATE_START;
    end
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            s3 <= STATE_FINISH;
        else
            s3 <= j;
    end
    assign out = s2[1];
endmodule

