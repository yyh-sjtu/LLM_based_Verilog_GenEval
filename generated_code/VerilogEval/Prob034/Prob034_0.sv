
module TopModule (
    input  clk,
    input  [7:0] d,
    output reg [7:0] q
);

reg [7:0] dff [7:0];

always @(posedge clk) begin
    // Update each D flip-flop with corresponding input
    for (int i = 0; i < 8; i = i + 1) begin
        dff[i] <= d[i];
    end
end

// Assign output q with values stored in D flip-flops
always @* begin
    for (int i = 0; i < 8; i = i + 1) begin
        q[i] = dff[i];
    end
end

endmodule