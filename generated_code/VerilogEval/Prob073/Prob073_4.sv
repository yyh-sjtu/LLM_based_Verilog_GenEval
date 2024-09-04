
module TopModule (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);

reg [15:0] registers;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        registers <= 16'b0;
    end else begin
        if (byteena[0]) begin
            registers[7:0] <= d[7:0];
        end
        if (byteena[1]) begin
            registers[15:8] <= d[15:8];
        end
    end
end

assign q = registers;

endmodule