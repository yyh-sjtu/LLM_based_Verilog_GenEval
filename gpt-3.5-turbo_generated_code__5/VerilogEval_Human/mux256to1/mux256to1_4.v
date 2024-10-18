module mux_256to1 (
    input [255:0] in,
    input [7:0] sel,
    output reg out
);

always @ (*) begin
    case (sel)
        8'd0: out = in[0];
        8'd1: out = in[1];
        8'd2: out = in[2];
        // Continue this pattern for all 256 input selections
        default: out = 1'b0; // Default value if sel is out of range
    endcase
end

endmodule

module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

mux_256to1 mux_inst (
    .in(in),
    .sel(sel),
    .out(out)
);

endmodule

