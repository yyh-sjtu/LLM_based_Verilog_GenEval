module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] in_prev; // Holds previous cycle's input values
    
    always @(posedge clk) begin
        in_prev <= in; // Store current cycle's input values
        
        // Detect any edge in each bit of the input vector
        for (int i=0; i<8; i=i+1) begin
            if (in[i] & ~in_prev[i])
                anyedge[i] <= 1; // Set the output bit the cycle after a 0 to 1 transition occurs
            else
                anyedge[i] <= 0;
        end
    end
endmodule

