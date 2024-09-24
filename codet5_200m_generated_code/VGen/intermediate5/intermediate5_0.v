module left_rotate (
    input clk,
    input reset,
    input [2:0] amount,
    input [7:0] data,
    input load,
    output reg [7:0] out
);
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
        end else begin
            if (load) begin
                out <= data;
            end else begin
                out <= out + (amount >> 1);
            end
        end
    end
endmodule

