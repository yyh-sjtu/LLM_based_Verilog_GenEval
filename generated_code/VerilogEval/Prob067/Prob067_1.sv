

module TopModule (
    input clk,
    input reset,
    input slowena,
    output reg [3:0] q
);

// Internal signals
reg [3:0] count;

// Sequential logic
always @(posedge clk) begin
    if (reset) begin
        count <= 4'b0000;
    end else if (slowena) begin
        if (count == 4'b1001) begin
            count <= 4'b0000;
        end else begin
            count <= count + 1;
        end
    end
end

// Output assignment
assign q = count;

endmodule
