
module TopModule (
    input in1,
    input in2,
    input in3,
    output reg out
);

always @(*) begin
    // Two-input XNOR gate
    wire xnor_out;
    assign xnor_out = in1 ^ in2;

    // Two-input XOR gate
    assign out = xnor_out ^ in3;
end

endmodule