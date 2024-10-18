
module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case(x)
        4'b0000: f = 1; // Corresponding to the entry 11 in K-map
        4'b0001: f = 0; // Corresponding to the entry 01 in K-map
        4'b0010: f = 1; // Corresponding to the entry 11 in K-map
        4'b0011: f = 0; // Corresponding to the entry 10 in K-map
        4'b0110: f = 1; // Corresponding to the entry 11 in K-map
        4'b1000: f = 1; // Corresponding to the entry 11 in K-map
        4'b1001: f = 1; // Corresponding to the entry 11 in K-map
        default: f = 0; // Don't care entries can output any value, so choose 0 as default
    endcase
end

endmodule