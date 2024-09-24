
module TopModule (
    input  wire clk,
    input  wire reset,
    input  wire [7:0] d,
    output reg [7:0] q
);
    
    // D flip-flop for each bit (0-7)
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'b00000000;  // Set output q to zero on reset
        end else begin
            q <= d;            // On positive clk edge, assign input d to output q
        end
    end
    
endmodule