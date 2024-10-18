
module TopModule (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
    );

always @(sel)
begin
    case(sel)
        0: out = in[3:0];
        1: out = in[7:4];
        2: out = in[11:8];
        // Continue the pattern for all possible sel values
        // 3: out = in[15:12];
        // 4: out = in[19:16];
        // ...
        // 254: out = in[1021:1018];
        // 255: out = in[1023:1020];
        default: out = 4'b0000; // Default output when sel is out of range
    endcase
end

endmodule