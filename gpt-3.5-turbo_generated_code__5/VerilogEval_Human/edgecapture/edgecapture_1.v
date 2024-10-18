module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] in_last;

always @(posedge clk or posedge reset) begin
    if (reset)
        in_last <= 32'b0;
    else begin
        in_last <= in;
        for (integer i=0; i<32; i=i+1) begin
            if (in_last[i] & !in[i])
                out[i] <= 1'b1;
            else
                out[i] <= 1'b0;
        end
    end
end

endmodule

