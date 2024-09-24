
module TopModule (
    input  wire clk,           // Clock input
    input  wire areset,       // Asynchronous reset input
    input  wire [7:0] d,      // 8-bit input data
    output reg  [7:0] q       // 8-bit output data
);

    // D Flip-flops with active high asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 8'b00000000; // Reset output to 0 when areset is high
        end else begin
            q <= d; // Transfer input d to output q on rising clock edge
        end
    end

endmodule