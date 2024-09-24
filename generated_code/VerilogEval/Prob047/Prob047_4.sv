
module TopModule (
    input wire clk,
    input wire areset,
    input wire [7:0] d,
    output reg [7:0] q
);

    // 8 D flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000; // Reset output to 0
        end else begin
            q <= d; // Transfer input to output
        end
    end

endmodule