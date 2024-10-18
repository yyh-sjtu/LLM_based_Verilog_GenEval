
module TopModule (
    input clk,   // Clock input
    input w,     // Input from previous stage
    input R,     // Value to load
    input E,     // Enable shift
    input L,     // Load enable
    output Q     // Output
);

reg Q;          // Output register
reg D;          // Data input register

always @(posedge clk) begin
    if (E) begin
        if (L) begin
            Q <= R;            // Load value
        end else begin
            Q <= w;            // Shift
        end
    end else begin
        Q <= 1'b0;            // Reset Q
    end
end

endmodule