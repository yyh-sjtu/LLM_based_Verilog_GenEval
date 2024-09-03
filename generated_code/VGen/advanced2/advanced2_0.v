module that counts from 0 through 9 when the slowena signal is high:

```
module count_slow (
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q
);

// Internal register to store the count value
reg [3:0] count;

// Synchronous reset condition
always @(posedge clk or posedge reset) begin
    if (reset) begin
        count <= 4'd0;
    end else begin
        if (slowena) begin
            // Increment count if slowena is high
            count <= count + 1;
        end
    end
end

// Output the count value
assign q = count;

endmodule

