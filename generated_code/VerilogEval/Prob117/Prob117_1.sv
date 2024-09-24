
module TopModule (
    input  clk,
    input  a,
    output reg [2:0] q
);
    
    always @(posedge clk) begin
        if (a) begin
            // Keep current value when a is 1
            q <= q;  // Redundant, can be omitted but keeps same value
        end else begin
            // Increment q when a is 0, with wrap-around at 7
            if (q == 3'b111) begin
                q <= 3'b000; // Wrap-around
            end else begin
                q <= q + 1;
            end
        end
    end

endmodule