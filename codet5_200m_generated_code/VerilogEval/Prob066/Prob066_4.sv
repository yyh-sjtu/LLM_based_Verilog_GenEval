module TopModule (
	input clk,
	input reset,
	input [31:0] in,
	output [31:0] out
);
    reg [31:0] in_1;
    reg [31:0] in_2;
    reg [31:0] in_3;
    reg [31:0] in_4;
    reg [31:0] in_5;
    reg [31:0] in_6;
    reg [31:0] in_7;
    reg [31:0] in_8;
    reg [31:0] in_9;
    reg [31:0] in_10;
    reg [31:0] in_11;
    reg [31:0] in_12;
    reg [31:0] in_13;
    reg [31:0] in_14;
    reg [31:0] in_15;
    reg [31:0] in_16;
    reg [31:0] in_17;
    reg [31:0] in_18;
    reg [31:0] in_19;
    reg [31:0] in_20;
    reg [31:0] in_21;
    reg [31:0] in_22;
    reg [31:0] in_23;
    reg [31:0] in_24;
    reg [31:0] in_25;
    reg [31:0] in_26;
    reg [31:0] in_27;
    reg [31:0] in_28;
    reg [31:0] in_29;
    reg [31:0] in_30;
    reg [31:0] in_31;
    reg [31:0] in_30;
    reg [31:0] in_31;
    reg [31:0] in_31;
    reg [31:0] in_31;
    assign out = in_1 | in_2 | in_3 | in_4 | in_5 | in_6 | in_7;
    always @ (posedge clk) begin
        if(reset) begin
            in_1 <= 32'h000000000000000000000000;
            in_2 <= 32'h000000000000000000000000;
            in_3 <= 32'h000000000000000000000000;
            in_4 <= 32'h000000000000000000000000;
            in_5 <= 32'h000000000000000000000000;
            in_6 <= 32'h000000000000000000000000;
            in_7 <= 32'h000000000000000000000000;
            in_8 <= 32'h000000000000000000000000;
            in_9 <= 32'h00000000000000000000000000000000;
        end
        else begin
            if(in_7) begin
                in_1 <= in_5;
                in_2 <= in_6;
                in_3 <= in_7;
                in_4 <= in_8;
                in_5 <= in_9;
                in_6 <= in_10;
                in_7 <= in_11;
            end
            if(in_8) begin
                in_4 <= in_12;
                in_5 <= in_11;
                in_6 <= in_12;
            end
        end
    end
endmodule

