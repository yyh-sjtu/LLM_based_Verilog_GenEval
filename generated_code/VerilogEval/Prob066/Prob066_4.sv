
module TopModule(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] last_in;

always @(posedge clk) begin
    if (reset) begin
        out <= 0;
        last_in <= 32'd0;
    end else begin
        for (int i = 0; i < 32; i = i + 1) begin
            if ((last_in[i] == 1) && (in[i] == 0)) begin
                out[i] <= 1;
            end else begin
                out[i] <= 0;
            end
        end
        last_in <= in;
    end
end

endmodule