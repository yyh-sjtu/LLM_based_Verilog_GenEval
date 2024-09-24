module TopModule (
    input clk,
    input reset,
    input j,
    input k,
    output out
);
    parameter STATE_0 = 2'b00;
    parameter STATE_1 = 2'b01;
    reg [1:0] m;
    reg [1:0] q;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 0;
        end else begin
            if (q) begin
                q <= m;
                m <= 0;
            end
        end
    end
    assign out = q;
endmodule

