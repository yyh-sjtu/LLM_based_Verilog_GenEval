
module TopModule(
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @(*) begin
    case(sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        // Add more cases for sel = 3, 4, ..., 255 if needed
        default: out = 4'b0000; // Default case, outputs all zeros
    endcase
end

endmodule