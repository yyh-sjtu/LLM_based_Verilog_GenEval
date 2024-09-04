
module TopModule(
    input [255:0] in,
    input [7:0] sel,
    output out
);

reg [255:0] out_mux;

always @(*)
begin
    case(sel)
        0: out_mux = in[0];
        1: out_mux = in[1];
        2: out_mux = in[2];
        // Add cases for selecting inputs in[3] to in[255]
        default: out_mux = 1'b0; // Default output value when sel is out of range
    endcase
end

assign out = out_mux;

endmodule