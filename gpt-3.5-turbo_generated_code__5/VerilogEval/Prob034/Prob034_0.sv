module TopModule (
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

reg [7:0] dff[7:0];

always @(posedge clk) begin
    for (int i = 0; i < 8; i++) begin
        dff[i] <= d[i];
    end
end

assign q = dff;

endmodule

