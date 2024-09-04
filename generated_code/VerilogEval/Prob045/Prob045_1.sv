
module TopModule (
    input clk,
    input [7:0] in,
    input [7:0] anyedge,
    output reg [7:0] out
);

reg [7:0] last_in;

always @(posedge clk) begin
    last_in <= in;
    out <= 0;

    for (int i=0; i<8; i=i+1) begin
        if (last_in[i] == 0 && in[i] == 1) begin
            out[i] <= 1;
        end
    end
end

endmodule