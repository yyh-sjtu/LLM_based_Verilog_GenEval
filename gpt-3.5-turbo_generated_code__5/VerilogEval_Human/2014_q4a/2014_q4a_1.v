module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    
    reg Q_temp;
    
    always @(posedge clk) begin
        if (E) begin
            if (L)
                Q_temp <= R;
            else
                Q_temp <= (w & Q);
        end
    end
    
    always @(posedge clk) begin
        if (E) begin
            Q <= Q_temp;
        end
    end
endmodule

