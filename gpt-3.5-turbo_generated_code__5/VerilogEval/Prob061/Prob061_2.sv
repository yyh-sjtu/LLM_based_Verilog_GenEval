
module TopModule(
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

// Sequential logic triggered on positive edge of clock
always @(posedge clk) begin
    if (E) begin
        if (L) begin
            Q <= R;
        end else begin
            Q <= w;
        end
    end
end

endmodule