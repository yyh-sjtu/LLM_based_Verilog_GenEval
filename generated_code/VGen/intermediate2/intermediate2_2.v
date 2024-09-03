module counter( 
    input clk,
    input reset,
    output reg [3:0] q
); 

always @ (posedge clk) begin
    if (reset) begin
        q <= 4'b0001; // Initialize q to 1
    end else begin
        if (q == 4'b1100) begin
            q <= 4'b0001; // Reset to 1 if q reaches 12
        end else begin
            q <= q + 4'b0001; // Increment q by 1
        end
    end
end

endmodule

