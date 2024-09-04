module in Verilog:

```Verilog
module TopModule (
    input clk,
    input [7:0] in,
    input [7:0] anyedge,
    output [7:0] out
);

reg [7:0] prev_anyedge;

always @(posedge clk) begin
    for (int i = 0; i < 8; i = i + 1) begin
        if (anyedge[i] & ~prev_anyedge[i] & (in[i] == 1)) begin
            out[i] <= 1;
        end else begin
            out[i] <= 0;
        end
    end
    
    prev_anyedge <= anyedge;
end

endmodule

