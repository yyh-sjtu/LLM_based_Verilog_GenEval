
module TopModule (
    input wire clk,
    input wire reset,
    input wire [7:0] d,
    output reg [7:0] q
);

    // D flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b0; // Set q to zero if reset is active
        end else begin
            q <= d; // Update q with the value of d
        end
    end

endmodule