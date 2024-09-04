
module TopModule (
    input  clk,
    input  reset,
    input  [31:0] in,
    output reg [31:0] out
);

reg [31:0] captured_data;

always @(posedge clk) begin
    if (reset) begin
        captured_data <= 32'b0;
    end else begin
        for (int i=0; i<32; i=i+1) begin
            if (in[i] && ~captured_data[i]) begin
                captured_data[i] <= 1;
            end else begin
                captured_data[i] <= 0;
            end
        end
    end
end

always @(posedge clk) begin
    if (reset) begin
        out <= 32'b0;
    end else begin
        out <= captured_data;
    end
end

endmodule