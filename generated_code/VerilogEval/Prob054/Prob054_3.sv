
module TopModule (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
    prev_in <= in;
    pedge <= 8'b0;
    
    for (int i = 0; i < 8; i = i + 1) begin
        if (prev_in[i] == 1 && in[i] == 0) begin
            pedge[i] <= 1;
        end
    end
end

endmodule