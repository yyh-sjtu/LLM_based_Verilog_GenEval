
module TopModule (
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] pedge
);

    // Reg to hold the previous state of the input
    reg [7:0] in_prev;

    always @(posedge clk) begin
        // Detect positive edges
        pedge <= (in & ~in_prev);  // Set pedge to 1 where in is 1 and in_prev is 0
        in_prev <= in;              // Update previous input state
    end

endmodule