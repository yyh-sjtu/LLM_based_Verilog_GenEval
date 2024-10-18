module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    
reg temp;

always @(posedge clk) begin
    if (E)
        temp <= w;  // Shift if Enable is high
    else if (L)
        temp <= R;  // Load if Load is high
end

always @(posedge clk) begin
    if (L)
        Q <= R;  // Output the loaded value if Load is high
    else
        Q <= temp;  // Output the shifted value
end

endmodule

