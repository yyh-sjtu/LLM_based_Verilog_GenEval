module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] d,
    output logic [7:0] q
);

    // Internal storage for the flip-flops
    logic [7:0] ff;

    // Always block for D flip-flops triggered by negative edge
    always_ff @(negedge clk or posedge reset) begin
        if (reset) begin
            ff <= 8'h34; // Reset to 0x34 on active high reset
        end else begin
            ff <= d; // Capture input on the negative edge of clk
        end
    end
    
    // Assigning the output
    assign q = ff;

endmodule

