
module freq_div (
    input wire CLK_in,
    input wire RST,
    output reg CLK_50,
    output reg CLK_10,
    output reg CLK_1
);

reg [3:0] cnt_10;
reg [6:0] cnt_100;

always @(posedge CLK_in or posedge RST) begin
    if (RST) begin
        CLK_50 <= 1'b0;
        CLK_10 <= 1'b0;
        CLK_1 <= 1'b0;
        cnt_10 <= 4'b0000;
        cnt_100 <= 7'b0000000;
    end else begin
        // CLK_50 generation
        CLK_50 <= ~CLK_50;
    
        // CLK_10 generation
        if (cnt_10 == 4'b0100) begin
            CLK_10 <= ~CLK_10;
            cnt_10 <= 4'b0000;
        end else begin
            cnt_10 <= cnt_10 + 1;
        end
        
        // CLK_1 generation
        if (cnt_100 == 7'b0110001) begin
            CLK_1 <= ~CLK_1;
            cnt_100 <= 7'b0000000;
        end else begin
            cnt_100 <= cnt_100 + 1;
        end
    end
end

endmodule