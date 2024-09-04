
module freq_div (
    input CLK_in,
    input RST,
    output reg CLK_50,
    output reg CLK_10,
    output reg CLK_1
);

reg [1:0] cnt_10;
reg [5:0] cnt_100;

always @(posedge CLK_in or posedge RST) begin
    if(RST) begin
        CLK_50 <= 0;
        CLK_10 <= 0;
        cnt_10 <= 2'b00;
        CLK_1 <= 0;
        cnt_100 <= 6'b000000;
    end else begin
        // CLK_50 generation
        if(cnt_10[1]) begin
            CLK_50 <= ~CLK_50;
        end
        // CLK_10 generation
        if(cnt_10 == 4'd4) begin
            CLK_10 <= ~CLK_10;
            cnt_10 <= 2'b00;
        end else begin
            cnt_10 <= cnt_10 + 1'b1;
        end
        // CLK_1 generation
        if(cnt_100 == 6'd49) begin
            CLK_1 <= ~CLK_1;
            cnt_100 <= 6'b000000;
        end else begin
            cnt_100 <= cnt_100 + 1'b1;
        end
    end
end

endmodule