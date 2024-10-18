
module TopModule (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

always @ (sel)
begin
    case (sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        // Add cases for sel=3 to sel=255
        // Each case should specify the corresponding bit range of the input vector.
        default: out = 4'b0; // Default case if sel is out of range.
    endcase
end

endmodule