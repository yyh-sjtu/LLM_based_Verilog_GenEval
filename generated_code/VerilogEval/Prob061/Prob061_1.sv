
module TopModule (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg Q_next;

always @ (posedge clk) begin
    if (E) begin
        if (L) begin
            Q <= R;
        end else begin
            Q <= w;
        end
    end
end

endmodule