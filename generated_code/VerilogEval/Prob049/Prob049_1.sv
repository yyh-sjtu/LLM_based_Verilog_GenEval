
module TopModule (
    input  wire clk,   // Clock input
    input  wire ar,    // Asynchronous reset
    input  wire d,     // Data input
    output reg q       // Output
);

    // Asynchronous reset behavior
    always @(*) begin
        if (ar) begin
            q <= 1'b0;  // Reset output to 0
        end else begin
            q <= q;     // Maintain the current state
        end
    end
   
    // Positive edge triggered behavior
    always @(posedge clk) begin
        if (!ar) begin
            q <= d;      // Capture input 'd' on positive clock edge
        end
    end

endmodule