module d_ff (
    input wire clk,
    input wire d,
    input wire ar,
    output logic q
);

    always @ (posedge clk or negedge ar) begin
        if (ar == 0)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule

module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

    d_ff dff (
        .clk(clk),
        .d(d),
        .ar(ar),
        .q(q)
    );

endmodule

