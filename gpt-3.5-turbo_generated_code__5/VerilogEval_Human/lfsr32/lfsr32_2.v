module top_module(
    input clk,
    input reset,
    output reg [31:0] q);
    
    // Internal signals
    reg [31:0] feedback;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Reset the output
            feedback <= 32'h1; // Reset the feedback
        end
        else begin
            feedback[0] <= q[31] ^ q[21] ^ q[1] ^ q[0]; // XOR operation at taps
            feedback[31:1] <= q[30:0]; // Shift the feedback
            
            q <= feedback; // Update the output with feedback
        end
    end
    
endmodule

